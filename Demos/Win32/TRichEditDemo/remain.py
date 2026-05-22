import os
from glcl import *
from enumfont import *
import sys
from reabout import *

class MainForm(Form):

    def __init__(self, owner):
        # 初始化各种UI组件
        self.MainMenu1 = MainMenu(self)
        self.Ruler1 = Panel(self)
        self.FontDialog1 = FontDialog(self)
        self.FirstInd1 = Label(self)
        self.LeftInd1 = Label(self)
        self.RulerLine1 = Bevel(self)
        self.RightInd1 = Label(self)
        self.miEditFont1 = MenuItem(self)
        self.Editor = RichEdit(self)
        self.StatusBar1 = StatusBar(self)
        self.StandardToolBar1 = ToolBar(self)
        self.FontName = ComboBox(self)
        self.FontSize1 = Edit(self)
        self.UpDown11 = UpDown(self)
        self.ToolbarImages1 = ImageList(self)
        self.ActionList1 = ActionList(self)
        self.Bevel11 = Bevel(self)
        self.FGColorBox1 = ColorBox(self)
        self.BGColorBox1 = ColorBox(self)
        self.FileNewCmd1 = Action(self)
        self.FileOpenCmd1 = Action(self)
        self.OpenDialog11 = OpenDialog(self)
        self.SaveDialog11 = SaveDialog(self)
        # 从文件加载窗体属性
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "remain.pydfm"))
        # 设置各种事件处理器
        self.FontSize.OnChange = self.FontSizeChange
        self.BGColorBox.OnChange = self.BGColorBoxChange
        self.FGColorBox.OnChange = self.FGColorBoxChange
        self.SubscriptCmd.OnUpdate = self.SubscriptCmdUpdate
        self.SuperscriptCmd.OnUpdate = self.SuperscriptCmdUpdate
        self.FormatRichEditAlignCenterCmd.OnUpdate = self.FormatRichEditAlignCenterCmdUpdate
        self.FormatRichEditAlignRightCmd.OnUpdate = self.FormatRichEditAlignRightCmdUpdate
        self.FormatRichEditAlignLeftCmd.OnUpdate = self.FormatRichEditAlignLeftCmdUpdate
        self.FormatRichEditBulletsCmd.OnUpdate = self.FormatRichEditBulletsCmdUpdate
        self.FormatRichEditStrikeOutCmd.OnUpdate = self.FormatRichEditStrikeOutCmdUpdate
        self.FormatRichEditUnderlineCmd.OnUpdate = self.FormatRichEditUnderlineCmdUpdate
        self.FormatRichEditItalicCmd.OnUpdate = self.FormatRichEditItalicCmdUpdate
        self.FormatRichEditBoldCmd.OnUpdate = self.FormatRichEditBoldCmdUpdate
        self.Editor.OnLinkClick = self.EditorLinkClick
        self.Editor.OnClick = self.EditorClick
        self.OnCloseQuery = self.FormCloseQuery
        self.FontName.OnChange = self.FontNameChange
        self.RightInd.OnMouseUp = self.RightIndMouseUp
        self.RightInd.OnMouseMove = self.RulerItemMouseMove
        self.RightInd.OnMouseDown = self.RulerItemMouseDown
        self.FirstInd.OnMouseUp = self.FirstIndMouseUp
        self.FirstInd.OnMouseMove = self.RulerItemMouseMove
        self.FirstInd.OnMouseDown = self.RulerItemMouseDown
        self.LeftInd.OnMouseUp = self.LeftIndMouseUp
        self.LeftInd.OnMouseMove = self.RulerItemMouseMove
        self.LeftInd.OnMouseDown = self.RulerItemMouseDown
        self.HelpAboutItem.OnClick = self.HelpAboutItemClick
        self.RichEditWordWrapItem.OnClick = self.RichEditWordWrapItemClick
        self.RichEditTransparentItem.OnClick = self.RichEditTransparentItemClick
        self.miEditFont.OnClick = self.miEditFontClick
        self.SubscriptCmd.OnExecute = self.SubscriptCmdExecute
        self.SuperscriptCmd.OnExecute = self.SuperscriptCmdExecute
        self.FormatRichEditAlignCenterCmd.OnExecute = self.FormatRichEditAlignCenterCmdExecute
        self.FormatRichEditAlignRightCmd.OnExecute = self.FormatRichEditAlignRightCmdExecute
        self.FormatRichEditAlignLeftCmd.OnExecute = self.FormatRichEditAlignLeftCmdExecute
        self.FormatRichEditBulletsCmd.OnExecute = self.FormatRichEditBulletsCmdExecute
        self.FormatRichEditStrikeOutCmd.OnExecute = self.FormatRichEditStrikeOutCmdExecute
        self.FormatRichEditUnderlineCmd.OnExecute = self.FormatRichEditUnderlineCmdExecute
        self.FormatRichEditItalicCmd.OnExecute = self.FormatRichEditItalicCmdExecute
        self.FormatRichEditBoldCmd.OnExecute = self.FormatRichEditBoldCmdExecute
        self.EditFontCmd.OnExecute = self.EditFontCmdExecute
        self.EditPasteCmd.OnExecute = self.EditPasteCmdExecute
        self.EditCopyCmd.OnExecute = self.EditCopyCmdExecute
        self.EditCutCmd.OnExecute = self.EditCutCmdExecute
        self.EditUndoCmd.OnExecute = self.EditUndoCmdExecute
        self.FileSaveAsCmd.OnExecute = self.FileSaveAsCmdExecute
        self.FileExitCmd.OnExecute = self.FileExitCmdExecute
        self.FilePrintCmd.OnExecute = self.FilePrintCmdExecute
        self.FileSaveCmd.OnExecute = self.FileSaveCmdExecute
        self.FileOpenCmd.OnExecute = self.FileOpenCmdExecute
        self.FileNewCmd.OnExecute = self.FileNewCmdExecute
        self.Editor.OnSelectionChange = self.SelectionChange
        self.Editor.OnChange = self.EditorChange
        self.Ruler1.OnResize = self.Ruler1Resize
        self.OnResize = self.MainFormResize
        self.OnShow = self.FormShow

        # 初始化变量
        self.FFileName = ''
        self.FUpdating = False
        self.FDragOfs = 0
        self.FDragging = False
        self.sSaveChanges = 'Save changes to {}?'
        self.sOverWrite = 'OK to overwrite {}'
        self.sUntitled = 'Untitled'
        self.sModified = 'Modified'
        self.sColRowInfo = 'Line: {}   Col: {}'
        self.sScrollPos = 'Scroll Pos: ({}, {})'
        self.sOpenLink = 'Open link: {} ?'
        self.RulerAdj = 4/3
        self.GutterWid = 6

        # 设置初始UI状态
        self.OpenDialog1.InitialDir = os.getcwd()
        self.SetFileName(self.sUntitled)
        self.GetFontNames()
        self.SetupRuler()
        self.SelectionChange(self)

        # 设置编辑器初始属性
        self.CurrText().Name = self.FontDialog1.Font.Name
        self.CurrText().Size = self.FontDialog1.Font.Size
        self.RichEditTransparentItem.Checked = self.Editor.Transparent
        self.RichEditWordWrapItem.Checked = self.Editor.ScrollBars == 'ssVertical'
        self.Editor.ShowURLHint = True
        '''如窗体设置了皮肤，为使Editor所有功能正常使用，建议设置它的风格为Windows，
        也可以通过属性面板设置'这个属性'''
        self.Editor.StyleName = 'Windows'

    def MainFormResize(self, Sender):
        # 处理窗体大小改变事件
        try:
            self.SelectionChange(Sender)
            self.Editor.Invalidate()
        except:
            pass

    def Ruler1Resize(self, Sender):
        # 调整标尺线宽度
        self.RulerLine.Width = self.Ruler1.ClientWidth - (self.RulerLine.Left*2)

    def UpdateCursorPos(self):
        # 更新光标位置显示
        CharPos = Point(0, 0)
        CharPos.Y = Application.SendMessage(self.Editor.Handle, EM_EXLINEFROMCHAR, 0, self.Editor.SelStart)
        CharPos.X = (self.Editor.SelStart - Application.SendMessage(self.Editor.Handle, EM_LINEINDEX, CharPos.Y, 0))
        CharPos.Y += 1
        CharPos.X += 1
        self.StatusBar.Panels[0].Text = self.sColRowInfo.format(CharPos.Y, CharPos.X)
        self.StatusBar.Panels[1].Text = self.sScrollPos.format(self.Editor.ScrollPosition.X, self.Editor.ScrollPosition.Y)

    def SelectionChange(self, Sender):
        # 处理选择内容改变事件
        try:
            self.FUpdating = True
            self.FirstInd.Left = int(self.Editor.Paragraph.FirstIndent*self.RulerAdj)-4+self.GutterWid
            self.LeftInd.Left = int((self.Editor.Paragraph.LeftIndent+self.Editor.Paragraph.FirstIndent)*self.RulerAdj)-4+self.GutterWid
            self.RightInd.Left = self.Ruler1.ClientWidth-6-int((self.Editor.Paragraph.RightIndent+self.GutterWid)*self.RulerAdj)
            self.FontSize.Text = str(self.Editor.SelAttributes.Size)
            self.FontName.Text = self.Editor.SelAttributes.Name
            self.FGColorBox.Selected = self.Editor.SelAttributes.Color
            self.BGColorBox.Selected = self.Editor.SelAttributes.BackColor
            self.UpdateCursorPos()
        finally:
            self.FUpdating = False

    def SetupRuler(self):
        # 设置标尺显示
        s = []
        for i in range(200):
            if i % 2 == 0:  # even indices (0, 2, 4...) correspond to odd positions in Delphi (1-based)
                s.append('\t')
            else:           # odd indices (1, 3, 5...) correspond to even positions in Delphi
                s.append('|')
        self.Ruler1.Caption = ''.join(s)

    def GetFontNames(self):
        # 获取所有可用字体名称
        for font in get_all_windows_fonts():
            self.FontName.Items.Add(font)
        self.FontName.Sorted = True

    def SetFileName(self, FileName):
        # 设置当前文件名
        self.FFileName = FileName
        self.Caption = '%s - %s'.format(os.path.basename(FileName), Application.Title)

    def FormShow(self, Sender):
        # 窗体显示时初始化
        self.UpdateCursorPos()
        # TODO->拖拽文件组件实例: https://dl.glsite.com/ComponentsDemos/DropFiles/DropFileSimpleDemo.rar
        # 参考上面URL实例，完成文件拖拽到编辑器能够加载显示的功能，另外还可以添加一个右键菜单并新建一些子菜单，
        # 然后设置子菜单的Action并将右键菜单关联到RichEdit控件
        self.EditorChange(None)
        self.Editor.SetFocus()

        # 尝试自动打开文件
        if os.path.exists('overview.rtf'):
            self.PerformFileOpen('overview.rtf')
        elif os.path.exists('..\..\overview.rtf'):
            self.PerformFileOpen('..\..\overview.rtf')
        elif (len(sys.argv) > 1) and os.path.exists(sys.argv[1]):
            self.PerformFileOpen(sys.argv[1])

    def EditorChange(self, Sender):
        # 编辑器内容改变时处理
        self.SetModified(self.Editor.Modified)
        self.UpdateCursorPos()

    def SetModified(self, Value):
        # 设置修改状态
        if Value:
            self.StatusBar.Panels[2].Text = self.sModified
        else:
            self.StatusBar.Panels[2].Text = ''

    def SetFileName(self, FileName):
        self.FFileName = FileName
        self.Caption = '{} - {}'.format(os.path.basename(FileName), Application.Title)

    def PerformFileOpen(self, AFileName):
        # 打开文件
        self.Editor.Lines.LoadFromFile(AFileName)
        self.SetFileName(AFileName)
        self.Editor.SetFocus()
        self.Editor.Modified = False
        self.SetModified(False)

    def FileNewCmdExecute(self, Sender):
        # 新建文件
        self.SetFileName(self.sUntitled)
        self.Editor.Lines.Clear()
        self.Editor.Modified = False
        self.SetModified(False)

    def FileOpenCmdExecute(self, Sender):
        # 打开文件
        if self.OpenDialog1.Execute():
            self.PerformFileOpen(self.OpenDialog1.FileName)
            self.Editor.ReadOnly = 'ofReadOnly' in self.OpenDialog1.Options

    def FileSaveAs(self, Sender):
        # 另存为文件
        if os.path.exists(self.SaveDialog1.FileName):
            if Application.MessageBox(self.sOverWrite.format(self.SaveDialog1.FileName), 'Confirmation', MB_YESNO or MB_ICONQUESTION) != IDYES:
                return
        self.Editor.Lines.SaveToFile(self.SaveDialog1.FileName)
        self.SetFileName(self.SaveDialog1.FileName)
        self.Editor.Modified = False
        self.SetModified(False)

    def FileSaveCmdExecute(self, Sender):
        # 保存文件
        if self.FFileName == self.sUntitled:
            self.FileSaveAs(Sender)
        else:
            self.Editor.Lines.SaveToFile(self.FFileName)
            self.Editor.Modified = False
            self.SetModified(False)

    def FilePrintCmdExecute(self, Sender):
        # 打印文件
        self.Editor.Print(self.FFileName)

    def FileExitCmdExecute(self, Sender):
        # 退出程序
        Application.MainForm.Close()

    def FileSaveAsCmdExecute(self, Sender):
        # 另存为
        if self.SaveDialog1.Execute():
            if os.path.exists(self.SaveDialog1.FileName):
                if Application.MessageBox(self.sOverWrite.format(self.SaveDialog1.FileName), 'Confirmation', MB_YESNO or MB_ICONQUESTION) != IDYES:
                    return
            self.Editor.Lines.SaveToFile(self.SaveDialog1.FileName)
            self.SetFileName(self.SaveDialog1.FileName)
            self.Editor.Modified = False
            self.SetModified(False)

    def EditUndoCmdExecute(self, Sender):
        # 撤销操作
        self.Editor.Undo()

    def EditCutCmdExecute(self, Sender):
        # 剪切操作
        self.Editor.CutToClipboard()

    def EditCopyCmdExecute(self, Sender):
        # 复制操作
        self.Editor.CopyToClipboard()

    def EditPasteCmdExecute(self, Sender):
        # 粘贴操作
        self.Editor.PasteFromClipboard()

    def CurrText(self):
        # 获取当前文本属性
        if self.Editor.SelLength > 0:
            return self.Editor.SelAttributes
        else:
            return self.Editor.DefAttributes

    def EditFontCmdExecute(self, Sender):
        # 设置字体
        self.CurrText.Assign(self.FontDialog1.Font)
        self.SelectionChange(Self)
        self.Editor.SetFocus()

    def SetFontStyle(self, Edit: CustomRichEdit, Style):
        # 设置字体样式
        if Edit == None:
            return
        if Style in Edit.SelAttributes.Style:
            styles = Edit.SelAttributes.Style
            styles.remove(Style)
            Edit.SelAttributes.Style = styles
        else:
            Edit.SelAttributes.Style = Edit.SelAttributes.Style + [Style]

    def FormatRichEditBoldCmdExecute(self, Sender):
        # 加粗
        self.SetFontStyle(self.Editor, 'fsBold')

    def FormatRichEditItalicCmdExecute(self, Sender):
        # 斜体
        self.SetFontStyle(self.Editor, 'fsItalic')

    def FormatRichEditUnderlineCmdExecute(self, Sender):
        # 下划线
        self.SetFontStyle(self.Editor, 'fsUnderline')

    def FormatRichEditStrikeOutCmdExecute(self, Sender):
        # 删除线
        self.SetFontStyle(self.Editor, 'fsStrikeOut')

    def FormatRichEditBulletsCmdExecute(self, Sender):
        # 项目符号
        if self.Editor.Paragraph.Numbering == 'nsNone':
            self.Editor.Paragraph.Numbering = 'nsBullet'
        else:
            self.Editor.Paragraph.Numbering = 'nsNone'

    def FormatRichEditAlignLeftCmdExecute(self, Sender):
        # 左对齐命令
        self.Editor.Paragraph.Alignment = 'taLeftJustify'
        self.FormatRichEditAlignLeftCmd.Checked = True

    def FormatRichEditAlignRightCmdExecute(self, Sender):
        # 右对齐命令
        self.Editor.Paragraph.Alignment = 'taRightJustify'
        self.FormatRichEditAlignRightCmd.Checked = True

    def FormatRichEditAlignCenterCmdExecute(self, Sender):
        # 居中对齐命令
        self.Editor.Paragraph.Alignment = 'taCenter'
        self.FormatRichEditAlignCenterCmd.Checked = True

    def SuperscriptCmdExecute(self, Sender):
        # 上标
        self.Editor.SelAttributes.Subscript = 'sstSuperscript'

    def SubscriptCmdExecute(self, Sender):
        # 下标
        self.Editor.SelAttributes.Subscript = 'sstSubscript'

    def miEditFontClick(self, Sender):
        # 编辑字体菜单点击
        if self.FontDialog1.Execute():
            self.CurrText().Assign(self.FontDialog1.Font)
            self.SelectionChange(self)
            self.Editor.SetFocus()

    def RichEditTransparentItemClick(self, Sender):
        # 透明背景切换
        self.RichEditTransparentItem.Checked = not self.RichEditTransparentItem.Checked
        self.Editor.Transparent = self.RichEditTransparentItem.Checked

    def RichEditWordWrapItemClick(self, Sender):
        # 自动换行切换
        self.RichEditWordWrapItem.Checked = not self.RichEditWordWrapItem.Checked
        if self.RichEditWordWrapItem.Checked:
            self.Editor.ScrollBars = 'ssVertical'
        else:
            self.Editor.ScrollBars = 'ssBoth'

    def HelpAboutItemClick(self, Sender):
        # 显示关于对话框
        ab = AboutBox(self)
        ab.ShowModal()
        ab.Free()

    def RulerItemMouseDown(self, Sender, Button, Shift, X, Y):
        # 标尺鼠标按下事件
        self.FDragOfs = (Sender.Width / 2)
        Sender.Left = (Sender.Left + X - self.FDragOfs)
        self.FDragging = True

    def RulerItemMouseMove(self, Sender, Shift, X, Y):
        # 标尺鼠标移动事件
        if self.FDragging:
            Sender.Left = Sender.Left + X - self.FDragOfs

    def FirstIndMouseUp(self, Sender, Button, Shift, X, Y):
        # 首行缩进鼠标释放事件
        self.FDragging = False
        self.Editor.Paragraph.FirstIndent = int((self.FirstInd.Left + self.FDragOfs - self.GutterWid) / self.RulerAdj)
        self.LeftIndMouseUp(Sender, Button, Shift, X, Y)

    def LeftIndMouseUp(self, Sender, Button, Shift, X, Y):
        # 左缩进鼠标释放事件
        self.FDragging = False
        self.Editor.Paragraph.LeftIndent = int((self.LeftInd.Left + self.FDragOfs - self.GutterWid) / self.RulerAdj) - self.Editor.Paragraph.FirstIndent
        self.SelectionChange(Sender)

    def RightIndMouseUp(self, Sender, Button, Shift, X, Y):
        # 右缩进鼠标释放事件
        self.FDragging = False
        self.Editor.Paragraph.RightIndent = int((self.Ruler.ClientWidth - self.RightInd.Left + self.FDragOfs - 2) / self.RulerAdj) -2 * self.GutterWid
        self.SelectionChange(Sender)

    def FontNameChange(self, Sender):
        # 字体名称改变事件
        if self.FontName.ItemIndex >= 0:
            if self.FUpdating:
                return
            self.CurrText().Name = self.FontName.Items[self.FontName.ItemIndex]

    def FileSave(self, Sender):
        # 保存文件
        if self.FFileName == self.sUntitled:
            self.FileSaveAs(Sender)
        else:
            self.Editor.Lines.SaveToFile(self.FFileName)
            self.Editor.Modified = False
            self.SetModified(False)

    def CheckFileSave(self):
        # 检查是否需要保存文件
        if not self.Editor.Modified:
            return
        SaveResp = Application.MessageBox(self.sSaveChanges.format(self.FFileName), 'Confirmation', MB_YESNOCANCEL or MB_ICONQUESTION)
        if SaveResp == IDYES:
            self.FileSave(self)
        elif SaveResp == IDNO:
            pass
        elif SaveResp == IDCANCEL:
            raise ValueError('取消操作')

    def FormCloseQuery(self, Sender, CanClose):
         # 窗体关闭前查询
        self.CheckFileSave()

    def EditorClick(self, Sender):
        # 编辑器点击事件
        self.UpdateCursorPos()

    def EditorLinkClick(self, Sender, URL, Button):
        # 编辑器链接点击事件
        if (Button == 'mbLeft') and (Application.MessageBox(self.sOpenLink.format(URL), 'Confirmation', MB_YESNO or MB_ICONQUESTION) == IDYES):
            Application.ShellExecute(self.Handle, 'open', URL, None, None, SW_SHOWNORMAL)

    def FormatRichEditBoldCmdUpdate(self, Sender):
        # 更新加粗按钮状态
        self.FormatRichEditBoldCmd.Checked = 'fsBold' in self.Editor.SelAttributes.Style

    def FormatRichEditItalicCmdUpdate(self, Sender):
        # 更新斜体按钮状态
        self.FormatRichEditItalicCmd.Checked = 'fsItalic' in self.Editor.SelAttributes.Style

    def FormatRichEditUnderlineCmdUpdate(self, Sender):
        # 更新下划线按钮状态
        self.FormatRichEditUnderlineCmd.Checked = 'fsUnderline' in self.Editor.SelAttributes.Style

    def FormatRichEditStrikeOutCmdUpdate(self, Sender):
        # 更新删除线按钮状态
        self.FormatRichEditStrikeOutCmd.Checked = 'fsStrikeOut' in self.Editor.SelAttributes.Style

    def FormatRichEditBulletsCmdUpdate(self, Sender):
        # 更新项目符号按钮状态
        self.FormatRichEditBulletsCmd.Checked = self.FormatRichEditBulletsCmd.Enabled and (self.Editor.Paragraph.Numbering == 'nsBullet')

    def FormatRichEditAlignLeftCmdUpdate(self, Sender):
        # 更新左对齐按钮状态
        self.FormatRichEditAlignLeftCmd.Checked = self.FormatRichEditAlignLeftCmd.Enabled and (self.Editor.Paragraph.Alignment == 'taLeftJustify')

    def FormatRichEditAlignRightCmdUpdate(self, Sender):
        # 更新右对齐按钮状态
        self.FormatRichEditAlignRightCmd.Checked = self.FormatRichEditAlignRightCmd.Enabled and (self.Editor.Paragraph.Alignment == 'taRightJustify')

    def FormatRichEditAlignCenterCmdUpdate(self, Sender):
        # 更新居中对齐按钮状态
        self.FormatRichEditAlignCenterCmd.Checked = self.FormatRichEditAlignCenterCmd.Enabled and (self.Editor.Paragraph.Alignment == 'taCenter')

    def SuperscriptCmdUpdate(self, Sender):
        # 更新上标按钮状态
        Sender.Checked = self.Editor.SelAttributes.Subscript == 'sstSuperscript'

    def SubscriptCmdUpdate(self, Sender):
        # 更新下标按钮状态
        Sender.Checked = self.Editor.SelAttributes.Subscript == 'sstSubscript'

    def FGColorBoxChange(self, Sender):
        # 前景色改变事件
        self.Editor.SelAttributes.Color = self.FGColorBox.Selected

    def BGColorBoxChange(self, Sender):
        # 背景色改变事件
        self.Editor.SelAttributes.BackColor = self.BGColorBox.Selected

    def FontSizeChange(self, Sender):
        # 字体大小改变事件
        if self.FUpdating:
            return
        self.CurrText().Size = int(self.FontSize.Text)