import os
import sys
from glcl import *
from pathlib import Path

class Form1(Form):

    def __init__(self, owner):
        self.NumberBox1 = NumberBox(self)
        self.TimePicker1 = TimePicker(self)
        self.DatePicker1 = DatePicker(self)
        self.CalendarPicker1 = CalendarPicker(self)
        self.CalendarView1 = CalendarView(self)
        self.SearchBox1 = SearchBox(self)
        self.ToggleSwitch1 = ToggleSwitch(self)
        self.ActivityIndicator1 = ActivityIndicator(self)
        self.Calendar1 = Calendar(self)
        self.SpinEdit1 = SpinEdit(self)
        self.SpinButton1 = SpinButton(self)
        self.Gauge1 = Gauge(self)
        self.ColorGrid1 = ColorGrid(self)
        self.ListBox2 = ListBox(self)
        self.ToolBar1 = ToolBar(self)
        self.StatusBar1 = StatusBar(self)
        self.MonthCalendar1 = MonthCalendar(self)
        self.DateTimePicker1 = DateTimePicker(self)
        self.UpDown1 = UpDown(self)
        self.ProgressBar1 = ProgressBar(self)
        self.TrackBar1 = TrackBar(self)
        self.ColorBox1 = ColorBox(self)
        self.ButtonedEdit1 = ButtonedEdit(self)
        self.LinkLabel1 = LinkLabel(self)
        self.StaticText1 = StaticText(self)
        self.Splitter1 = Splitter(self)
        self.CheckListBox1 = CheckListBox(self)
        self.ScrollBox1 = ScrollBox(self)
        self.Shape1 = Shape(self)
        self.StringGrid1 = StringGrid(self)
        self.MaskEdit1 = MaskEdit(self)
        self.SpeedButton1 = SpeedButton(self)
        self.BitBtn1 = BitBtn(self)
        self.Panel1 = Panel(self)
        self.RadioGroup1 = RadioGroup(self)
        self.GroupBox1 = GroupBox(self)
        self.ScrollBar1 = ScrollBar(self)
        self.ComboBox1 = ComboBox(self)
        self.ListBox1 = ListBox(self)
        self.RadioButton1 = RadioButton(self)
        self.CheckBox1 = CheckBox(self)
        self.Button1 = Button(self)
        self.Memo1 = Memo(self)
        self.Edit1 = Edit(self)
        self.Label1 = Label(self)
        self.PageControl1 = PageControl(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.ListBox2.OnClick = self.ListBox2Click
        self.sm = StyleManager(Application)
        # 部署会自动将工程目录下所有vsf皮肤文件一起打包，所以不需要在配置exe中额外添加
        # 部署exe后再次点击运行按钮之前需要在窗体设计器->工程管理器->右键菜单->清除，删除缓存
        # 使用示例
        directory_path = os.path.split(sys.argv[0])[0]
        vsf_files = self.list_vsf_files_recursive(directory_path)
        for file in vsf_files:
            self.sm.LoadFromFile(file)
        for name in self.sm.StyleNames:
            self.ListBox2.Items.Add(name)

    def list_vsf_files_recursive(self, directory):
        """递归列出目录及子目录下所有.vsf后缀的文件"""
        path = Path(directory)
        return list(path.rglob('*.vsf'))

    def ListBox2Click(self, Sender):
        self.sm.SetStyle(self.ListBox2.Items[self.ListBox2.ItemIndex])