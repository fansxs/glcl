import win32api
import win32con
import os

def get_windows_fonts():
    """获取Windows系统注册表中安装的字体列表"""
    fonts = []
    # 打开Windows注册表中的字体键
    font_key = win32api.RegOpenKeyEx(
        win32con.HKEY_LOCAL_MACHINE,
        r"SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts",
        0,
        win32con.KEY_READ
    )

    try:
        count = 0
        # 枚举注册表中的所有字体值
        while True:
            try:
                # 获取字体名称和对应的字体文件路径
                name, value, _ = win32api.RegEnumValue(font_key, count)
                fonts.append(name)
                count += 1
            except win32api.error:
                break
    finally:
        # 确保关闭注册表键
        win32api.RegCloseKey(font_key)

    return fonts

def get_fonts_from_directory():
    """从Windows字体目录中获取字体文件列表"""
    # 定义Windows系统字体目录路径
    font_dirs = [
        os.path.join(os.environ['WINDIR'], 'Fonts'), # 系统字体目录
        os.path.join(os.environ['LOCALAPPDATA'], 'Microsoft', 'Windows', 'Fonts') # 用户字体目录
    ]

    fonts = []
    # 遍历所有字体目录
    for font_dir in font_dirs:
        if os.path.exists(font_dir):
            # 递归遍历目录中的所有文件
            for root, dirs, files in os.walk(font_dir):
                for file in files:
                    # 检查文件是否是字体文件(.ttf, .otf, .fon)
                    if file.lower().endswith(('.ttf', '.otf', '.fon')):
                        fonts.append(os.path.splitext(file)[0])
    return fonts

def get_all_windows_fonts():
    # 获取注册表中的字体
    reg_fonts = get_windows_fonts()
    # 获取字体目录中的字体
    dir_fonts = get_fonts_from_directory()
    # 合并并去重
    all_fonts = list(set(reg_fonts + dir_fonts))
    return sorted(all_fonts)

'''all_fonts = get_all_windows_fonts()
print("所有字体:")
for font in all_fonts:
    print(font)'''