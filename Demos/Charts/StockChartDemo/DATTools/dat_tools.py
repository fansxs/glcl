#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
StockChart DAT 文件工具包
=========================
用于读取、写入、转换 TStockChart 控件所使用的 .DAT 二进制数据文件。

文件格式（TStkDataRec, packed, little-endian）：
  偏移  大小  类型    字段
  ---   ---   ------  ----
   0    8     Double  Date（Delphi TDateTime，基准日 1899-12-30 的天数）
   8    4     Single  OP   开盘价
  12    4     Single  HP   最高价
  16    4     Single  LP   最低价
  20    4     Single  CP   收盘价
  24    4     Single  VOL  成交量
  共 28 字节/记录

文件布局：
  记录 [0]      : 文件头（1 条 TStkDataRec）
  记录 [1..N]   : 数据记录，按日期从旧到新排列
"""

import struct
import csv
import datetime
import os
import json
from typing import List, Tuple, Optional

# ── 常量 ──────────────────────────────────────────────────────────────────────
DELPHI_EPOCH = datetime.date(1899, 12, 30)
RECORD_FORMAT = '<d5f'   # little-endian: double + 5 floats
RECORD_SIZE   = 28       # bytes

# ── 类型别名 ──────────────────────────────────────────────────────────────────
DATRecord = Tuple[datetime.date, float, float, float, float, float]
# (date, open, high, low, close, volume)


# ═══════════════════════════════════════════════════════════════════════════════
#  日期转换
# ═══════════════════════════════════════════════════════════════════════════════

def date_to_delphi(d: datetime.date) -> float:
    """Python date -> Delphi TDateTime（距 1899-12-30 的天数）"""
    return float((d - DELPHI_EPOCH).days)


def delphi_to_date(val: float) -> datetime.date:
    """Delphi TDateTime -> Python date"""
    return DELPHI_EPOCH + datetime.timedelta(days=int(val))


# ═══════════════════════════════════════════════════════════════════════════════
#  DAT 文件读取
# ═══════════════════════════════════════════════════════════════════════════════

def read_dat(filepath: str) -> List[DATRecord]:
    """
    读取 .DAT 文件，返回数据记录列表（不含文件头）。
    每条记录: (date, open, high, low, close, volume)
    """
    records: List[DATRecord] = []
    with open(filepath, 'rb') as f:
        data = f.read()

    total = len(data) // RECORD_SIZE
    if total < 2:
        return records  # 只有文件头或空文件

    # 跳过记录 [0]（文件头），从记录 [1] 开始
    for i in range(1, total):
        offset = i * RECORD_SIZE
        raw = struct.unpack_from(RECORD_FORMAT, data, offset)
        date_val, op, hp, lp, cp, vol = raw
        try:
            d = delphi_to_date(date_val)
        except (ValueError, OverflowError):
            continue  # 跳过损坏记录
        records.append((d, float(op), float(hp), float(lp), float(cp), float(vol)))

    return records


def read_dat_with_header(filepath: str):
    """
    读取 .DAT 文件，同时返回文件头信息和数据记录。
    返回: (header_dict, records)
    """
    with open(filepath, 'rb') as f:
        data = f.read()

    total = len(data) // RECORD_SIZE
    header = {}
    if total >= 1:
        raw = struct.unpack_from(RECORD_FORMAT, data, 0)
        header = {
            'date': delphi_to_date(raw[0]).isoformat(),
            'op': raw[1], 'hp': raw[2], 'lp': raw[3],
            'cp': raw[4], 'vol': raw[5],
            'total_records': total - 1,
        }

    records: List[DATRecord] = []
    for i in range(1, total):
        offset = i * RECORD_SIZE
        raw = struct.unpack_from(RECORD_FORMAT, data, offset)
        date_val, op, hp, lp, cp, vol = raw
        try:
            d = delphi_to_date(date_val)
        except (ValueError, OverflowError):
            continue
        records.append((d, float(op), float(hp), float(lp), float(cp), float(vol)))

    return header, records


# ═══════════════════════════════════════════════════════════════════════════════
#  DAT 文件写入
# ═══════════════════════════════════════════════════════════════════════════════

def write_dat(filepath: str, records: List[DATRecord],
              header_ohlcv: Optional[Tuple] = None) -> int:
    """
    将数据记录写入 .DAT 文件。
    records  : [(date, open, high, low, close, volume), ...]，按日期从旧到新。
    header_ohlcv: 可选，文件头的 OHLCV 值（默认用第一条记录数据）。
    返回写入的数据记录条数。
    """
    if not records:
        raise ValueError("records 不能为空")

    # 确保按日期升序排列
    records = sorted(records, key=lambda r: r[0])

    # 构建文件头记录
    first = records[0]
    # 文件头的 Date = 第一条记录日期的前一天
    header_date = date_to_delphi(first[0] - datetime.timedelta(days=1))
    if header_ohlcv is None:
        # 默认：用第一条记录的 OHLCV
        hdr_op, hdr_hp, hdr_lp, hdr_cp, hdr_vol = first[1:]
    else:
        hdr_op, hdr_hp, hdr_lp, hdr_cp, hdr_vol = header_ohlcv

    with open(filepath, 'wb') as f:
        # 写文件头
        f.write(struct.pack(RECORD_FORMAT,
                            header_date,
                            float(hdr_op), float(hdr_hp),
                            float(hdr_lp), float(hdr_cp),
                            float(hdr_vol)))
        # 写数据记录
        for (d, op, hp, lp, cp, vol) in records:
            f.write(struct.pack(RECORD_FORMAT,
                                date_to_delphi(d),
                                float(op), float(hp),
                                float(lp), float(cp),
                                float(vol)))

    return len(records)


# ═══════════════════════════════════════════════════════════════════════════════
#  CSV ↔ DAT 转换
# ═══════════════════════════════════════════════════════════════════════════════

def csv_to_dat(csv_path: str, dat_path: str,
               date_col:  str = 'date',
               open_col:  str = 'open',
               high_col:  str = 'high',
               low_col:   str = 'low',
               close_col: str = 'close',
               vol_col:   str = 'volume',
               date_fmt:  str = '%Y-%m-%d',
               encoding:  str = 'utf-8') -> int:
    """
    从 CSV 文件转换到 .DAT 文件。

    CSV 列名通过参数指定，默认：
      date, open, high, low, close, volume

    date_fmt 支持任何 strptime 格式，例如：
      '%Y-%m-%d'   (默认)
      '%Y/%m/%d'
      '%Y%m%d'

    返回写入的记录条数。

    示例 CSV（第一行为标题）：
      date,open,high,low,close,volume
      2024-01-02,160.50,162.30,159.80,161.20,5234100
    """
    records: List[DATRecord] = []
    with open(csv_path, 'r', encoding=encoding, newline='') as f:
        reader = csv.DictReader(f)
        for row in reader:
            try:
                d   = datetime.datetime.strptime(row[date_col].strip(), date_fmt).date()
                op  = float(row[open_col])
                hp  = float(row[high_col])
                lp  = float(row[low_col])
                cp  = float(row[close_col])
                vol = float(row[vol_col])
            except (KeyError, ValueError) as e:
                print(f"  [跳过] 行解析失败: {row}  原因: {e}")
                continue
            records.append((d, op, hp, lp, cp, vol))

    if not records:
        raise ValueError(f"CSV 文件中没有可用记录: {csv_path}")

    return write_dat(dat_path, records)


def dat_to_csv(dat_path: str, csv_path: str,
               date_fmt: str = '%Y-%m-%d',
               encoding: str = 'utf-8') -> int:
    """
    将 .DAT 文件导出为 CSV 文件。
    返回导出的记录条数。
    """
    records = read_dat(dat_path)
    with open(csv_path, 'w', encoding=encoding, newline='') as f:
        writer = csv.writer(f)
        writer.writerow(['date', 'open', 'high', 'low', 'close', 'volume'])
        for (d, op, hp, lp, cp, vol) in records:
            writer.writerow([d.strftime(date_fmt),
                             f'{op:.4f}', f'{hp:.4f}',
                             f'{lp:.4f}', f'{cp:.4f}',
                             f'{vol:.4f}'])
    return len(records)


# ═══════════════════════════════════════════════════════════════════════════════
#  通达信 / 大智慧 DAY 文件转换
# ═══════════════════════════════════════════════════════════════════════════════

def tdx_day_to_dat(tdx_path: str, dat_path: str,
                   price_scale: float = 0.01,
                   vol_scale:   float = 0.01) -> int:
    """
    将通达信 .DAY 文件转换为 .DAT 文件。

    通达信日线格式（每条记录 32 字节，little-endian）：
      4  UInt32  YYYYMMDD 整数日期
      4  UInt32  开盘 × 100
      4  UInt32  最高 × 100
      4  UInt32  最低 × 100
      4  UInt32  收盘 × 100
      4  Float   成交额（元）
      4  UInt32  成交量（手）
      4  UInt32  保留

    price_scale: 价格除数（默认 0.01 = 除以 100 还原真实价格）
    vol_scale  : 成交量除数（默认 0.01，视需要调整）
    返回写入记录条数。
    """
    TDX_REC_SIZE = 32
    TDX_FORMAT   = '<IIIIIfII'

    records: List[DATRecord] = []
    with open(tdx_path, 'rb') as f:
        raw = f.read()

    total = len(raw) // TDX_REC_SIZE
    for i in range(total):
        offset = i * TDX_REC_SIZE
        vals = struct.unpack_from(TDX_FORMAT, raw, offset)
        ymd_int = vals[0]
        year  = ymd_int // 10000
        month = (ymd_int % 10000) // 100
        day   = ymd_int % 100
        try:
            d   = datetime.date(year, month, day)
            op  = vals[1] * price_scale
            hp  = vals[2] * price_scale
            lp  = vals[3] * price_scale
            cp  = vals[4] * price_scale
            vol = vals[6] * vol_scale
        except (ValueError, OverflowError) as e:
            print(f"  [跳过] TDX记录 {i}: {e}")
            continue
        records.append((d, op, hp, lp, cp, vol))

    return write_dat(dat_path, records)


def dzh_day_to_dat(dzh_path: str, dat_path: str,
                   price_scale: float = 0.001,
                   vol_scale:   float = 1.0) -> int:
    """
    将大智慧 .DAY 文件转换为 .DAT 文件。

    大智慧日线格式（每条记录 32 字节，little-endian）：
      4  UInt32  YYYYMMDD
      4  UInt32  开盘 × 1000
      4  UInt32  最高 × 1000
      4  UInt32  最低 × 1000
      4  UInt32  收盘 × 1000
      4  UInt32  成交量（手）
      4  UInt32  成交额（元）
      4  UInt32  保留

    price_scale: 默认 0.001（除以 1000）
    返回写入记录条数。
    """
    DZH_REC_SIZE = 32
    DZH_FORMAT   = '<IIIIIIII'

    records: List[DATRecord] = []
    with open(dzh_path, 'rb') as f:
        raw = f.read()

    total = len(raw) // DZH_REC_SIZE
    for i in range(total):
        offset = i * DZH_REC_SIZE
        vals = struct.unpack_from(DZH_FORMAT, raw, offset)
        ymd_int = vals[0]
        year  = ymd_int // 10000
        month = (ymd_int % 10000) // 100
        day   = ymd_int % 100
        try:
            d   = datetime.date(year, month, day)
            op  = vals[1] * price_scale
            hp  = vals[2] * price_scale
            lp  = vals[3] * price_scale
            cp  = vals[4] * price_scale
            vol = vals[5] * vol_scale
        except (ValueError, OverflowError) as e:
            print(f"  [跳过] DZH记录 {i}: {e}")
            continue
        records.append((d, op, hp, lp, cp, vol))

    return write_dat(dat_path, records)


# ═══════════════════════════════════════════════════════════════════════════════
#  文件信息 / 诊断
# ═══════════════════════════════════════════════════════════════════════════════

def dat_info(filepath: str) -> dict:
    """返回 .DAT 文件的摘要信息字典。"""
    header, records = read_dat_with_header(filepath)
    if not records:
        return {'error': 'no records'}
    first = records[0]
    last  = records[-1]
    return {
        'file':         os.path.basename(filepath),
        'size_bytes':   os.path.getsize(filepath),
        'record_count': len(records),
        'date_from':    first[0].isoformat(),
        'date_to':      last[0].isoformat(),
        'close_min':    round(min(r[4] for r in records), 4),
        'close_max':    round(max(r[4] for r in records), 4),
        'vol_min':      round(min(r[5] for r in records), 4),
        'vol_max':      round(max(r[5] for r in records), 4),
        'header':       header,
    }


def print_dat_info(filepath: str):
    """打印 .DAT 文件摘要。"""
    info = dat_info(filepath)
    print(f"\n{'─'*50}")
    print(f"文件:   {info['file']}")
    print(f"大小:   {info['size_bytes']:,} 字节")
    print(f"记录数: {info['record_count']}")
    print(f"日期:   {info['date_from']}  ~  {info['date_to']}")
    print(f"收盘:   最低 {info['close_min']}  最高 {info['close_max']}")
    print(f"成交量: 最小 {info['vol_min']}  最大 {info['vol_max']}")


# ═══════════════════════════════════════════════════════════════════════════════
#  命令行入口 / 使用示例
# ═══════════════════════════════════════════════════════════════════════════════

if __name__ == '__main__':
    import sys

    def demo_create():
        """演示：从代码直接创建 .DAT 文件"""
        records = [
            (datetime.date(2024,  1,  2), 160.50, 162.30, 159.80, 161.20, 5234100),
            (datetime.date(2024,  1,  3), 161.50, 163.00, 160.50, 162.80, 4891200),
            (datetime.date(2024,  1,  4), 162.00, 164.50, 161.00, 163.50, 6123400),
            (datetime.date(2024,  1,  5), 163.00, 165.00, 162.50, 164.20, 5456700),
            (datetime.date(2024,  1,  8), 164.00, 166.50, 163.00, 165.80, 7234500),
            (datetime.date(2024,  1,  9), 165.50, 167.00, 164.50, 166.20, 6345600),
            (datetime.date(2024,  1, 10), 166.00, 168.20, 165.00, 167.50, 8123700),
        ]
        out = 'test_stock.DAT'
        n = write_dat(out, records)
        print(f"已创建: {out}  ({n} 条记录)")
        print_dat_info(out)
        #os.remove(out)

    def demo_csv():
        """演示：CSV → DAT → CSV 往返转换"""
        # 先建一个临时 CSV
        csv_in  = 'sample_input.csv'
        dat_out = 'sample_output.DAT'
        csv_out = 'sample_export.csv'

        with open(csv_in, 'w', newline='', encoding='utf-8') as f:
            f.write("date,open,high,low,close,volume\n")
            f.write("2024-03-01,15.20,15.80,15.10,15.65,1234567\n")
            f.write("2024-03-04,15.70,16.00,15.50,15.90,987654\n")
            f.write("2024-03-05,15.85,16.20,15.70,16.10,1456789\n")

        n = csv_to_dat(csv_in, dat_out)
        print(f"CSV → DAT: {n} 条记录")
        print_dat_info(dat_out)

        m = dat_to_csv(dat_out, csv_out)
        print(f"DAT → CSV: {m} 条记录 → {csv_out}")
        with open(csv_out) as f:
            print(f.read())

        #for p in [csv_in, dat_out, csv_out]:
        #    if os.path.exists(p): os.remove(p)

    print("StockChart DAT 工具包 - 演示")
    print("=" * 50)
    print("\n[1] 代码直接创建 .DAT")
    demo_create()
    print("\n[2] CSV ↔ DAT 转换")
    demo_csv()

    print("""
使用方法：
  from dat_tools import csv_to_dat, dat_to_csv, tdx_day_to_dat, read_dat, dat_info

  # CSV → DAT（放入控件 DATA/日K线/ 目录即可使用）
  csv_to_dat('000001.csv', '000001.DAT')

  # 通达信日线 → DAT
  tdx_day_to_dat('sh000001.day', '00_上证指数.DAT')

  # 读取并检查
  records = read_dat('00_加权.DAT')
  print(records[:3])

  # 文件摘要
  import json
  print(json.dumps(dat_info('00_加权.DAT'), ensure_ascii=False, indent=2))
""")
