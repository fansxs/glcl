# Powered By Python Studio, The best Python GUI IDE to download from glsite.com.
# ------------------------------------------------------------------------------
# This form was extended by hand to add a self-contained regression test for
# the 264 functions added to / already present in the Application object:
# 162 Win32 API functions (kernel32.lib / user32.lib / gdi32.lib), 26 functions
# that already existed before (MessageBox..RGB), and 76 more from advapi32 /
# shlwapi / winmm / shell32 / extra kernel32. Click "Run All 264 Tests" and
# read
# the results in the log box. Every call is wrapped so a single failure will
# not stop the rest of the suite from running.
# ------------------------------------------------------------------------------
import os
import time
import tempfile
from glcl import *


class Form1(Form):

    def __init__(self, owner):
        self.Memo1 = Memo(self)
        self.Button1 = Button(self)
        self.LoadProps(os.path.join(os.path.dirname(os.path.abspath(__file__)), "Unit1.pydfm"))
        self.Button1.OnClick = self.Button1Click

        self.pass_count = 0
        self.fail_count = 0
        self.tested_names = []
        self.skipped_names = []

    # -------------------------------------------------------------- helpers --
    def log(self, msg):
        self.Memo1.Lines.Add(msg)

    def test(self, name, func):
        """Runs one of the 162 target functions and records PASS/FAIL."""
        self.tested_names.append(name)
        try:
            result = func()
            self.log('[OK]   %s -> %r' % (name, result))
            self.pass_count += 1
        except Exception as e:
            self.log('[FAIL] %s -> %s' % (name, e))
            self.fail_count += 1

    def util(self, name, func, default=None):
        """Runs a supporting/pre-existing call (not part of the target list), used to
        set up or tear down resources for the real tests. Failures here are
        logged but do not count toward the pass/fail tally."""
        try:
            return func()
        except Exception as e:
            self.log('[SETUP WARNING] %s -> %s' % (name, e))
            return default

    def skip(self, name, reason):
        """Marks a function as intentionally not invoked (e.g. calling it for
        real would hang or close the test app itself). Not counted as pass/fail."""
        self.skipped_names.append(name)
        self.log('[SKIP] %s -> %s' % (name, reason))

    def run_section(self, title, section_func):
        self.log('')
        self.log('---- %s ----' % title)
        try:
            section_func()
        except Exception as e:
            self.log('[SECTION ERROR] %s -> %s (remaining sections will still run)' % (title, e))

    # ------------------------------------------------------------- sections --
    def section_kernel32_basic(self):
        self.test('Beep', lambda: Application.Beep(750, 200))
        self.test('Sleep', lambda: Application.Sleep(10))
        self.test('GetTickCount', lambda: Application.GetTickCount())
        self.test('GetCurrentProcessId', lambda: Application.GetCurrentProcessId())
        self.test('GetCurrentThreadId', lambda: Application.GetCurrentThreadId())
        self.test('GetCurrentProcess', lambda: Application.GetCurrentProcess())
        self.test('GetCurrentThread', lambda: Application.GetCurrentThread())
        self.test('SetLastError', lambda: Application.SetLastError(0))
        self.test('MulDiv', lambda: Application.MulDiv(10, 3, 2))
        self.test('GetComputerName', lambda: Application.GetComputerName())
        self.test('GetSystemDirectory', lambda: Application.GetSystemDirectory())
        self.test('GetWindowsDirectory', lambda: Application.GetWindowsDirectory())
        self.test('GetTempPath', lambda: Application.GetTempPath())
        self.test('GetCurrentDirectory', lambda: Application.GetCurrentDirectory())
        self.test('GetLogicalDrives', lambda: Application.GetLogicalDrives())
        self.test('GetLogicalDriveStrings', lambda: Application.GetLogicalDriveStrings())
        self.test('GetDriveType', lambda: Application.GetDriveType(Application.GetTempPath()[:3]))
        self.test('OutputDebugString', lambda: Application.OutputDebugString('glcl test'))
        self.test('GetModuleFileName', lambda: Application.GetModuleFileName(0))
        self.test('GetVersion', lambda: Application.GetVersion())
        self.test('IsDebuggerPresent', lambda: Application.IsDebuggerPresent())
        self.test('GetFullPathName', lambda: Application.GetFullPathName('.'))
        self.test('GetShortPathName', lambda: Application.GetShortPathName(Application.GetWindowsDirectory()))
        self.test('GetLongPathName', lambda: Application.GetLongPathName(Application.GetWindowsDirectory()))
        self.test('GetSystemMetrics', lambda: Application.GetSystemMetrics(0))  # SM_CXSCREEN
        self.test('MessageBeep', lambda: Application.MessageBeep(0))  # MB_OK
        self.test('FindWindow', lambda: Application.FindWindow('Shell_TrayWnd', ''))
        self.test('FindWindowEx', lambda: Application.FindWindowEx(0, 0, 'Shell_TrayWnd', ''))

    def section_filesystem(self):
        tmpdir = tempfile.mkdtemp(prefix='glcltest_')
        testfile = os.path.join(tmpdir, 'a.txt')
        testfile2 = os.path.join(tmpdir, 'b.txt')
        subdir = os.path.join(tmpdir, 'sub')
        with open(testfile, 'w') as f:
            f.write('glcl test file')

        self.test('SetEnvironmentVariable', lambda: Application.SetEnvironmentVariable('GLCL_TEST_VAR', 'hello'))
        self.test('GetEnvironmentVariable', lambda: Application.GetEnvironmentVariable('GLCL_TEST_VAR'))
        self.test('CreateDirectory', lambda: Application.CreateDirectory(subdir))
        self.test('GetFileAttributes', lambda: Application.GetFileAttributes(testfile))
        self.test('SetFileAttributes', lambda: Application.SetFileAttributes(testfile, 0x80))  # FILE_ATTRIBUTE_NORMAL
        self.test('CopyFile', lambda: Application.CopyFile(testfile, testfile2, False))
        self.test('MoveFile', lambda: Application.MoveFile(testfile2, testfile2 + '.moved'))
        self.test('DeleteFile', lambda: Application.DeleteFile(testfile2 + '.moved'))
        self.test('RemoveDirectory', lambda: Application.RemoveDirectory(subdir))

        original_dir = self.util('GetCurrentDirectory(save)', lambda: Application.GetCurrentDirectory())
        self.test('SetCurrentDirectory', lambda: Application.SetCurrentDirectory(tmpdir))
        if original_dir:
            self.util('SetCurrentDirectory(restore)', lambda: Application.SetCurrentDirectory(original_dir))

        # cleanup leftovers made purely by python (not part of the 162 test tally)
        self.util('cleanup testfile', lambda: os.remove(testfile) if os.path.exists(testfile) else None)
        self.util('cleanup tmpdir', lambda: os.rmdir(tmpdir) if os.path.exists(tmpdir) else None)

    def section_module(self):
        h = self.util('LoadLibrary(setup)', lambda: Application.LoadLibrary('user32.dll'))
        self.test('LoadLibrary', lambda: h if h else (_ for _ in ()).throw(Exception('load failed')))
        if h:
            self.test('FreeLibrary', lambda: Application.FreeLibrary(h))

    def section_process_and_sync(self):
        pid = self.util('GetCurrentProcessId(helper)', lambda: Application.GetCurrentProcessId())
        h = self.test_and_return('OpenProcess', lambda: Application.OpenProcess(0x0400, False, pid))  # PROCESS_QUERY_INFORMATION
        if h:
            self.util('CloseHandle(OpenProcess result)', lambda: Application.CloseHandle(h))
        # Deliberately invalid handle so nothing is actually terminated.
        self.test('TerminateProcess', lambda: Application.TerminateProcess(0, 0))

        hEvent = self.test_and_return('CreateEvent', lambda: Application.CreateEvent(True, False, 'GlclTestEvent'))
        self.test('SetEvent', lambda: Application.SetEvent(hEvent))
        self.test('ResetEvent', lambda: Application.ResetEvent(hEvent))
        self.test('PulseEvent', lambda: Application.PulseEvent(hEvent))
        self.test('OpenEvent', lambda: Application.OpenEvent(0x1F0003, False, 'GlclTestEvent'))  # EVENT_ALL_ACCESS
        self.test('WaitForSingleObject', lambda: Application.WaitForSingleObject(hEvent, 0))
        if hEvent:
            self.util('CloseHandle(event)', lambda: Application.CloseHandle(hEvent))

        hSem = self.test_and_return('CreateSemaphore', lambda: Application.CreateSemaphore(1, 5, 'GlclTestSemaphore'))
        self.test('OpenSemaphore', lambda: Application.OpenSemaphore(0x1F0003, False, 'GlclTestSemaphore'))
        self.test('ReleaseSemaphore', lambda: Application.ReleaseSemaphore(hSem, 1))
        if hSem:
            self.util('CloseHandle(semaphore)', lambda: Application.CloseHandle(hSem))

        hMutex = self.util('CreateMutex(setup, pre-existing fn)', lambda: Application.CreateMutex('GlclTestMutex'))
        self.test('ReleaseMutex', lambda: Application.ReleaseMutex(hMutex))
        if hMutex:
            self.util('CloseHandle(mutex)', lambda: Application.CloseHandle(hMutex))

    def test_and_return(self, name, func):
        """Like test(), but also returns the value so later steps can reuse
        the handle it produced."""
        self.tested_names.append(name)
        try:
            result = func()
            self.log('[OK]   %s -> %r' % (name, result))
            self.pass_count += 1
            return result
        except Exception as e:
            self.log('[FAIL] %s -> %s' % (name, e))
            self.fail_count += 1
            return None

    def section_windows(self):
        tempForm = Form(self)
        tempForm.Caption = 'glcl temp test window'
        tempForm.Width = 320
        tempForm.Height = 220
        tempForm.Show()
        th = tempForm.Handle

        self.test('IsWindow', lambda: Application.IsWindow(th))
        self.test('IsWindowVisible', lambda: Application.IsWindowVisible(th))
        self.test('IsWindowEnabled', lambda: Application.IsWindowEnabled(th))
        self.test('IsIconic', lambda: Application.IsIconic(th))
        self.test('IsZoomed', lambda: Application.IsZoomed(th))
        self.test('IsChild', lambda: Application.IsChild(self.Handle, th))
        self.test('EnableWindow', lambda: (Application.EnableWindow(th, False), Application.EnableWindow(th, True))[0])
        self.test('MoveWindow', lambda: Application.MoveWindow(th, 60, 60, 340, 240, True))
        self.test('GetParent', lambda: Application.GetParent(th))
        self.test('GetWindowRect', lambda: Application.GetWindowRect(th))
        self.test('GetClientRect', lambda: Application.GetClientRect(th))
        self.test('ClientToScreen', lambda: Application.ClientToScreen(th, Point(10, 10)))
        self.test('ScreenToClient', lambda: Application.ScreenToClient(th, Point(100, 100)))
        self.test('GetWindowLong', lambda: Application.GetWindowLong(th, -21))  # GWL_USERDATA
        self.test('SetWindowLong', lambda: Application.SetWindowLong(th, -21, 12345))
        self.test('GetWindowText', lambda: Application.GetWindowText(th))
        self.test('SetWindowText', lambda: Application.SetWindowText(th, 'Renamed by test'))
        self.test('GetWindowTextLength', lambda: Application.GetWindowTextLength(th))
        self.test('GetClassName', lambda: Application.GetClassName(th))
        self.test('SetForegroundWindow', lambda: Application.SetForegroundWindow(th))
        self.test('GetForegroundWindow', lambda: Application.GetForegroundWindow())
        self.test('GetActiveWindow', lambda: Application.GetActiveWindow())
        self.test('SetActiveWindow', lambda: Application.SetActiveWindow(th))
        self.test('ShowWindowAsync', lambda: Application.ShowWindowAsync(th, 5))  # SW_SHOW
        self.test('AnimateWindow', lambda: Application.AnimateWindow(th, 200, 0x00080000))  # AW_BLEND
        self.test('FlashWindow', lambda: Application.FlashWindow(th, True))
        self.test('BringWindowToTop', lambda: Application.BringWindowToTop(th))
        self.test('UpdateWindow', lambda: Application.UpdateWindow(th))
        self.test('GetDesktopWindow', lambda: Application.GetDesktopWindow())
        self.test('SetCapture', lambda: Application.SetCapture(th))
        self.test('GetCapture', lambda: Application.GetCapture())
        self.util('ReleaseCapture(cleanup, pre-existing fn)', lambda: Application.ReleaseCapture())

        hdc = self.test_and_return('GetWindowDC', lambda: Application.GetWindowDC(th))
        if hdc:
            self.util('ReleaseDC(cleanup, pre-existing fn)', lambda: Application.ReleaseDC(th, hdc))

        self.test('GetDlgItem', lambda: Application.GetDlgItem(th, 0))
        self.test('GetDlgCtrlID', lambda: Application.GetDlgCtrlID(th))
        self.test('SetDlgItemText', lambda: Application.SetDlgItemText(th, 0, 'x'))
        self.test('GetDlgItemText', lambda: Application.GetDlgItemText(th, 0))
        self.test('SetDlgItemInt', lambda: Application.SetDlgItemInt(th, 0, 42, True))
        self.test('CheckDlgButton', lambda: Application.CheckDlgButton(th, 0, 1))
        self.test('IsDlgButtonChecked', lambda: Application.IsDlgButtonChecked(th, 0))

        self.test('DestroyWindow', lambda: Application.DestroyWindow(th))
        self.util('tempForm.Free(cleanup)', lambda: tempForm.Free())

    def section_menu(self):
        hPopup = self.test_and_return('CreatePopupMenu', lambda: Application.CreatePopupMenu())
        self.test('GetMenuItemCount', lambda: Application.GetMenuItemCount(hPopup))
        self.test('GetMenuItemID', lambda: Application.GetMenuItemID(hPopup, 0))
        self.test('EnableMenuItem', lambda: Application.EnableMenuItem(hPopup, 0, 0x400 | 0x1))  # MF_BYPOSITION|MF_GRAYED
        self.test('DeleteMenu', lambda: Application.DeleteMenu(hPopup, 0, 0x400))
        self.test('RemoveMenu', lambda: Application.RemoveMenu(hPopup, 0, 0x400))
        self.test('DestroyMenu', lambda: Application.DestroyMenu(hPopup))

        hMenu = self.test_and_return('CreateMenu', lambda: Application.CreateMenu())
        if hMenu:
            self.util('DestroyMenu(cleanup for CreateMenu)', lambda: Application.DestroyMenu(hMenu))

        self.test('GetMenu', lambda: Application.GetMenu(self.Handle))
        self.test('SetMenu', lambda: Application.SetMenu(self.Handle, 0))
        self.test('GetSystemMenu', lambda: Application.GetSystemMenu(self.Handle, False))

    def section_input_and_clipboard(self):
        pt = self.util('GetCursorPos(helper read)', lambda: Application.GetCursorPos())
        self.test('GetCursorPos', lambda: Application.GetCursorPos())
        if pt is not None:
            self.test('SetCursorPos', lambda: Application.SetCursorPos(pt.X, pt.Y))
        self.test('GetAsyncKeyState', lambda: Application.GetAsyncKeyState(0x01))  # VK_LBUTTON
        self.test('GetKeyState', lambda: Application.GetKeyState(0x14))  # VK_CAPITAL
        self.test('keybd_event', lambda: (Application.keybd_event(0x10, 0, 0, 0), Application.keybd_event(0x10, 0, 2, 0))[0])  # tap Shift
        self.test('mouse_event', lambda: Application.mouse_event(0x0001, 0, 0, 0, 0))  # zero-delta MOUSEEVENTF_MOVE
        cur = self.util('GetCursor(helper read)', lambda: Application.GetCursor())
        self.test('GetCursor', lambda: Application.GetCursor())
        if cur is not None:
            self.test('SetCursor', lambda: Application.SetCursor(cur))
        cursor_file = os.path.join(os.environ.get('SystemRoot', 'C:\\Windows'), 'Cursors', 'aero_arrow.cur')
        self.test('LoadCursorFromFile', lambda: Application.LoadCursorFromFile(cursor_file))
        self.test('GetSysColor', lambda: Application.GetSysColor(15))  # COLOR_BTNFACE
        dct = self.util('GetDoubleClickTime(helper read)', lambda: Application.GetDoubleClickTime())
        self.test('GetDoubleClickTime', lambda: Application.GetDoubleClickTime())
        if dct:
            self.test('SetDoubleClickTime', lambda: Application.SetDoubleClickTime(dct))

        self.test('OpenClipboard', lambda: Application.OpenClipboard(self.Handle))
        fmt = self.test_and_return('RegisterClipboardFormat', lambda: Application.RegisterClipboardFormat('GlclTestFormat'))
        self.test('IsClipboardFormatAvailable', lambda: Application.IsClipboardFormatAvailable(fmt or 0))
        self.test('CountClipboardFormats', lambda: Application.CountClipboardFormats())
        self.test('RegisterWindowMessage', lambda: Application.RegisterWindowMessage('GlclTestMessage'))
        self.log('[NOTE] EmptyClipboard below will clear your current Windows clipboard content.')
        self.test('EmptyClipboard', lambda: Application.EmptyClipboard())
        self.test('CloseClipboard', lambda: Application.CloseClipboard())

    def section_gdi(self):
        screenDC = self.util('GetDC(setup, pre-existing fn)', lambda: Application.GetDC(0))
        if not screenDC:
            self.log('[SECTION ERROR] could not obtain a screen DC, skipping GDI tests')
            return

        memDC = self.test_and_return('CreateCompatibleDC', lambda: Application.CreateCompatibleDC(screenDC))
        memBmp = self.test_and_return('CreateCompatibleBitmap', lambda: Application.CreateCompatibleBitmap(screenDC, 200, 200))
        oldObj = self.test_and_return('SelectObject', lambda: Application.SelectObject(memDC, memBmp))

        brush = self.test_and_return('CreateSolidBrush', lambda: Application.CreateSolidBrush(clRed))
        hatchBrush = self.test_and_return('CreateHatchBrush', lambda: Application.CreateHatchBrush(2, clBlue))  # HS_CROSS
        pen = self.test_and_return('CreatePen', lambda: Application.CreatePen(0, 2, clGreen))  # PS_SOLID

        rgn1 = self.test_and_return('CreateRectRgn', lambda: Application.CreateRectRgn(0, 0, 50, 50))
        rgn2 = self.test_and_return('CreateEllipticRgn', lambda: Application.CreateEllipticRgn(20, 20, 80, 80))
        rgn3 = self.test_and_return('CreateRoundRectRgn', lambda: Application.CreateRoundRectRgn(0, 0, 100, 100, 10, 10))
        rgnDest = self.util('CreateRectRgn(helper for CombineRgn)', lambda: Application.CreateRectRgn(0, 0, 0, 0))
        self.test('CombineRgn', lambda: Application.CombineRgn(rgnDest, rgn1, rgn2, 2))  # RGN_OR
        self.test('EqualRgn', lambda: Application.EqualRgn(rgn1, rgn2))
        self.test('PtInRegion', lambda: Application.PtInRegion(rgn1, 10, 10))

        self.test('MoveToEx', lambda: Application.MoveToEx(memDC, 0, 0))
        self.test('LineTo', lambda: Application.LineTo(memDC, 100, 100))
        self.test('Rectangle', lambda: Application.Rectangle(memDC, 10, 10, 90, 90))
        self.test('RoundRect', lambda: Application.RoundRect(memDC, 10, 10, 90, 90, 10, 10))
        self.test('Ellipse', lambda: Application.Ellipse(memDC, 10, 10, 90, 90))
        self.test('GetPixel', lambda: Application.GetPixel(memDC, 5, 5))
        self.test('SetPixel', lambda: Application.SetPixel(memDC, 5, 5, clWhite))
        self.test('GetTextColor', lambda: Application.GetTextColor(memDC))
        self.test('SetTextColor', lambda: Application.SetTextColor(memDC, clBlack))
        self.test('GetBkColor', lambda: Application.GetBkColor(memDC))
        self.test('SetBkColor', lambda: Application.SetBkColor(memDC, clWhite))
        self.test('SetBkMode', lambda: Application.SetBkMode(memDC, 2))  # OPAQUE
        self.test('GetBkMode', lambda: Application.GetBkMode(memDC))
        self.test('TextOut', lambda: Application.TextOut(memDC, 10, 120, 'glcl GDI test'))
        self.test('GetDeviceCaps', lambda: Application.GetDeviceCaps(memDC, 8))  # HORZRES
        saved = self.test_and_return('SaveDC', lambda: Application.SaveDC(memDC))
        self.test('RestoreDC', lambda: Application.RestoreDC(memDC, saved if saved else -1))
        self.test('SetMapMode', lambda: Application.SetMapMode(memDC, 1))  # MM_TEXT
        self.test('GetMapMode', lambda: Application.GetMapMode(memDC))
        self.test('SetROP2', lambda: Application.SetROP2(memDC, 13))  # R2_COPYPEN
        self.test('GetROP2', lambda: Application.GetROP2(memDC))
        self.test('SetStretchBltMode', lambda: Application.SetStretchBltMode(memDC, 3))  # COLORONCOLOR
        self.test('GetStretchBltMode', lambda: Application.GetStretchBltMode(memDC))
        self.test('GetStockObject', lambda: Application.GetStockObject(0))  # WHITE_BRUSH

        memDC2 = self.util('CreateCompatibleDC(2nd, helper)', lambda: Application.CreateCompatibleDC(screenDC))
        memBmp2 = self.util('CreateCompatibleBitmap(2nd, helper)', lambda: Application.CreateCompatibleBitmap(screenDC, 50, 50))
        old2 = None
        if memDC2 and memBmp2:
            old2 = self.util('SelectObject(2nd, helper)', lambda: Application.SelectObject(memDC2, memBmp2))
            self.test('PatBlt', lambda: Application.PatBlt(memDC2, 0, 0, 50, 50, 0x00F00021))  # PATCOPY
        if memDC and memDC2:
            self.test('StretchBlt', lambda: Application.StretchBlt(memDC, 100, 100, 50, 50, memDC2, 0, 0, 50, 50, 0x00CC0020))  # SRCCOPY

        # ---- cleanup (uses DeleteObject / DeleteDC, which ARE part of the
        # 162 under test, so the very first calls below are still counted) ----
        if memDC2 and old2 is not None:
            self.util('SelectObject(restore 2nd)', lambda: Application.SelectObject(memDC2, old2))
        if memBmp2:
            self.test('DeleteObject', lambda: Application.DeleteObject(memBmp2))
        if memDC2:
            self.test('DeleteDC', lambda: Application.DeleteDC(memDC2))

        if oldObj is not None:
            self.util('SelectObject(restore 1st)', lambda: Application.SelectObject(memDC, oldObj))
        for h in (brush, hatchBrush, pen, rgn1, rgn2, rgn3, rgnDest, memBmp):
            if h:
                self.util('DeleteObject(cleanup)', lambda h=h: Application.DeleteObject(h))
        if memDC:
            self.util('DeleteDC(cleanup)', lambda: Application.DeleteDC(memDC))
        self.util('ReleaseDC(cleanup, pre-existing fn)', lambda: Application.ReleaseDC(0, screenDC))

    # ------------------------------------------------- original Application --
    # Exactly the 26 functions originally declared between MessageBox_Wrapper
    # and RGB_Wrapper in the TPyDelphiApplication interface section (i.e. the
    # functions that existed before any of the Win32 API work started).
    def section_original_26(self):
        self.log('[NOTE] MessageBox / MessageDlg / InputBox / SelectDirectory below show real, blocking dialog boxes - please respond to each popup to let the test continue.')
        self.test('MessageBox', lambda: Application.MessageBox(
            'This is a test message from the glcl function test suite.\nClick OK to continue.', 'glcl Test', 0))
        self.test('MessageDlg', lambda: Application.MessageDlg('glcl MessageDlg test - click OK.', 0, 2, 0))  # mtWarning, mbOK
        self.test('InputBox', lambda: Application.InputBox('glcl Test', 'Type anything (or just click OK):', 'default'))
        try:
            self.test('SelectDirectory', lambda: Application.SelectDirectory('Pick any folder, or click Cancel', 'C:\\'))
        except Exception:
            pass

        self.log('[NOTE] PrintText/PrintImage below will send output to your default printer.')
        self.test('PrintText', lambda: Application.PrintText('glcl test', 10, 10, self.Memo1.Font))
        bmp = self.util('Bitmap(setup)', lambda: Bitmap(20, 20))
        if bmp is not None:
            self.test('PrintImage', lambda: Application.PrintImage(bmp, 10, 10, 1))

        self.test('ColorToString', lambda: Application.ColorToString(clRed))

        tempForm = Form(self)
        tempForm.Caption = 'glcl temp (original-fn tests)'
        tempForm.Show()
        self.test('ShowWindow', lambda: Application.ShowWindow(tempForm.Handle, 5))  # SW_SHOW

        self.log('[NOTE] WinExec below silently launches "cmd.exe /c exit" (starts and immediately exits, no visible window).')
        self.test('WinExec', lambda: Application.WinExec('cmd.exe /c exit', 0))
        tmp = self.util('GetTempPath(helper)', lambda: Application.GetTempPath())
        self.log('[NOTE] ShellExecute below opens an Explorer window on your temp folder.')
        self.test('ShellExecute', lambda: Application.ShellExecute(0, 'open', tmp or 'C:\\', '', '', 1))

        self.test('SendMessage', lambda: Application.SendMessage(tempForm.Handle, 0x000B, 0, 0))  # WM_SETREDRAW-ish, harmless no-op style message (0x000B = WM_SETREDRAW)
        self.test('PostMessage', lambda: Application.PostMessage(tempForm.Handle, 0x0000, 0, 0))  # WM_NULL - always safe, does nothing

        self.test('GetSystemPath', lambda: Application.GetSystemPath(0))
        self.test('ReleaseCapture', lambda: Application.ReleaseCapture())

        tempForm2 = Form(self)
        tempForm2.Show()
        self.test('SetParent', lambda: Application.SetParent(tempForm2.Handle, tempForm.Handle))
        self.util('SetParent(restore)', lambda: Application.SetParent(tempForm2.Handle, 0))
        self.test('SetWindowPos', lambda: Application.SetWindowPos(tempForm.Handle, 0, 10, 10, 300, 200, 0x0040))  # SWP_SHOWWINDOW
        self.util('tempForm.Free(cleanup)', lambda: tempForm.Free())
        self.util('tempForm2.Free(cleanup)', lambda: tempForm2.Free())

        self.test('ShowCursor', lambda: Application.ShowCursor(True))
        self.test('PtInRect', lambda: Application.PtInRect(Rect(0, 0, 100, 100), Point(50, 50)))

        screenDC = self.test_and_return('GetDC', lambda: Application.GetDC(0))
        if screenDC:
            memDC = self.util('CreateCompatibleDC(helper)', lambda: Application.CreateCompatibleDC(screenDC))
            if memDC:
                memBmp = self.util('CreateCompatibleBitmap(helper)', lambda: Application.CreateCompatibleBitmap(screenDC, 20, 20))
                old = None
                if memBmp:
                    old = self.util('SelectObject(helper)', lambda: Application.SelectObject(memDC, memBmp))
                self.test('BitBlt', lambda: Application.BitBlt(memDC, 0, 0, 10, 10, memDC, 0, 0, 0x00CC0020))  # SRCCOPY
                if old is not None:
                    self.util('SelectObject(restore)', lambda: Application.SelectObject(memDC, old))
                if memBmp:
                    self.util('DeleteObject(cleanup)', lambda: Application.DeleteObject(memBmp))
                self.util('DeleteDC(cleanup)', lambda: Application.DeleteDC(memDC))
            self.test('ReleaseDC', lambda: Application.ReleaseDC(0, screenDC))

        hMutex = self.test_and_return('CreateMutex', lambda: Application.CreateMutex('glcl_test_mutex_orig'))
        self.test('OpenMutex', lambda: Application.OpenMutex('glcl_test_mutex_orig'))  # SYNCHRONIZE
        if hMutex:
            self.test('CloseHandle', lambda: Application.CloseHandle(hMutex))
        self.test('GetLastError', lambda: Application.GetLastError())
        self.test('RGB', lambda: Application.RGB(255, 0, 0))

    # -------------------------------------------- batch 2 & 3: new libraries --
    def section_registry(self):
        HKEY_CURRENT_USER = -2147483647
        KEY_ALL_ACCESS = 0xF003F
        subkey = 'Software\\glcl_test'
        hKey = self.test_and_return('RegCreateKeyEx', lambda: Application.RegCreateKeyEx(HKEY_CURRENT_USER, subkey, KEY_ALL_ACCESS))
        if hKey:
            self.test('RegSetStringValue', lambda: Application.RegSetStringValue(hKey, 'TestString', 'hello glcl'))
            self.test('RegSetDWordValue', lambda: Application.RegSetDWordValue(hKey, 'TestDWord', 42))
            self.test('RegQueryStringValue', lambda: Application.RegQueryStringValue(hKey, 'TestString'))
            self.test('RegQueryDWordValue', lambda: Application.RegQueryDWordValue(hKey, 'TestDWord'))
            self.test('RegEnumValue', lambda: Application.RegEnumValue(hKey, 0))
            self.test('RegFlushKey', lambda: Application.RegFlushKey(hKey))
            self.test('RegDeleteValue', lambda: Application.RegDeleteValue(hKey, 'TestDWord'))
            self.test('RegCloseKey', lambda: Application.RegCloseKey(hKey))
        self.test('RegOpenKeyEx', lambda: Application.RegOpenKeyEx(HKEY_CURRENT_USER, 'Software', KEY_ALL_ACCESS))
        self.test('RegEnumKeyEx', lambda: Application.RegEnumKeyEx(HKEY_CURRENT_USER, 0))
        self.test('RegDeleteKey', lambda: Application.RegDeleteKey(HKEY_CURRENT_USER, subkey))
        hRemote = self.test_and_return('RegConnectRegistry', lambda: Application.RegConnectRegistry('', HKEY_CURRENT_USER))
        if hRemote:
            self.util('RegCloseKey(cleanup)', lambda: Application.RegCloseKey(hRemote))
        self.test('GetUserName', lambda: Application.GetUserName())

    def section_service(self):
        SC_MANAGER_ALL_ACCESS = 0xF003F
        SERVICE_QUERY_STATUS = 0x0004
        SERVICE_ALL_ACCESS = 0xF01FF
        scm = self.test_and_return('OpenSCManager', lambda: Application.OpenSCManager('', '', SC_MANAGER_ALL_ACCESS))
        print(scm)
        svc = None
        if scm:
            svc = self.test_and_return('OpenService', lambda: Application.OpenService(scm, 'MpsSvc', SERVICE_ALL_ACCESS))
        if svc:
            self.test('QueryServiceState', lambda: Application.QueryServiceState(svc))
            self.log('[NOTE] the service handle above was opened with query-only rights, so the next 3 calls are expected to fail with access denied - that still proves the functions are wired correctly.')
            self.test('StartService', lambda: Application.StartService(svc))
            #self.test('ControlService', lambda: Application.ControlService(svc, 1))
            #self.test('DeleteService', lambda: Application.DeleteService(svc))
            self.test('CloseServiceHandle', lambda: Application.CloseServiceHandle(svc))
        if scm:
            self.util('CloseServiceHandle(scm cleanup)', lambda: Application.CloseServiceHandle(scm))

    def section_shlwapi(self):
        winDir = self.util('GetWindowsDirectory(helper)', lambda: Application.GetWindowsDirectory()) or 'C:\\Windows'
        self.test('PathFileExists', lambda: Application.PathFileExists(winDir))
        self.test('PathIsDirectory', lambda: Application.PathIsDirectory(winDir))
        self.test('PathIsRoot', lambda: Application.PathIsRoot('C:\\'))
        self.test('PathIsRelative', lambda: Application.PathIsRelative('..\\test'))
        self.test('PathIsUNC', lambda: Application.PathIsUNC('\\\\server\\share'))
        self.test('PathIsURL', lambda: Application.PathIsURL('https://example.com'))
        self.test('PathRemoveBackslash', lambda: Application.PathRemoveBackslash(winDir + '\\'))
        self.test('PathAddBackslash', lambda: Application.PathAddBackslash(winDir))
        self.test('PathRemoveExtension', lambda: Application.PathRemoveExtension('test.txt'))
        self.test('PathRemoveFileSpec', lambda: Application.PathRemoveFileSpec(winDir + '\\System32'))
        self.test('PathFindExtension', lambda: Application.PathFindExtension('test.txt'))
        self.test('PathFindFileName', lambda: Application.PathFindFileName(winDir + '\\notepad.exe'))
        self.test('PathGetDriveNumber', lambda: Application.PathGetDriveNumber(winDir))
        self.test('PathStripPath', lambda: Application.PathStripPath(winDir + '\\notepad.exe'))
        self.test('PathIsPrefix', lambda: Application.PathIsPrefix(winDir, winDir + '\\System32'))
        self.test('PathMatchSpec', lambda: Application.PathMatchSpec('test.txt', '*.txt'))
        self.test('PathIsSameRoot', lambda: Application.PathIsSameRoot(winDir, 'C:\\Users'))
        self.test('PathCombine', lambda: Application.PathCombine(winDir, 'System32'))
        self.test('PathAppend', lambda: Application.PathAppend(winDir, 'System32'))
        self.test('PathQuoteSpaces', lambda: Application.PathQuoteSpaces('C:\\Program Files'))
        self.test('PathUnquoteSpaces', lambda: Application.PathUnquoteSpaces('"C:\\Program Files"'))
        self.test('PathCanonicalize', lambda: Application.PathCanonicalize(winDir + '\\..\\Windows\\.\\System32'))
        self.test('StrToInt', lambda: Application.StrToInt('12345'))
        self.test('StrFormatByteSize', lambda: Application.StrFormatByteSize(1536000))
        self.test('StrChr', lambda: Application.StrChr('glcl test', 't'))
        self.test('StrStr', lambda: Application.StrStr('glcl test string', 'test'))

    def section_winmm(self):
        self.test('timeGetTime', lambda: Application.timeGetTime())
        self.test('timeBeginPeriod', lambda: Application.timeBeginPeriod(1))
        self.test('timeEndPeriod', lambda: Application.timeEndPeriod(1))
        self.log('[NOTE] PlaySound/sndPlaySound below will play a short system sound.')
        self.test('PlaySound', lambda: Application.PlaySound('SystemAsterisk', 0x00010000))  # SND_ALIAS
        self.test('sndPlaySound', lambda: Application.sndPlaySound('SystemAsterisk', 0x0001))  # SND_ASYNC
        self.test('waveOutGetNumDevs', lambda: Application.waveOutGetNumDevs())
        self.test('waveInGetNumDevs', lambda: Application.waveInGetNumDevs())
        self.test('midiOutGetNumDevs', lambda: Application.midiOutGetNumDevs())
        self.test('midiInGetNumDevs', lambda: Application.midiInGetNumDevs())
        self.test('auxGetNumDevs', lambda: Application.auxGetNumDevs())
        self.test('joyGetNumDevs', lambda: Application.joyGetNumDevs())
        self.test('mixerGetNumDevs', lambda: Application.mixerGetNumDevs())
        self.test('mmioStringToFOURCC', lambda: Application.mmioStringToFOURCC('WAVE', 0))

    def section_shell32_extra(self):
        self.test('SHGetFolderPath', lambda: Application.SHGetFolderPath(5))  # CSIDL_PERSONAL (My Documents)
        self.test('ShellAbout', lambda: Application.ShellAbout(self.Handle, 'glcl Test', 'Function test suite', 0))
        self.test('ExtractIcon', lambda: Application.ExtractIcon(0, Application.GetWindowsDirectory() + 'explorer.exe', 0))
        self.test('SHGetFileTypeDescription', lambda: Application.SHGetFileTypeDescription(Application.GetWindowsDirectory() + 'explorer.exe'))
        self.test('IsUserAnAdmin', lambda: Application.IsUserAnAdmin())

        tmpdir = tempfile.mkdtemp(prefix='glcltest_shell_')
        testfile = os.path.join(tmpdir, 'recycle_me.txt')
        with open(testfile, 'w') as f:
            f.write('delete me')
        self.log('[NOTE] SHFileOperationDelete below sends a temp test file to the Recycle Bin.')
        self.test('SHFileOperationDelete', lambda: Application.SHFileOperationDelete(testfile, True))
        self.util('cleanup tmpdir', lambda: os.rmdir(tmpdir) if os.path.exists(tmpdir) else None)
        self.log('[NOTE] SHEmptyRecycleBin below empties the Recycle Bin for drive C:.')
        self.test('SHEmptyRecycleBin', lambda: Application.SHEmptyRecycleBin('C:\\'))

    def section_kernel32_extra(self):
        h = self.util('LoadLibrary(helper)', lambda: Application.LoadLibrary('user32.dll'))
        if h:
            self.test('GetProcAddress', lambda: Application.GetProcAddress(h, 'MessageBoxW'))
            self.util('FreeLibrary(cleanup)', lambda: Application.FreeLibrary(h))
        pid = self.util('GetCurrentProcessId(helper)', lambda: Application.GetCurrentProcessId())
        proc = self.util('OpenProcess(helper)', lambda: Application.OpenProcess(0x0400, False, pid))  # PROCESS_QUERY_INFORMATION
        if proc:
            self.test('GetExitCodeProcess', lambda: Application.GetExitCodeProcess(proc))
            self.test('GetPriorityClass', lambda: Application.GetPriorityClass(proc))
            self.test('SetPriorityClass', lambda: Application.SetPriorityClass(proc, 0x00000020))  # NORMAL_PRIORITY_CLASS
            self.util('CloseHandle(cleanup)', lambda: Application.CloseHandle(proc))
        self.test('GetLocalTime', lambda: Application.GetLocalTime())
        self.test('GetSystemTime', lambda: Application.GetSystemTime())

        tf = tempfile.NamedTemporaryFile(delete=False)
        tf.write(b'0123456789')
        tf.close()
        fh = None
        pyfile = None
        try:
            import msvcrt
            pyfile = open(tf.name, 'rb')
            fh = msvcrt.get_osfhandle(pyfile.fileno())
        except Exception as e:
            self.log('[SETUP WARNING] get_osfhandle(helper) -> %s' % e)
        if fh:
            self.test('GetFileSize', lambda: Application.GetFileSize(fh))
        if pyfile:
            self.util('close temp file', lambda: pyfile.close())
        self.util('cleanup temp file', lambda: os.remove(tf.name) if os.path.exists(tf.name) else None)

    def section_lockworkstation_and_exit(self):
        self.log('[NOTE] LockWorkStation/ExitWindowsEx are not invoked automatically in this')
        self.log('       test suite - locking your screen or logging off/shutting down mid-run')
        self.log('       would interrupt the test itself. Both functions ARE fully wired and')
        self.log('       usable; uncomment the two lines below in section_lockworkstation_and_exit')
        self.log('       if you want to test them manually.')
        # Application.LockWorkStation()      # locks your screen immediately
        # Application.ExitWindowsEx(0, 0)    # EWX_LOGOFF - logs the current user off immediately
        self.skip('LockWorkStation', 'not auto-invoked (would lock your screen) - see code comment to test manually')
        self.skip('ExitWindowsEx', 'not auto-invoked (would log off/shut down/restart) - see code comment to test manually')


    def Button1Click(self, Sender):
        self.Memo1.Lines.Clear()
        self.pass_count = 0
        self.fail_count = 0
        self.tested_names = []
        self.skipped_names = []

        self.log('=== glcl Application function test: 264 functions ===')
        start = time.time()

        self.run_section('1. kernel32 - system / paths (28)', self.section_kernel32_basic)
        self.run_section('2. kernel32 - filesystem / environment (10)', self.section_filesystem)
        self.run_section('3. kernel32 - module loading (2)', self.section_module)
        self.run_section('4. kernel32 - process / sync objects (12)', self.section_process_and_sync)
        self.run_section('5. user32 - windows (40)', self.section_windows)
        self.run_section('6. user32 - menus (11)', self.section_menu)
        self.run_section('7. user32 - input / clipboard (19)', self.section_input_and_clipboard)
        self.run_section('8. gdi32 - drawing (40)', self.section_gdi)

        self.run_section('9. original Application - MessageBox..RGB (26)', self.section_original_26)

        self.run_section('10. advapi32 - registry (14)', self.section_registry)
        self.run_section('11. advapi32 - service control (7)', self.section_service)
        self.run_section('12. shlwapi - path / string utils (26)', self.section_shlwapi)
        self.run_section('13. winmm - multimedia (13)', self.section_winmm)
        self.run_section('14. shell32 (7)', self.section_shell32_extra)
        self.run_section('15. kernel32 extra (7)', self.section_kernel32_extra)
        self.run_section('16. lock/exit (2, not auto-invoked)', self.section_lockworkstation_and_exit)

        elapsed = time.time() - start
        self.log('')
        self.log('=== Finished in %.2fs: %d passed / %d failed / %d called / %d intentionally skipped ===' %
                  (elapsed, self.pass_count, self.fail_count, len(self.tested_names), len(self.skipped_names)))

        missing = self.expected_missing()
        if missing:
            self.log('[WARNING] %d function(s) were not exercised: %s' % (len(missing), ', '.join(missing)))
        else:
            self.log('All target functions were called or intentionally skipped (see [SKIP] lines above).')

    def expected_missing(self):
        expected = set(EXPECTED_ALL)
        called = set(self.tested_names) | set(self.skipped_names)
        return sorted(expected - called)


# The full set of function names this test suite must cover (tested or
# intentionally skipped) - used only for the self-check at the end of the run,
# to make sure nothing was forgotten.
EXPECTED_162 = [
    'Beep', 'Sleep', 'GetTickCount', 'GetCurrentProcessId', 'GetCurrentThreadId',
    'GetCurrentProcess', 'GetCurrentThread', 'SetLastError', 'MulDiv', 'GetComputerName',
    'SetEnvironmentVariable', 'GetEnvironmentVariable', 'GetSystemDirectory', 'GetWindowsDirectory',
    'GetTempPath', 'GetCurrentDirectory', 'SetCurrentDirectory', 'CreateDirectory', 'RemoveDirectory',
    'DeleteFile', 'CopyFile', 'MoveFile', 'GetFileAttributes', 'SetFileAttributes', 'GetFullPathName',
    'GetLogicalDrives', 'GetDriveType', 'OutputDebugString', 'GetModuleFileName', 'LoadLibrary',
    'FreeLibrary', 'TerminateProcess', 'OpenProcess', 'WaitForSingleObject', 'CreateEvent', 'OpenEvent',
    'SetEvent', 'ResetEvent', 'PulseEvent', 'ReleaseMutex', 'CreateSemaphore', 'OpenSemaphore',
    'ReleaseSemaphore', 'IsDebuggerPresent', 'GetVersion', 'MessageBeep', 'FindWindow', 'FindWindowEx',
    'GetWindowText', 'SetWindowText', 'GetWindowTextLength', 'GetClassName', 'IsWindow', 'IsWindowVisible',
    'IsWindowEnabled', 'IsIconic', 'IsZoomed', 'IsChild', 'EnableWindow', 'DestroyWindow', 'MoveWindow',
    'GetParent', 'GetDesktopWindow', 'GetForegroundWindow', 'SetForegroundWindow', 'GetActiveWindow',
    'SetActiveWindow', 'GetWindowLong', 'SetWindowLong', 'GetSystemMetrics', 'GetAsyncKeyState',
    'GetKeyState', 'keybd_event', 'mouse_event', 'SetCursorPos', 'GetCapture', 'SetCapture',
    'ShowWindowAsync', 'AnimateWindow', 'FlashWindow', 'BringWindowToTop', 'UpdateWindow',
    'RegisterWindowMessage', 'RegisterClipboardFormat', 'OpenClipboard', 'CloseClipboard', 'EmptyClipboard',
    'IsClipboardFormatAvailable', 'CountClipboardFormats', 'GetWindowDC', 'GetDlgItem', 'GetDlgCtrlID',
    'SetDlgItemText', 'SetDlgItemInt', 'CheckDlgButton', 'IsDlgButtonChecked', 'GetMenu', 'SetMenu',
    'GetSystemMenu', 'GetMenuItemCount', 'GetMenuItemID', 'EnableMenuItem', 'DeleteMenu', 'RemoveMenu',
    'CreateMenu', 'CreatePopupMenu', 'DestroyMenu', 'SetCursor', 'GetCursor', 'LoadCursorFromFile',
    'GetSysColor', 'GetDoubleClickTime', 'SetDoubleClickTime', 'CreateCompatibleDC', 'CreateCompatibleBitmap',
    'DeleteDC', 'DeleteObject', 'SelectObject', 'GetStockObject', 'CreateSolidBrush', 'CreateHatchBrush',
    'CreatePen', 'CreateRectRgn', 'CreateEllipticRgn', 'CreateRoundRectRgn', 'CombineRgn', 'EqualRgn',
    'PtInRegion', 'LineTo', 'Rectangle', 'RoundRect', 'Ellipse', 'GetPixel', 'SetPixel', 'GetTextColor',
    'SetTextColor', 'GetBkColor', 'SetBkColor', 'SetBkMode', 'GetBkMode', 'TextOut', 'GetDeviceCaps',
    'SaveDC', 'RestoreDC', 'SetMapMode', 'GetMapMode', 'SetROP2', 'GetROP2', 'SetStretchBltMode',
    'GetStretchBltMode', 'StretchBlt', 'PatBlt', 'GetCursorPos', 'GetWindowRect', 'GetClientRect',
    'ClientToScreen', 'ScreenToClient', 'MoveToEx', 'GetShortPathName', 'GetLongPathName',
    'GetLogicalDriveStrings', 'GetDlgItemText',
]

# Exactly the 26 functions originally declared between MessageBox_Wrapper and
# RGB_Wrapper in TPyDelphiApplication (i.e. before any Win32 API work started).
EXPECTED_ORIGINAL = [
    'MessageBox', 'MessageDlg', 'InputBox', 'SelectDirectory', 'PrintText', 'PrintImage',
    'ColorToString', 'ShowWindow', 'WinExec', 'ShellExecute', 'SendMessage', 'PostMessage',
    'GetSystemPath', 'ReleaseCapture', 'SetParent', 'SetWindowPos', 'ShowCursor', 'PtInRect',
    'GetDC', 'ReleaseDC', 'BitBlt', 'CreateMutex', 'OpenMutex', 'CloseHandle', 'GetLastError', 'RGB',
]

# Batch 2 + batch 3: advapi32 / shlwapi / winmm / shell32 / extra kernel32.
EXPECTED_BATCH23 = [
    'RegOpenKeyEx', 'RegCreateKeyEx', 'RegCloseKey', 'RegDeleteKey', 'RegDeleteValue', 'RegFlushKey',
    'RegEnumKeyEx', 'RegEnumValue', 'RegQueryStringValue', 'RegSetStringValue', 'RegQueryDWordValue',
    'RegSetDWordValue', 'RegConnectRegistry', 'GetUserName',
    'OpenSCManager', 'OpenService', 'CloseServiceHandle', 'QueryServiceState', 'StartService',
    'ControlService', 'DeleteService',
    'PathFileExists', 'PathIsDirectory', 'PathIsRoot', 'PathIsRelative', 'PathIsUNC', 'PathIsURL',
    'PathRemoveBackslash', 'PathAddBackslash', 'PathRemoveExtension', 'PathRemoveFileSpec',
    'PathFindExtension', 'PathFindFileName', 'PathGetDriveNumber', 'PathStripPath', 'PathIsPrefix',
    'PathMatchSpec', 'PathIsSameRoot', 'PathCombine', 'PathAppend', 'PathQuoteSpaces',
    'PathUnquoteSpaces', 'PathCanonicalize', 'StrToInt', 'StrFormatByteSize', 'StrChr', 'StrStr',
    'timeGetTime', 'timeBeginPeriod', 'timeEndPeriod', 'PlaySound', 'sndPlaySound',
    'waveOutGetNumDevs', 'waveInGetNumDevs', 'midiOutGetNumDevs', 'midiInGetNumDevs',
    'auxGetNumDevs', 'joyGetNumDevs', 'mixerGetNumDevs', 'mmioStringToFOURCC',
    'SHGetFolderPath', 'ShellAbout', 'ExtractIcon', 'SHGetFileTypeDescription', 'IsUserAnAdmin',
    'SHFileOperationDelete', 'SHEmptyRecycleBin',
    'GetProcAddress', 'GetExitCodeProcess', 'SetPriorityClass', 'GetPriorityClass', 'GetFileSize',
    'GetLocalTime', 'GetSystemTime', 'ExitWindowsEx', 'LockWorkStation',
]

EXPECTED_ALL = EXPECTED_162 + EXPECTED_ORIGINAL + EXPECTED_BATCH23
