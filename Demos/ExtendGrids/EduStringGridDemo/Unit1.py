# Powered By Python Studio, The best Python GUI IDE to download from glsite.com.
import os
from glcl import *

class Form1(Form):
    """
    主窗体类，继承自Form基类
    包含网格控件和各种操作按钮
    """

    def __init__(self, owner):
        """
        初始化窗体
        """
        self.SuperGrid1 = EduStringGrid(self)        # 字符串网格控件
        self.Panel1 = Panel(self)                    # 面板容器
        self.Button1 = Button(self)                  # 按钮1：清除合并单元格
        self.Button2 = Button(self)                  # 按钮2：合并单元格
        self.Button3 = Button(self)                  # 按钮3：填充测试数据
        self.Button4 = Button(self)                  # 按钮4：自动调整列宽
        self.Button6 = Button(self)                  # 按钮6：打印预览
        self.Button7 = Button(self)                  # 按钮7：打印设置
        self.Button8 = Button(self)                  # 按钮8：打印
        self.Button12 = Button(self)                 # 按钮12：保存到文件
        self.AColEdit = Edit(self)                   # 编辑框：A列索引输入
        self.BColEdit = Edit(self)                   # 编辑框：B列索引输入
        self.Button13 = Button(self)                 # 按钮13：移动列
        self.Button14 = Button(self)                 # 按钮14：交换列
        self.Button15 = Button(self)                 # 按钮15：删除行
        self.Button16 = Button(self)                 # 按钮16：删除列
        self.Button17 = Button(self)                 # 按钮17：交换行
        self.Button18 = Button(self)                 # 按钮18：移动行
        self.Button19 = Button(self)                 # 按钮19：插入行
        self.Button20 = Button(self)                 # 按钮20：插入列
        self.Button21 = Button(self)                 # 按钮21：清空网格
        self.Button22 = Button(self)                 # 按钮22：设置查看列
        self.Button23 = Button(self)                 # 按钮23：跳转到指定位置
        self.Button25 = Button(self)                 # 按钮25：从文件加载
        self.FGEdit = Edit(self)                     # 编辑框：文件格式输入
        self.Label1 = Label(self)                    # 标签控件
        self.OpenDialog1 = OpenDialog(self)          # 打开文件对话框
        self.SaveDialog1 = SaveDialog(self)          # 保存文件对话框
        self.Button26 = Button(self)                 # 按钮26：自动调整指定列宽
        self.Button27 = Button(self)                 # 按钮27：填充大量测试数据
        self.DeleteRowEdit = Edit(self)              # 编辑框：删除/插入行索引
        self.DeleteColEdit = Edit(self)              # 编辑框：删除/插入列索引
        self.GDCheckBox = CheckBox(self)             # 复选框：是否包含标题

        # 从文件加载窗体属性配置
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))

        # 绑定按钮点击事件到对应的处理方法
        self.Button27.OnClick = self.Button27Click   # 绑定按钮27点击事件
        self.Button23.OnClick = self.Button23Click   # 绑定按钮23点击事件
        self.Button22.OnClick = self.Button22Click   # 绑定按钮22点击事件
        self.Button21.OnClick = self.Button21Click   # 绑定按钮21点击事件
        self.Button20.OnClick = self.Button20Click   # 绑定按钮20点击事件
        self.Button16.OnClick = self.Button16Click   # 绑定按钮16点击事件
        self.Button19.OnClick = self.Button19Click   # 绑定按钮19点击事件
        self.Button15.OnClick = self.Button15Click   # 绑定按钮15点击事件
        self.Button18.OnClick = self.Button18Click   # 绑定按钮18点击事件
        self.Button13.OnClick = self.Button13Click   # 绑定按钮13点击事件
        self.Button17.OnClick = self.Button17Click   # 绑定按钮17点击事件
        self.Button14.OnClick = self.Button14Click   # 绑定按钮14点击事件
        self.Button25.OnClick = self.Button25Click   # 绑定按钮25点击事件
        self.Button12.OnClick = self.Button12Click   # 绑定按钮12点击事件
        self.Button8.OnClick = self.Button8Click     # 绑定按钮8点击事件
        self.Button7.OnClick = self.Button7Click     # 绑定按钮7点击事件
        self.Button6.OnClick = self.Button6Click     # 绑定按钮6点击事件
        self.Button4.OnClick = self.Button4Click     # 绑定按钮4点击事件
        self.Button26.OnClick = self.Button26Click   # 绑定按钮26点击事件
        self.Button1.OnClick = self.Button1Click     # 绑定按钮1点击事件
        self.Button2.OnClick = self.Button2Click     # 绑定按钮2点击事件
        self.Button3.OnClick = self.Button3Click     # 绑定按钮3点击事件


    def Button3Click(self, Sender):
        """
        按钮3点击事件：用乘法表数据填充网格
        设置网格为1001行11列，每个单元格填充i*j的结果
        """
        self.supergrid1.RowCount = 1001      # 设置行数为1001
        self.supergrid1.ColCount = 11        # 设置列数为11

        # 双重循环填充网格数据
        for i in range(0, 1001):             # 遍历所有行 (0-1000)
            for j in range(0, 11):           # 遍历所有列 (0-10)
                self.supergrid1.SetCells(j, i, str(i*j))  # 设置单元格值为i*j


    def Button2Click(self, Sender):
        """
        按钮2点击事件：合并指定单元格
        演示三种不同的单元格合并方式
        """
        self.supergrid1.MergeCells(2,0,4,0,True)   # 合并第2-4列第0行，True表示合并内容
        self.supergrid1.MergeCells(2,1,4,1,False)  # 合并第2-4列第1行，False表示不合并内容
        self.supergrid1.MergeCells(6,0,8,0,False)  # 合并第6-8列第0行
        self.supergrid1.Refresh()                   # 刷新网格显示


    def Button1Click(self, Sender):
        """
        按钮1点击事件：清除所有合并的单元格
        """
        self.supergrid1.MergeClear()          # 清除所有单元格合并状态


    def Button26Click(self, Sender):
        """
        按钮26点击事件：自动调整指定列的宽度
        """
        self.supergrid1.AutoSizeCol(0, 10)    # 自动调整第0列宽度，边距为10


    def Button4Click(self, Sender):
        """
        按钮4点击事件：自动调整所有列宽
        确保最后一列至少有64像素宽度
        """
        self.supergrid1.AutoSizeColumns(True, 10)  # 自动调整所有列宽，边距为10
        # 检查最后一列宽度，如果小于64则设置为64
        if self.supergrid1.ColWidths[self.supergrid1.ColCount-1] < 64:
            self.supergrid1.ColWidths[self.supergrid1.ColCount-1] = 64


    def Button6Click(self, Sender):
        """
        按钮6点击事件：显示打印预览
        """
        self.supergrid1.Preview(True)         # 打开打印预览对话框


    def Button7Click(self, Sender):
        """
        按钮7点击事件：显示打印设置
        """
        self.supergrid1.PrintSetup(True)      # 打开打印设置对话框


    def Button8Click(self, Sender):
        """
        按钮8点击事件：执行打印
        """
        self.supergrid1.Print(True)           # 执行打印操作


    def Button12Click(self, Sender):
        """
        按钮12点击事件：保存网格数据到文件
        使用保存文件对话框选择保存路径
        """
        if self.SaveDialog1.Execute():        # 显示保存文件对话框
            # 保存网格数据到指定文件，使用指定的文件格式
            self.supergrid1.SaveToFile(self.SaveDialog1.FileName, self.FGEdit.Text[0])


    def Button25Click(self, Sender):
        """
        按钮25点击事件：从文件加载网格数据
        使用打开文件对话框选择文件
        """
        if self.OpenDialog1.Execute():        # 显示打开文件对话框
            # 从指定文件加载网格数据，使用指定的文件格式
            self.supergrid1.LoadFromFile(self.OpenDialog1.FileName, self.FGEdit.Text[0])


    def Button14Click(self, Sender):
        """
        按钮14点击事件：交换两列的位置
        从编辑框获取列索引并验证有效性
        """
        ACol = -1
        BCol = -1
        try:
            # 从编辑框获取列索引
            if self.AColEdit.Text.strip() != '':
                ACol = int(self.AColEdit.Text)
            if self.BColEdit.Text.strip() != '':
                BCol = int(self.BColEdit.Text)
            # 验证索引有效性并执行交换
            if (ACol >= 0) and (ACol <= self.supergrid1.ColCount-1) and\
               (BCol >= 0) and (BCol <= self.supergrid1.ColCount-1):
                self.supergrid1.SwapColumns(ACol,BCol)  # 交换两列
        except:
            pass  # 忽略所有异常


    def Button17Click(self, Sender):
        """
        按钮17点击事件：交换两行的位置
        从编辑框获取行索引并验证有效性
        """
        ARow = -1
        BRow = -1
        try:
            # 从编辑框获取行索引
            if self.AColEdit.Text.strip() != '':
                ARow = int(self.AColEdit.Text)
            if self.BColEdit.Text.strip() != '':
                BRow = int(self.BColEdit.Text)
            # 验证索引有效性并执行交换
            if (ARow >= 0) and (ARow <= self.supergrid1.RowCount-1) and\
               (BRow >= 0) and (BRow <= self.supergrid1.RowCount-1):
                self.supergrid1.SwapRows(ARow,BRow)  # 交换两行
        except:
            pass  # 忽略所有异常


    def Button13Click(self, Sender):
        """
        按钮13点击事件：移动列到新位置
        从编辑框获取列索引并验证有效性
        """
        ACol = -1
        BCol = -1
        try:
            # 从编辑框获取列索引
            if self.AColEdit.Text.strip() != '':
                ACol = int(self.AColEdit.Text)
            if self.BColEdit.Text.strip() != '':
                BCol = int(self.BColEdit.Text)
            # 验证索引有效性并执行移动
            if (ACol >= 0) and (ACol <= self.supergrid1.ColCount-1) and\
               (BCol >= 0) and (BCol <= self.supergrid1.ColCount-1):
                self.supergrid1.MoveColumn(ACol,BCol)  # 移动列
        except:
            pass  # 忽略所有异常


    def Button18Click(self, Sender):
        """
        按钮18点击事件：移动行到新位置
        从编辑框获取行索引并验证有效性
        """
        ARow = -1
        BRow = -1
        try:
            # 从编辑框获取行索引
            if self.AColEdit.Text.strip() != '':
                ARow = int(self.AColEdit.Text)
            if self.BColEdit.Text.strip() != '':
                BRow = int(self.BColEdit.Text)
            # 验证索引有效性并执行移动
            if (ARow >= 0) and (ARow <= self.supergrid1.RowCount-1) and\
               (BRow >= 0) and (BRow <= self.supergrid1.RowCount-1):
                self.supergrid1.MoveRow(ARow,BRow)  # 移动行
        except:
            pass  # 忽略所有异常


    def Button15Click(self, Sender):
        """
        按钮15点击事件：删除指定行
        从编辑框获取行索引并验证有效性
        """
        ARow = -1
        try:
            # 从编辑框获取行索引
            if self.DeleteRowEdit.Text.strip() != '':
                ARow = int(self.DeleteRowEdit.Text)
            # 验证索引有效性并执行删除
            if (ARow >= 0) and (ARow <= self.supergrid1.RowCount-1):
                self.supergrid1.DeleteRow(ARow)  # 删除行
        except:
            pass  # 忽略所有异常


    def Button19Click(self, Sender):
        """
        按钮19点击事件：在指定位置插入新行
        从编辑框获取行索引并验证有效性
        """
        ARow = -1
        try:
            # 从编辑框获取行索引
            if self.DeleteRowEdit.Text.strip() != '':
                ARow = int(self.DeleteRowEdit.Text)
            # 验证索引有效性并执行插入
            if (ARow >= 0) and (ARow <= self.supergrid1.RowCount-1):
                self.supergrid1.InsertRow(ARow)  # 插入行
        except:
            pass  # 忽略所有异常


    def Button16Click(self, Sender):
        """
        按钮16点击事件：删除指定列
        从编辑框获取列索引并验证有效性
        """
        ACol = -1
        try:
            # 从编辑框获取列索引
            if self.DeleteColEdit.Text.strip() != '':
                ACol = int(self.DeleteColEdit.Text)
            # 验证索引有效性并执行删除
            if (ACol >= 0) and (ACol <= self.supergrid1.ColCount-1):
                self.supergrid1.DeleteColumn(ACol)  # 删除列
        except:
            pass  # 忽略所有异常


    def Button20Click(self, Sender):
        """
        按钮20点击事件：在指定位置插入新列
        从编辑框获取列索引并验证有效性
        """
        ACol = -1
        try:
            # 从编辑框获取列索引
            if self.DeleteColEdit.Text.strip() != '':
                ACol = int(self.DeleteColEdit.Text)
            # 验证索引有效性并执行插入
            if (ACol >= 0) and (ACol <= self.supergrid1.ColCount-1):
                self.supergrid1.InsertColumn(ACol)  # 插入列
        except:
            pass  # 忽略所有异常


    def Button21Click(self, Sender):
        """
        按钮21点击事件：清空网格内容
        根据复选框决定是否包含标题
        """
        self.supergrid1.Clear(self.GDCheckBox.Checked)  # 清空网格


    def Button22Click(self, Sender):
        """
        按钮22点击事件：设置查看列
        """
        self.supergrid1.SetViewCol()          # 设置查看列


    def Button23Click(self, Sender):
        """
        按钮23点击事件：跳转到指定单元格
        """
        self.supergrid1.DoGoto()              # 执行跳转操作
        self.supergrid1.SetFocus()            # 设置焦点到网格


    def Button27Click(self, Sender):
        """
        按钮27点击事件：填充大量测试数据（50001行11列）
        用于性能测试或大数据量演示
        """
        self.supergrid1.RowCount = 50001      # 设置行数为50001
        self.supergrid1.colcount = 11         # 设置列数为11

        # 双重循环填充大量数据
        for i in range(0, 50001):             # 遍历所有行 (0-50000)
            for j in range(0, 11):            # 遍历所有列 (0-10)
                self.supergrid1.SetCells(j, i, str(i*j))  # 设置单元格值为i*j