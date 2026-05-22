# StockChart DAT 工具包

为 `TStockChart` 控件生成和管理 `.DAT` 数据文件的 Python 工具集。

---

## 文件说明

| 文件 | 用途 |
|------|------|
| `dat_tools.py` | 核心库：读写 .DAT、CSV 互转、通达信/大智慧转换 |
| `akshare_to_dat.py` | 免费下载 A 股 / 台股 / 港股数据并生成 .DAT |

---

## 安装

只需 Python 3.8+，无额外依赖（仅 `dat_tools.py`）。  
若需联网下载股票数据：

```bash
pip install akshare
```

---

## 一、DAT 文件格式详解

### 文件结构

```
[文件头记录 28字节] + [数据记录1 28字节] + [数据记录2 28字节] + ...
```

数据记录按 **日期从旧到新** 排列。

### 单条记录格式（TStkDataRec，packed，little-endian）

| 偏移 | 大小 | 类型   | 字段 | 说明 |
|------|------|--------|------|------|
| 0    | 8    | Double | Date | Delphi TDateTime（距 1899-12-30 的天数） |
| 8    | 4    | Single | OP   | 开盘价 |
| 12   | 4    | Single | HP   | 最高价 |
| 16   | 4    | Single | LP   | 最低价 |
| 20   | 4    | Single | CP   | 收盘价 |
| 24   | 4    | Single | VOL  | 成交量 |

**共 28 字节/记录**

### 日期编码

```python
# Python date → Delphi TDateTime
days = (date(2024, 1, 2) - date(1899, 12, 30)).days  # = 45293

# Delphi TDateTime → Python date
d = date(1899, 12, 30) + timedelta(days=45293)        # = 2024-01-02
```

---

## 二、原始文件分析结论

通过对三个原始 `.DAT` 文件的二进制分析：

### 来源：台湾证交所（TWSE）行业指数

| 文件 | 内容 | 数据区间 | 记录数 |
|------|------|----------|--------|
| `00_加权.DAT` | 台湾加权股价指数（大盘）| 1988-03-24 ~ 2006-08-16 | 4999 |
| `01_金融.DAT` | 金融类股指数            | 1988-03-23 ~ 2006-08-16 | 4999 |
| `02_电子.DAT` | 电子类股指数            | 1995-01-06 ~ 2006-08-16 | 3058 |

**确认依据：**
- `00_加权` 收盘价在 1990-02-10 达到 **12,495 点**，完全匹配台湾加权指数历史最高点（12,682 点，1990 年 2 月）
- 2000 年初价格约 8,800 点，符合台湾加权指数 Y2K 时期水平
- 成交量单位为 **亿元新台币**（与台湾交易所惯例一致）
- 电子类指数从 1995 年才有，符合台湾电子股指数建立时间

### 生成软件推测

文件命名规则（`00_`、`01_`、`02_`）和格式设计与原始 Delphi 源码（`fDef.pas`）完全吻合，推测为 **该 DrawStock 程序本身的作者自制工具** 从某台湾股票数据供应商（如 Yahoo Finance TW、元大证券、凱基证券的历史数据库）批量导出生成的。

---

## 三、dat_tools.py 使用

### 1. 读取现有 .DAT 文件

```python
from dat_tools import read_dat, dat_info

# 读取记录
records = read_dat('00_加权.DAT')
for date, op, hp, lp, cp, vol in records[:5]:
    print(f"{date}  O={op:.2f} H={hp:.2f} L={lp:.2f} C={cp:.2f} V={vol:.2f}")

# 文件摘要
import json
print(json.dumps(dat_info('00_加权.DAT'), ensure_ascii=False, indent=2))
```

### 2. 从代码直接创建 .DAT

```python
import datetime
from dat_tools import write_dat

records = [
    (datetime.date(2024, 1, 2), 160.50, 162.30, 159.80, 161.20, 5234100),
    (datetime.date(2024, 1, 3), 161.50, 163.00, 160.50, 162.80, 4891200),
    # ...
]
n = write_dat('my_stock.DAT', records)
print(f"写入 {n} 条记录")
```

### 3. CSV → DAT

```python
from dat_tools import csv_to_dat

# 默认列名：date, open, high, low, close, volume
csv_to_dat('000001.csv', '000001.平安银行.DAT')

# 自定义列名（例如从网站下载的 CSV 格式不同）
csv_to_dat('data.csv', 'output.DAT',
           date_col='Date',
           open_col='Open',
           high_col='High',
           low_col='Low',
           close_col='Close/Last',
           vol_col='Volume',
           date_fmt='%m/%d/%Y')   # 美式日期格式
```

#### CSV 格式要求（默认）

```csv
date,open,high,low,close,volume
2024-01-02,160.50,162.30,159.80,161.20,5234100
2024-01-03,161.50,163.00,160.50,162.80,4891200
```

### 4. DAT → CSV（导出）

```python
from dat_tools import dat_to_csv

dat_to_csv('00_加权.DAT', '00_加权_export.csv')
```

### 5. 通达信 DAY 文件转换

```python
from dat_tools import tdx_day_to_dat

# 通达信安装目录下的日线文件
# 路径示例：C:\TdxW_HGT\vipdoc\sh\lday\sh000001.day
tdx_day_to_dat(
    r'C:\TdxW_HGT\vipdoc\sh\lday\sh000001.day',
    r'DATA\日K线\00_上证指数.DAT'
)
```

### 6. 大智慧 DAY 文件转换

```python
from dat_tools import dzh_day_to_dat

dzh_day_to_dat(
    r'C:\DZH\data\sh\day\000001.day',
    r'DATA\日K线\00_上证指数.DAT'
)
```

---

## 四、akshare_to_dat.py 使用（免费联网下载）

```bash
# 编辑 akshare_to_dat.py，取消需要的下载行的注释，然后运行：
python akshare_to_dat.py
```

### 支持的数据源

```python
# A 股指数（上证、深证、创业板、沪深300等）
download_index_a('000001', '00_上证指数')
download_index_a('399001', '01_深证成指')
download_index_a('000300', '02_沪深300')

# A 股个股（前复权日线）
download_stock_a('000001', '10_平安银行')
download_stock_a('600519', '11_贵州茅台')

# 台湾加权指数
download_twse_index('00_加权')

# 港股恒生指数
download_hsi('00_恒生指数')
```

---

## 五、数据文件放置位置

生成的 `.DAT` 文件放入控件的 `DataPath` 目录（默认 `.\DATA\日K线\`）：

```
你的程序.exe
DATA\
  日K线\
    00_上证指数.DAT     ← StockName = '00_上证指数'
    01_深证成指.DAT     ← StockName = '01_深证成指'
    10_平安银行.DAT     ← StockName = '10_平安银行'
```

控件中设置：
```pascal
Chart.DataPath  := ExtractFilePath(Application.ExeName) + 'DATA\日K线\';
Chart.StockName := '00_上证指数';
```

---

## 六、其他数据来源

| 来源 | 获取方式 |
|------|----------|
| **通达信**（免费） | 软件安装后在 `vipdoc\sh\lday\` 目录找到 `.day` 文件，用 `tdx_day_to_dat()` 转换 |
| **大智慧**（免费） | 类似通达信，用 `dzh_day_to_dat()` 转换 |
| **akshare**（免费 Python 库） | 直接用 `akshare_to_dat.py` 下载 |
| **Yahoo Finance** | 下载 CSV 后用 `csv_to_dat()` 转换，注意列名为英文 |
| **Wind / Bloomberg** | 导出 CSV 后用 `csv_to_dat()` 转换 |
| **自有数据库** | 查询后构造 `DATRecord` 列表，调用 `write_dat()` |
