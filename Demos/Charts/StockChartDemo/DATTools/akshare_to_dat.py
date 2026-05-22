#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
使用 akshare 免费获取 A 股 / 台股数据并生成 .DAT 文件
=======================================================
安装依赖：
    pip install akshare

使用示例：
    python akshare_to_dat.py

支持：
  - A 股日 K 线（沪深股票、指数）
  - 台湾加权指数
  - 港股
"""

import datetime
import os
import sys

# 将 dat_tools.py 所在目录加入路径
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from dat_tools import write_dat, dat_info, DATRecord

try:
    import akshare as ak
except ImportError:
    print("请先安装 akshare：  pip install akshare")
    sys.exit(1)

OUTPUT_DIR = r'.\DATA\日K线'   # 控件默认数据目录，可修改


def ensure_output_dir():
    os.makedirs(OUTPUT_DIR, exist_ok=True)


# ── A 股股票日 K 线 ────────────────────────────────────────────────────────────

def download_stock_a(symbol: str, name: str,
                     start: str = '19900101',
                     end:   str = None) -> int:
    """
    下载 A 股股票日线数据并保存为 .DAT。

    symbol : 股票代码，例如 '000001'（平安银行）、'600519'（贵州茅台）
    name   : 文件名（不含 .DAT），例如 '000001.平安银行'
    start  : 开始日期 YYYYMMDD，默认 '19900101'
    end    : 结束日期 YYYYMMDD，默认今天

    示例：
        download_stock_a('000001', '03_平安银行')
        download_stock_a('600519', '04_贵州茅台', start='20000101')
    """
    if end is None:
        end = datetime.date.today().strftime('%Y%m%d')

    print(f"[下载] A股 {symbol} ({name}) {start} ~ {end} ...")
    df = ak.stock_zh_a_hist(symbol=symbol, period='daily',
                             start_date=start, end_date=end,
                             adjust='qfq')   # 前复权
    # 列名：日期 开盘 收盘 最高 最低 成交量 成交额 振幅 涨跌幅 涨跌额 换手率
    records: list[DATRecord] = []
    for _, row in df.iterrows():
        d   = datetime.datetime.strptime(str(row['日期']), '%Y-%m-%d').date()
        op  = float(row['开盘'])
        hp  = float(row['最高'])
        lp  = float(row['最低'])
        cp  = float(row['收盘'])
        vol = float(row['成交量'])   # 手（100 股）
        records.append((d, op, hp, lp, cp, vol))

    records.sort(key=lambda r: r[0])
    out = os.path.join(OUTPUT_DIR, name + '.DAT')
    n = write_dat(out, records)
    print(f"  → {out}  ({n} 条)")
    return n


# ── A 股指数日 K 线 ───────────────────────────────────────────────────────────

def download_index_a(symbol: str, name: str,
                     start: str = '19910101',
                     end:   str = None) -> int:
    """
    下载 A 股指数日线数据。

    常用指数：
      '000001'  上证指数
      '399001'  深证成指
      '399006'  创业板指
      '000300'  沪深300

    示例：
        download_index_a('000001', '00_上证指数')
        download_index_a('399001', '01_深证成指')
    """
    if end is None:
        end = datetime.date.today().strftime('%Y%m%d')

    print(f"[下载] A股指数 {symbol} ({name}) {start} ~ {end} ...")
    df = ak.stock_zh_index_daily(symbol=f'sh{symbol}' if symbol.startswith('0') else f'sz{symbol}')

    records: list[DATRecord] = []
    for _, row in df.iterrows():
        try:
            d   = datetime.datetime.strptime(str(row['date']), '%Y-%m-%d').date()
        except:
            continue
        op  = float(row['open'])
        hp  = float(row['high'])
        lp  = float(row['low'])
        cp  = float(row['close'])
        vol = float(row['volume'])
        if d < datetime.date.fromisoformat(start[:4]+'-'+start[4:6]+'-'+start[6:]):
            continue
        records.append((d, op, hp, lp, cp, vol))

    records.sort(key=lambda r: r[0])
    out = os.path.join(OUTPUT_DIR, name + '.DAT')
    n = write_dat(out, records)
    print(f"  → {out}  ({n} 条)")
    return n


# ── 台湾加权指数 ──────────────────────────────────────────────────────────────

def download_twse_index(name: str = '00_加权') -> int:
    """
    下载台湾加权指数（TWSE）日线数据。

    示例：
        download_twse_index('00_加权')
    """
    print(f"[下载] 台湾加权指数 ({name}) ...")
    df = ak.stock_zh_index_daily(symbol='tw_0001')

    records: list[DATRecord] = []
    for _, row in df.iterrows():
        try:
            d = datetime.datetime.strptime(str(row['date']), '%Y-%m-%d').date()
        except:
            continue
        op  = float(row['open'])
        hp  = float(row['high'])
        lp  = float(row['low'])
        cp  = float(row['close'])
        vol = float(row['volume'])
        records.append((d, op, hp, lp, cp, vol))

    records.sort(key=lambda r: r[0])
    out = os.path.join(OUTPUT_DIR, name + '.DAT')
    n = write_dat(out, records)
    print(f"  → {out}  ({n} 条)")
    return n


# ── 港股恒生指数 ──────────────────────────────────────────────────────────────

def download_hsi(name: str = '00_恒生指数') -> int:
    """
    下载港股恒生指数日线数据。
    """
    print(f"[下载] 恒生指数 ({name}) ...")
    df = ak.stock_hk_index_daily_em(symbol='恒生指数')

    records: list[DATRecord] = []
    for _, row in df.iterrows():
        try:
            d = datetime.datetime.strptime(str(row['日期']), '%Y-%m-%d').date()
        except:
            continue
        op  = float(row['开盘'])
        hp  = float(row['最高'])
        lp  = float(row['最低'])
        cp  = float(row['收盘'])
        vol = float(row.get('成交量', 0))
        records.append((d, op, hp, lp, cp, vol))

    records.sort(key=lambda r: r[0])
    out = os.path.join(OUTPUT_DIR, name + '.DAT')
    n = write_dat(out, records)
    print(f"  → {out}  ({n} 条)")
    return n


# ── 主程序演示 ────────────────────────────────────────────────────────────────

if __name__ == '__main__':
    ensure_output_dir()
    print(f"数据将保存至: {os.path.abspath(OUTPUT_DIR)}")
    print("=" * 55)

    # ── 根据需要取消注释 ──────────────────────────────────────

    # A 股指数
    # download_index_a('000001', '00_上证指数')
    # download_index_a('399001', '01_深证成指')
    # download_index_a('399006', '02_创业板指')
    # download_index_a('000300', '03_沪深300')

    # A 股股票（前复权）
    # download_stock_a('000001', '10_平安银行')
    # download_stock_a('600519', '11_贵州茅台')
    # download_stock_a('000858', '12_五粮液')

    # 台湾加权指数
    # download_twse_index('00_加权')

    # 港股
    # download_hsi('00_恒生指数')

    # ── 快速演示：用随机数据建一个测试文件 ──────────────────
    import random
    print("\n[演示] 生成模拟数据文件 TEST_demo.DAT ...")
    base_price = 100.0
    vol_base   = 100000.0
    records = []
    d = datetime.date(2020, 1, 2)
    for _ in range(200):
        # 跳过周末
        while d.weekday() >= 5:
            d += datetime.timedelta(days=1)
        chg  = random.uniform(-0.03, 0.03)
        op   = round(base_price * (1 + random.uniform(-0.01, 0.01)), 2)
        cp   = round(base_price * (1 + chg), 2)
        hp   = round(max(op, cp) * (1 + random.uniform(0, 0.015)), 2)
        lp   = round(min(op, cp) * (1 - random.uniform(0, 0.015)), 2)
        vol  = round(vol_base * random.uniform(0.5, 2.5), 0)
        records.append((d, op, hp, lp, cp, vol))
        base_price = cp
        d += datetime.timedelta(days=1)

    out = os.path.join(OUTPUT_DIR, 'TEST_demo.DAT')
    n = write_dat(out, records)
    print(f"  → {out}  ({n} 条)")

    import json
    info = dat_info(out)
    print(json.dumps(info, ensure_ascii=False, indent=2))
    print("\n将 TEST_demo.DAT 放入控件的 DataPath 目录，")
    print("然后将 StockName 设为 'TEST_demo' 即可查看。")
