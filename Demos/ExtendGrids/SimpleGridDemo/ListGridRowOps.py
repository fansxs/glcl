# -*- coding: utf-8 -*-
"""
ListGridRowOps.py  -  P4DListGrid "增行 / 删行 / 清空行" 的安全实现 (Python 端规避方案)

======================================================================================
 背景: 为什么需要它
======================================================================================
glcl 内置的 P4DListGrid.AddRow() / DeleteRow() 在 "增 -> 删 -> 再增" 时会触发:

    TypeError: "AddRow" called with invalid arguments.
    Error: Access violation at address ... in module 'glcl.pyd'. Read of address 0000000000000000

原因 (根据 Delphi 源码 uSimpleGrid.pas 推断, 未能在 Delphi 环境中复现):

  1. TStripeGrid.DeleteRow 直接调用 TStringGrid.DeleteRow 缩减行数。此时被删行单元格里的
     Objects[] (指向 TCellProp 的指针) 仍留在网格内部;
  2. 紧接着 LoadParams -> ClearAllCellProps 把所有 TCellProp 释放, 但它只会把"当前存在的行"
     的 Objects 置 nil, 刚被删掉的那一行已经不在范围内, 指针成了悬空指针;
  3. 再次 AddRow 时 RowCount + 1, 这一行重新出现, TStripe.LoadParam 读到的 Objects 不是 nil
     而是已释放的对象, 访问它的 FComboBox 时发生 Access violation。

  (ClearRows 和网格右键菜单里的 "删除鼠标所在的行" 走的是同一条缩减行数的路径, 同样有问题。)

======================================================================================
 本模块的做法
======================================================================================
不调用 AddRow / DeleteRow / ClearRows, 而是:

    ① 用 Get*/ 读出网格当前所有行的值 (快照, 此时用户刚编辑的内容也在里面);
    ② 在 Python 里算出 "增 / 删 / 清空" 之后应有的行数据;
    ③ 直接改写 ini 文件里 "<列名>_<行号>" 与 StripeRowCount 这些键;
    ④ 调用 LoadListGrid() 让 glcl 整表重建。

LoadListGrid() 在重建时 "先释放全部单元格属性(此时行数还没变), 再改行数, 再装载数据",
这是程序启动时就在使用的、已被验证的路径, 不会留下悬空指针。

======================================================================================
 使用前提
======================================================================================
  * 网格的列定义 (ident / 类型) 需要传进来, 因为 ini 里的键名由列名决定;
  * ini 文件由 Windows 的 INI API 读写 (Delphi TIniFile), 本模块按"系统 ANSI 代码页"编码读写,
    与它保持一致, 并且只修改需要修改的行, 其余内容原样保留。
"""
import os
import sys

# 与 Delphi 源码 uSimpleGrid.pas 中的常量一致
STRIPE_ROW_COUNT_KEY = 'StripeRowCount'


# ----------------------------------------------------------------------------
# ini 文件的最小编辑器
# ----------------------------------------------------------------------------
class IniEditor:
    """
    只做三件事: 读取键值 / 写入键值 / 删除键, 并且尽量不改动文件里的其他内容。

    * 节名、键名不区分大小写 (与 Windows INI API 一致);
    * 写入时保留原有的行顺序、注释和未涉及的键;
    * 编码: 有 UTF-8 BOM 用 utf-8-sig, 有 UTF-16 BOM 用 utf-16, 否则 Windows 下按系统 ANSI
      代码页(mbcs), 其他平台按 utf-8; 如果按上述方式解码失败, 退回 latin-1(逐字节无损往返),
      保证绝不会因为编码问题破坏文件。
    """

    def __init__(self, path):
        self.path = path
        self.encoding = 'mbcs' if os.name == 'nt' else 'utf-8'
        self.lines = []
        self._load()

    # ---- 读文件 ----
    def _load(self):
        if not os.path.exists(self.path):
            self.lines = []
            return
        with open(self.path, 'rb') as f:
            raw = f.read()
        if raw.startswith(b'\xff\xfe') or raw.startswith(b'\xfe\xff'):
            self.encoding = 'utf-16'
        elif raw.startswith(b'\xef\xbb\xbf'):
            self.encoding = 'utf-8-sig'
        try:
            text = raw.decode(self.encoding)
        except (UnicodeDecodeError, LookupError):
            self.encoding = 'latin-1'
            text = raw.decode('latin-1')
        self.lines = text.splitlines()

    # ---- 查找 ----
    @staticmethod
    def _is_section(line):
        s = line.strip()
        return s.startswith('[') and s.endswith(']')

    def _section_range(self, section):
        """返回 (标题行下标, 下一个节标题的下标或文件末尾); 找不到返回 None"""
        want = '[%s]' % section.lower()
        start = None
        for i, line in enumerate(self.lines):
            if self._is_section(line):
                if start is not None:
                    return start, i
                if line.strip().lower() == want:
                    start = i
        if start is not None:
            return start, len(self.lines)
        return None

    def _find_key(self, section, key):
        """返回键所在行的下标, 找不到返回 -1"""
        rng = self._section_range(section)
        if rng is None:
            return -1
        for i in range(rng[0] + 1, rng[1]):
            s = self.lines[i].strip()
            if not s or s.startswith(';') or '=' not in s:
                continue
            if s.split('=', 1)[0].strip().lower() == key.lower():
                return i
        return -1

    # ---- 对外接口 ----
    def get(self, section, key, default=''):
        i = self._find_key(section, key)
        if i < 0:
            return default
        return self.lines[i].split('=', 1)[1]

    def set(self, section, key, value):
        value = str(value)
        i = self._find_key(section, key)
        if i >= 0:
            # 保留原来的键名写法, 只替换值
            old_key = self.lines[i].split('=', 1)[0]
            self.lines[i] = '%s=%s' % (old_key, value)
            return
        rng = self._section_range(section)
        if rng is None:
            if self.lines and self.lines[-1].strip():
                self.lines.append('')
            self.lines.append('[%s]' % section)
            self.lines.append('%s=%s' % (key, value))
            return
        # 插在该节最后一个非空行之后
        pos = rng[1]
        while pos > rng[0] + 1 and not self.lines[pos - 1].strip():
            pos -= 1
        self.lines.insert(pos, '%s=%s' % (key, value))

    def delete(self, section, key):
        i = self._find_key(section, key)
        if i >= 0:
            del self.lines[i]

    def save(self):
        data = ('\r\n'.join(self.lines) + ('\r\n' if self.lines else '')).encode(self.encoding)
        d = os.path.dirname(self.path)
        if d and not os.path.isdir(d):
            os.makedirs(d)
        with open(self.path, 'wb') as f:
            f.write(data)


# ----------------------------------------------------------------------------
# 列定义 + 行快照
# ----------------------------------------------------------------------------
# 列定义: (ident, kind) 的列表, kind 为 'String' / 'Integer' / 'Boolean'
# 与 ListGrid1.AddColumn(ident, caption, kind, width) 中的 ident / kind 完全一致。


def _default_text(kind):
    """新增行时各类型列的默认值 (与 Delphi 版 TStripe 的默认值一致: 空串 / 0 / False)"""
    return '0' if kind.lower() in ('integer', 'boolean') else ''


def _snapshot(grid, columns):
    """
    读出网格当前所有数据行, 返回: [ {ident: 要写进 ini 的文本}, ... ]  (按 0 基行号排列)
    文本格式与 Delphi 的 SaveParam 写入 ini 的格式完全一致:
        String  -> 原文本;  Integer -> 十进制整数(下拉框列为选中项序号);  Boolean -> '1' / '0'
    """
    rows = []
    for r in range(grid.GetRowCount()):
        row = {}
        for ident, kind in columns:
            k = kind.lower()
            if k == 'integer':
                row[ident] = str(grid.GetCellInt(ident, r))
            elif k == 'boolean':
                row[ident] = '1' if grid.GetCellBool(ident, r) else '0'
            else:
                row[ident] = grid.GetCellString(ident, r)
        rows.append(row)
    return rows


def _write_rows_and_reload(grid, ini_path, section, columns, rows, old_count):
    """
    把 rows 作为网格的新内容写入 ini, 然后让网格整表重建。

    * 写 "<列名>_<行号>" 键 (0 基), 以及行数 StripeRowCount;
    * 删除多余的旧键 (行数变少时), 避免 ini 里残留过期数据, 日后再增行时被误读;
    * 最后 LoadListGrid() 重建网格。
    """
    ini = IniEditor(ini_path)
    for i, row in enumerate(rows):
        for ident, _kind in columns:
            ini.set(section, '%s_%d' % (ident, i), row[ident])
    for i in range(len(rows), max(old_count, len(rows))):
        for ident, _kind in columns:
            ini.delete(section, '%s_%d' % (ident, i))
    ini.set(section, STRIPE_ROW_COUNT_KEY, len(rows))
    ini.save()
    grid.LoadListGrid()


def _prepare(grid):
    """
    先让 glcl 把当前界面上的值(以及用户拖动过的列宽)写入 ini。
    之后本模块只改写 "<列名>_<行号>" 与行数, 列宽等其他键保持 glcl 写入的结果。
    """
    grid.SaveListGrid()


# ----------------------------------------------------------------------------
# 对外接口
# ----------------------------------------------------------------------------
def add_row(grid, ini_path, section, columns):
    """在末尾增加一行(各列为默认值), 返回新行的 0 基行号。 等价于 grid.AddRow()"""
    _prepare(grid)
    rows = _snapshot(grid, columns)
    old_count = len(rows)
    rows.append(dict((ident, _default_text(kind)) for ident, kind in columns))
    _write_rows_and_reload(grid, ini_path, section, columns, rows, old_count)
    return old_count


def delete_row(grid, ini_path, section, columns, row):
    """删除 0 基行号为 row 的行, 其后的行上移。 等价于 grid.DeleteRow(row)"""
    _prepare(grid)
    rows = _snapshot(grid, columns)
    old_count = len(rows)
    if row < 0 or row >= old_count:
        raise IndexError('DeleteRow: index out of range: %d' % row)
    del rows[row]
    if not rows:
        # 只剩一行时不删光, 恢复成一个默认值行 (保证表头固定行仍然有效)
        rows.append(dict((ident, _default_text(kind)) for ident, kind in columns))
    _write_rows_and_reload(grid, ini_path, section, columns, rows, old_count)


def clear_rows(grid, ini_path, section, columns):
    """清空所有行, 只保留一个默认值行。 等价于 grid.ClearRows()"""
    _prepare(grid)
    old_count = grid.GetRowCount()
    rows = [dict((ident, _default_text(kind)) for ident, kind in columns)]
    _write_rows_and_reload(grid, ini_path, section, columns, rows, old_count)
