import os
from glcl import *

class DropFilesDemoForm(Form):

    def __init__(self, owner):
        self.dfPanel = PJDropFiles(self)
        self.dfRTF = PJCtrlDropFiles(self)
        self.dfShape = PJDropFiles(self)
        self.Memo1 = Memo(self)
        self.chkFormIncFiles = CheckBox(self)
        self.chkPanelIncFiles = CheckBox(self)
        self.chkRTFIncFiles = CheckBox(self)
        self.chkShapeIncFiles = CheckBox(self)
        self.chkFormIncFolders = CheckBox(self)
        self.chkPanelIncFolders = CheckBox(self)
        self.chkRTFIncFolders = CheckBox(self)
        self.chkShapeIncFolders = CheckBox(self)
        self.chkFormRecurseFolders = CheckBox(self)
        self.chkPanelRecurseFolders = CheckBox(self)
        self.chkRTFRecurseFolders = CheckBox(self)
        self.chkShapeRecurseFolders = CheckBox(self)
        self.chkFormEnabled = CheckBox(self)
        self.chkPanelPassThru = CheckBox(self)
        self.chkPanelEnabled = CheckBox(self)
        self.chkRTFPassThru = CheckBox(self)
        self.chkRTFEnabled = CheckBox(self)
        self.chkShapePassThru = CheckBox(self)
        self.chkShapeEnabled = CheckBox(self)
        self.edExtensions = Edit(self)
        self.edWildcard = Edit(self)
        self.chkFormEnableFilter = CheckBox(self)
        self.chkPanelEnableFilter = CheckBox(self)
        self.chkRTFEnableFilter = CheckBox(self)
        self.chkFormShowRejections = CheckBox(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.dfShape.OnDropFiles = self.dfShapeDropFiles
        self.dfRTF.OnDropFiles = self.dfRTFDropFiles
        self.dfPanel.OnDropFiles = self.dfPanelDropFiles
        self.chkRTFEnableFilter.OnClick = self.chkRTFEnableFilterClick
        self.chkPanelEnableFilter.OnClick = self.chkPanelEnableFilterClick
        self.edWildcard.OnChange = self.edWildcardChange
        self.edExtensions.OnChange = self.edExtensionsChange
        self.dfForm.OnDropFiles = self.dfFormDropFiles
        self.chkFormEnabled.OnClick = self.chkFormEnabledClick
        self.chkShapeEnabled.OnClick = self.chkShapeEnabledClick
        self.chkShapePassThru.OnClick = self.chkShapePassThruClick
        self.chkRTFEnabled.OnClick = self.chkRTFEnabledClick
        self.chkRTFPassThru.OnClick = self.chkRTFPassThruClick
        self.chkPanelEnabled.OnClick = self.chkPanelEnabledClick
        self.chkPanelPassThru.OnClick = self.chkPanelPassThruClick
        self.chkFormIncFiles.OnClick = self.FormOptionsClick
        self.chkPanelIncFiles.OnClick = self.PanelOptionsClick
        self.chkRTFIncFiles.OnClick = self.RTFOptionsClick
        self.chkShapeIncFiles.OnClick = self.ShapeOptionsClick
        self.chkFormIncFolders.OnClick = self.FormOptionsClick
        self.chkPanelIncFolders.OnClick = self.PanelOptionsClick
        self.chkRTFIncFolders.OnClick = self.RTFOptionsClick
        self.chkShapeIncFolders.OnClick = self.ShapeOptionsClick
        self.chkFormRecurseFolders.OnClick = self.FormOptionsClick
        self.chkPanelRecurseFolders.OnClick = self.PanelOptionsClick
        self.chkRTFRecurseFolders.OnClick = self.RTFOptionsClick
        self.chkShapeRecurseFolders.OnClick = self.ShapeOptionsClick
        self.chkPanelEnabled.OnClick = self.FormOptionsClick
        self.chkFormShowRejections.OnClick = self.FormOptionsClick

        self.dfForm.OnFileFilter = self.dfFormFileFilter
        self.chkFormEnableFilter.OnClick = self.chkFormEnableFilterClick
        self.PJDropFilesOption = [dfoIncFolders, dfoIncFiles, dfoRecurseFolders]
        self.Caption = Application.Title
        self.chkFormIncFiles.Tag = self.PJDropFilesOption.index(dfoIncFiles)
        self.chkPanelIncFiles.Tag = self.PJDropFilesOption.index(dfoIncFiles)
        self.chkRTFIncFiles.Tag = self.PJDropFilesOption.index(dfoIncFiles)
        self.chkShapeIncFiles.Tag = self.PJDropFilesOption.index(dfoIncFiles)
        self.chkFormIncFolders.Tag = self.PJDropFilesOption.index(dfoIncFolders)
        self.chkPanelIncFolders.Tag = self.PJDropFilesOption.index(dfoIncFolders)
        self.chkRTFIncFolders.Tag = self.PJDropFilesOption.index(dfoIncFolders)
        self.chkShapeIncFolders.Tag = self.PJDropFilesOption.index(dfoIncFolders)
        self.chkFormRecurseFolders.Tag = self.PJDropFilesOption.index(dfoRecurseFolders)
        self.chkPanelRecurseFolders.Tag = self.PJDropFilesOption.index(dfoRecurseFolders)
        self.chkRTFRecurseFolders.Tag = self.PJDropFilesOption.index(dfoRecurseFolders)
        self.chkShapeRecurseFolders.Tag = self.PJDropFilesOption.index(dfoRecurseFolders)
        self.chkFormIncFiles.Checked = dfoIncFiles in self.dfForm.Options
        self.chkFormIncFolders.Checked = dfoIncFolders in self.dfForm.Options
        self.chkFormRecurseFolders.Checked = dfoRecurseFolders in self.dfForm.Options
        self.chkFormEnabled.Checked = self.dfForm.Enabled
        self.chkPanelIncFiles.Checked = dfoIncFiles in self.dfPanel.Options
        self.chkPanelIncFolders.Checked = dfoIncFolders in self.dfPanel.Options
        self.chkPanelRecurseFolders.Checked = dfoRecurseFolders in self.dfPanel.Options
        self.chkPanelPassThru.Checked = self.dfPanel.PassThrough
        self.chkPanelEnabled.Checked = self.dfPanel.Enabled
        self.chkRTFIncFiles.Checked = dfoIncFiles in self.dfRTF.Options
        self.chkRTFIncFolders.Checked = dfoIncFolders in self.dfRTF.Options
        self.chkRTFRecurseFolders.Checked = dfoRecurseFolders in self.dfRTF.Options
        self.chkRTFPassThru.Checked = self.dfRTF.PassThrough
        self.chkRTFEnabled.Checked = self.dfRTF.Enabled
        self.chkShapeIncFiles.Checked = dfoIncFiles in self.dfShape.Options
        self.chkShapeIncFolders.Checked = dfoIncFolders in self.dfShape.Options
        self.chkShapeRecurseFolders.Checked = dfoRecurseFolders in self.dfShape.Options
        self.chkShapePassThru.Checked = self.dfShape.PassThrough
        self.chkShapeEnabled.Checked = self.dfShape.Enabled
        self.edExtensions.Text = self.PanelExtFilter.Extensions
        self.edWildcard.Text = self.RTFWildcardFilter.WildCard
        self.chkFormEnableFilter.Checked = (self.dfForm.OnFileFilter != None)
        self.chkPanelEnableFilter.Checked = (self.dfPanel.Filter != None)
        self.chkRTFEnableFilter.Checked = (self.dfRTF.Filter != None)
        self.chkFormShowRejections.Checked = False
        self.Panel1.ParentBackground = False

    def FormOptionsClick(self, Sender):
        if Sender.Checked:
            self.dfForm.Options += [self.PJDropFilesOption[Sender.Tag]]
        else:
            self.dfForm.Options = list(set(self.dfForm.Options) - set([self.PJDropFilesOption[Sender.Tag]]))

    def PanelOptionsClick(self, Sender):
        if Sender.Checked:
            self.dfPanel.Options += [self.PJDropFilesOption[Sender.Tag]]
        else:
            self.dfPanel.Options = list(set(self.dfPanel.Options) - set([self.PJDropFilesOption[Sender.Tag]]))

    def RTFOptionsClick(self, Sender):
        if Sender.Checked:
            self.dfRTF.Options += [self.PJDropFilesOption[Sender.Tag]]
        else:
            self.dfRTF.Options = list(set(self.dfRTF.Options) - set([self.PJDropFilesOption[Sender.Tag]]))

    def ShapeOptionsClick(self, Sender):
        if Sender.Checked:
            self.dfShape.Options += [self.PJDropFilesOption[Sender.Tag]]
        else:
            self.dfShape.Options = list(set(self.dfShape.Options) - set([self.PJDropFilesOption[Sender.Tag]]))

    def chkFormEnableFilterClick(self, Sender):
        if self.chkFormEnableFilter.Checked:
            self.dfForm.OnFileFilter = self.dfFormFileFilter
        else:
            self.dfForm.OnFileFilter = None

    def dfFormFileFilter(self, Sender, FileName, IsFolder, Accept):
        if self.chkFormShowRejections.Checked:
            self.Memo1.Lines.Add('Rejected: ' + FileName)

    def chkPanelPassThruClick(self, Sender):
        self.dfPanel.PassThrough = self.chkPanelPassThru.Checked

    def chkPanelEnabledClick(self, Sender):
        self.dfPanel.Enabled = self.chkPanelEnabled.Checked

    def chkRTFPassThruClick(self, Sender):
        self.dfRTF.PassThrough = self.chkRTFPassThru.Checked

    def chkRTFEnabledClick(self, Sender):
        self.dfRTF.Enabled = self.chkRTFEnabled.Checked

    def chkShapePassThruClick(self, Sender):
        self.dfShape.PassThrough = self.chkShapePassThru.Checked

    def chkShapeEnabledClick(self, Sender):
        self.dfShape.Enabled = self.chkShapeEnabled.Checked

    def chkFormEnabledClick(self, Sender):
        self.dfForm.Enabled = self.chkFormEnabled.Checked

    def DropControlInfo(self, Ctrl, Point):
        return "%s at (%d.%d)" % (Ctrl.Name, Point.X, Point.Y)

    def dfFormDropFiles(self, Sender):
        for I in range(0, self.dfForm.Count):
            self.Memo1.Lines.Add('File: ' + self.dfForm.Files[I])
        self.Memo1.Lines.Add('Drop info: ' + self.DropControlInfo(self.dfForm.DropControl, self.dfForm.DropPoint))

    def edExtensionsChange(self, Sender):
        self.PanelExtFilter.Extensions = self.edExtensions.Text

    def edWildcardChange(self, Sender):
        self.RTFWildcardFilter.WildCard = self.edWildcard.Text

    def chkPanelEnableFilterClick(self, Sender):
        if self.chkPanelEnableFilter.Checked:
            self.dfPanel.Filter = self.PanelExtFilter
        else:
            self.dfPanel.Filter = None

    def chkRTFEnableFilterClick(self, Sender):
        if self.chkRTFEnableFilter.Checked:
            self.dfRTF.Filter = self.RTFWildcardFilter
        else:
            self.dfRTF.Filter = None

    def dfPanelDropFiles(self, Sender):
        for I in range(0, self.dfPanel.Count):
            self.Memo1.Lines.Add('File: ' + self.dfPanel.Files[I])
        self.Memo1.Lines.Add('Drop info: ' + self.DropControlInfo(self.dfPanel.DropControl, self.dfPanel.DropPoint))

    def dfRTFDropFiles(self, Sender):
        for I in range(0, self.dfRTF.Count):
            self.Memo1.Lines.Add('File: ' + self.dfRTF.Files[I])
        self.Memo1.Lines.Add('Drop info: ' + self.DropControlInfo(self.dfRTF.DropControl, self.dfRTF.DropPoint))

    def dfShapeDropFiles(self, Sender):
        for I in range(0, self.dfShape.Count):
            self.Memo1.Lines.Add('File: ' + self.dfShape.Files[I])
        self.Memo1.Lines.Add('Drop info: ' + self.DropControlInfo(self.dfShape.DropControl, self.dfShape.DropPoint))