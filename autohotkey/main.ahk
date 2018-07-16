#InstallKeybdHook
#SingleInstance force
#MaxThreadsPerHotkey 1
#Persistent
; NOTES
; --------------------------------------------------------------
; ! = ALT
; ^ = CTRL
; + = SHIFT
; # = WIN
; --------------------------------------------------------------
; hotstrings

+!h::
Var = 
(
set follow-fork-mode child
$(info VAR is $(VAR))
dmg     duzhichaomail@gmail.com
qmg     834868939@qq.com
dtb     dzctaobao
id610   610125199212070017
pn185    18566691754
qq834    834868939
Dpwd    Dzc***********
joj      jojonnzeng
jenkins  alexdu_1234
cmsql   mysql -uroot -pkmk@4113
alisql  mysql -uroot -p***********
shda    show databases;
shta    show tables;
]d      yyyy-MM-dd dddd HH:mm:ss 
!+h     show autohotkey help
!+r     reload autohotkey
!+s     replace string \" with "
!+n     tranlate timestamp
!+b     backup file
!+t     touch touch.txt in current dir
!+v     vi this file
!+m     md5
!+p     copy path
!+d     copy dir
!+n     copy file name
!+o      open clipboard file
!+q      qq
!+w      wechat
!+e      everything
!+y      rsync to aliyun
!+j      rsync to internal
!^p      rsync python to aliyun
!^c      rsync cpp_test to aliyun
!^s      rsync shell to aliyun
)
MsgBox %Var%
return

:*:dmg::duzhichaomail@gmail.com
:*:qmg::834868939@qq.com
:*:dtb::dzctaobao
:*:id610::610125199212070017
:*:pn185::18566691754
:*:qq834::834868939
:*:Dpwd::Dzc13379200167
:*:joj::jojonnzeng
:*:alisql::mysql -uroot -pDzc13379200167
:*:shda::show databases;
:*:shta::show tables;
:*:]d::  ; This hotstring replaces "]d" with the current date and time via the commands below.
FormatTime, CurrentDateTime,,yyyy-MM-dd dddd HH:mm:ss ; It will look like 9/1/2005 3:53 PM
SendInput %CurrentDateTime%
return

^!t::

; date := Time_unix2human(clipboard)
FormatTime, utime, % DateAdd( "19700101000000", clipboard, "s" ), yyyy-MM-dd HH:mm:ss
MsgBox %clipboard%    ------   %utime%
return

DateAdd( Date, Value, Units="days" ) { ; -----------------------------------------------------------
; Returns a time string in yyyyMMddHHmmss format. Units can be seconds, minutes, hours, or days
   Date += Value, %Units%
   Return Date
} ; DateAdd( Date, Value, Units="days" ) -----------------------------------------------------------

Time_unix2human(time)
{

    human=19700101000000

        time-=((A_NowUTC-A_Now)//10000)*3600    ;时差/Time lag 

        human+=%time%,Seconds

        return human
}

Time_human2unix(time)

{

    time-=19700101000000,Seconds

        time+=((A_NowUTC-A_Now)//10000)*3600    ;时差/Time lag 

        return time

}
RunWaitOne(command) {
    ; WshShell object: http://msdn.microsoft.com/en-us/library/aew9yb99
        shell := ComObjCreate("WScript.Shell")
        ; Execute a single command via cmd.exe
        exec := shell.Exec(ComSpec " /C " command)
        ; Read and return the command's output
        return exec.StdOut.ReadAll()
}
StdOutToVar( sCmd ) { ;  GAHK32 ; Modified Version : SKAN 05-Jul-2013  http://goo.gl/j8XJXY                             
    Static StrGet := "StrGet"     ; Original Author  : Sean 20-Feb-2007  http://goo.gl/mxCdn  

        DllCall( "CreatePipe", UIntP,hPipeRead, UIntP,hPipeWrite, UInt,0, UInt,0 )
        DllCall( "SetHandleInformation", UInt,hPipeWrite, UInt,1, UInt,1 )

        VarSetCapacity( STARTUPINFO, 68, 0  )      ; STARTUPINFO          ;  http://goo.gl/fZf24
        NumPut( 68,         STARTUPINFO,  0 )      ; cbSize
        NumPut( 0x100,      STARTUPINFO, 44 )      ; dwFlags    =>  STARTF_USESTDHANDLES = 0x100 
        NumPut( hPipeWrite, STARTUPINFO, 60 )      ; hStdOutput
        NumPut( hPipeWrite, STARTUPINFO, 64 )      ; hStdError

        VarSetCapacity( PROCESS_INFORMATION, 16 )  ; PROCESS_INFORMATION  ;  http://goo.gl/b9BaI      

        If ! DllCall( "CreateProcess", UInt,0, UInt,&sCmd, UInt,0, UInt,0 ;  http://goo.gl/USC5a
                , UInt,1, UInt,0x08000000, UInt,0, UInt,0
                , UInt,&STARTUPINFO, UInt,&PROCESS_INFORMATION ) 
        Return "" 
        , DllCall( "CloseHandle", UInt,hPipeWrite ) 
        , DllCall( "CloseHandle", UInt,hPipeRead )
        , DllCall( "SetLastError", Int,-1 )     

        hProcess := NumGet( PROCESS_INFORMATION, 0 )                 
        hThread  := NumGet( PROCESS_INFORMATION, 4 )                      

        DllCall( "CloseHandle", UInt,hPipeWrite )

        AIC := ( SubStr( A_AhkVersion, 1, 3 ) = "1.0" )                   ;  A_IsClassic 
        VarSetCapacity( Buffer, 4096, 0 ), nSz := 0 

        While DllCall( "ReadFile", UInt,hPipeRead, UInt,&Buffer, UInt,4094, UIntP,nSz, UInt,0 )
        sOutput .= ( AIC && NumPut( 0, Buffer, nSz, "UChar" ) && VarSetCapacity( Buffer,-1 ) ) 
        ? Buffer : %StrGet%( &Buffer, nSz, "CP850" )

        DllCall( "GetExitCodeProcess", UInt,hProcess, UIntP,ExitCode )
        DllCall( "CloseHandle", UInt,hProcess  )
        DllCall( "CloseHandle", UInt,hThread   )
        DllCall( "CloseHandle", UInt,hPipeRead )

        Return sOutput,  DllCall( "SetLastError", UInt,ExitCode )
}
; --------------------------------------------------------------
; reload
+!r::  ; Assign Ctrl-Alt-R as a hotkey to restart the script.
TrayTip, AutoHotkey.ahk, Restart after 1 second..., 1
; sleep 1000
Reload
return

#IfWinActive ahk_class EVERYTHING
; ^n::MsgBox, "l"
#IfWinActive

^`::
Send, {Ctrl down}{``}
sleep, 100
Send {!}
return
; ^`::Send, {Ctrl down}{` down}{Ctrl up}{` up}
; ^::Send, {Ctrl down}{` down}{Ctrl up}{` up}
; --------------------------------------------------------------
; q-dir
#IfWinActive ahk_class ATL:00409DB0
#l::Send, {Ctrl down}{Tab down}{Ctrl up}{Tab up}
#h::Send, {Ctrl down}{Shift down}{Tab down}{Ctrl up}{Shift up}{Tab up}
!+o::
Send, {Ctrl down}{t down}{Ctrl up}{t up}
Send, {Alt down}{d down}{Alt up}{d up}
Send, {Ctrl down}{v down}{Ctrl up}{v up}
Send, {Enter down}{Enter up}
Tray("open dir",clipboard,2)
return
!+n::
path := CopySelection()
if path = 
return
if (path = 1){
    return
}
SplitPath, path, name 
clipboard = %name%
MouseGetPos,x0
tooltip File name: "%clipboard%" copied.
loop
{
    MouseGetPos,x1 ;鼠标挪动取消提示框
        if x1!=%x0%
        {
            tooltip
                break
        }
}
Tray("Copy Filename",clipboard,2)
return 

!+d:: 
path := CopySelection()
if path = 
return
if (path = 1){
    return
}
SplitPath, path, , dir 
clipboard = %dir%
MouseGetPos,x0
tooltip File Location: "%clipboard%" copied.
loop
{
    MouseGetPos,x1 ;鼠标挪动取消提示框
        if x1!=%x0%
        { 
            tooltip
                break
        }
}
Tray("Copy Dir",clipboard,2)
return

!+p:: 
path := CopySelection()
if path = 
return
if (path = 1){
    return
}
MouseGetPos,x0
clipboard = %path%
tooltip Path: "%clipboard%" copied
loop
{
    MouseGetPos,x1 ;鼠标挪动取消提示框
        if x1!=%x0%
        { 
            tooltip
                break
        }
}
Tray("Copy Path",clipboard,2)
return

!+y:: 
path := CopySelection()
if path = 
return
if (path = 1){
    return
}
rsync := "rsync.exe -achp "
StringReplace, path, path, C:, /cygdrive/c, All
StringReplace, path, path, D:, /cygdrive/d, All
StringReplace, path, path, E:, /cygdrive/e, All
StringReplace, path, path, \, /, All
remote := "root@112.74.206.48:/root/rsync/" 
cmd := rsync " " path " " remote
Run, %cmd%
Tray("Rsync to aliyun",cmd,3)
return


!+j:: 
path := CopySelection()
if path = 
return
if (path = 1){
    return
}
cygPath := ConvertToCygPath(path)
rsync := "rsync.exe -avzuchp "
identity = D:\comicool\secretKey\internal-key-private.bin
identity := ConvertToCygPath(identity)
remote := "root@121.201.7.97:/root/alexdu/rsync/" 
cmd := rsync " -e '/usr/bin/ssh -i " identity "' " cygPath " " remote
Tray("lll ",cmd,30)
Run, %cmd%
Tray("Rsync to internal",cmd,3)
return
#IfWinActive

; Google Chrome
#IfWinActive, ahk_class Chrome_WidgetWin_1
; Show Web Developer Tools with cmd + alt + i
#!i::Send {F12}
; Show source code with cmd + alt + u
#!u::Send ^u
#IfWinActive
;-----------------------------------------
; Mac keyboard to Windows Key Mappings
;=========================================
; --------------------------------------------------------------
;
; Debug action snippet: MsgBox You pressed Control-A while Notepad is active.
SetTitleMatchMode 2
SendMode Input
; --------------------------------------------------------------
; OS X system shortcuts
; --------------------------------------------------------------
; Make Ctrl + S work with cmd (windows) key
#s::^s
; Selecting
#a::^a
; Copying
#c::^c
; Pasting
#v::^v
; Cutting
!+x::^x
; Opening
#o::^o
; Undo
#z::^z
; Redo
#y::^y
; New tab
#t::^t
; close tab
#w::^w
; Close windows (cmd + q to Alt + F4)
; #q::Send !{F4}
; minimize windows
#m::WinMinimize,a

; self move delete 
$#l::
num = 0
while(1){
    tooltip, %num% times
        num++
        GetKeyState, stwin, LWin
        state := GetKeyState("l", "P") 
        if (stwin = "D" and state = "1"){
            Send, {Right down}
            sleep 100
        }else{
            Send, {Right up}
            tooltip ;<-- turn off the reminder
                break
        }
}
return

$#h::
num = 0
while(1){
    tooltip, %num% times
        num++
        GetKeyState, stwin, LWin
        state := GetKeyState("h", "P") 
        if (stwin = "D" and state = "1"){
            Send, {Left down}
            sleep 100
        }else{
            Send, {Left up}
            tooltip ;<-- turn off the reminder
                break
        }
}
return
; $#j::
; num = 0
; while(1){
    ; tooltip, %num% times
        ; num++
        ; GetKeyState, stwin, LWin
        ; state := GetKeyState("j", "P") 
        ; if (stwin = "D" and state = "1"){
            ; Send, {Down down}
            ; sleep 100
                ; }else{
                    ; Send, {Down up}
                    ; tooltip ;<-- turn off the reminder
                        ; break
                        ; }
    ; }
    ; return
    ; $#k::
    ; num = 0
    ; while(1){
        ; tooltip, %num% times
            ; num++
            ; GetKeyState, stwin, LWin
            ; state := GetKeyState("k", "P") 
            ; if (stwin = "D" and state = "1"){
                ; Send, {Up down}
                ; sleep 100
                    ; }else{
                        ; Send, {Up up}
                        ; tooltip ;<-- turn off the reminder
                            ; break
                            ; }
        ; }
        ; return
        $#b::
        num = 0
        while(1){
            tooltip, %num% times
                num++
                GetKeyState, stwin, LWin
                state := GetKeyState("b", "P") 
                if (stwin = "D" and state = "1"){
                    Send, {BS down}
                    sleep 100
                }else{
                    Send, {BS up}
                    tooltip ;<-- turn off the reminder
                        break
                }
        }
return
$#g::
num = 0
while(1){
    tooltip, %num% times
        num++
        GetKeyState, stwin, LWin
        state := GetKeyState("g", "P") 
        if (stwin = "D" and state = "1"){
            Send, {Del down}
            sleep 100
        }else{
            Send, {Del up}
            tooltip ;<-- turn off the reminder
                break
        }
}
return
$#+l::
num = 0
while(1){
    tooltip, %num% times
        num++
        GetKeyState, stwin, LWin
        state := GetKeyState("l", "P") 
        if (stwin = "D" and state = "1"){
            Send, {Shift down}{Right down}
            sleep 100
        }else{
            Send, {Shift up}{Right up}
            tooltip ;<-- turn off the reminder
                break
        }
}
return
$#+h::
num = 0
while(1){
    tooltip, %num% times
        num++
        GetKeyState, stwin, LWin
        state := GetKeyState("h", "P") 
        if (stwin = "D" and state = "1"){
            Send, {Shift down}{Left down}
            sleep 100
        }else{
            Send, {Shift up}{Left up}
            tooltip ;<-- turn off the reminder
                break
        }
}
return
$#+j::
num = 0
while(1){
    tooltip, %num% times
        num++
        GetKeyState, stwin, LWin
        state := GetKeyState("j", "P") 
        if (stwin = "D" and state = "1"){
            Send, {Shift down}{Down down}
            sleep 100
        }else{
            Send, {Shift up}{Down up}
            tooltip ;<-- turn off the reminder
                break
        }
}
return
$#+k::
num = 0
while(1){
    tooltip, %num% times
        num++
        GetKeyState, stwin, LWin
        state := GetKeyState("k", "P") 
        if (stwin = "D" and state = "1"){
            Send, {Shift down}{Up down}
            sleep 100
        }else{
            Send, {Shift up}{Up up}
            tooltip ;<-- turn off the reminder
                break
        }
}
return
#j::Send, {Down down}{Down up}
#k::Send, {Up down}{Up up}
#u::Send, {PgUp down}{PgUp up}
#n::Send, {PgDn down}{PgDn up}
#i::Send, {Home down}{Home up}
; #p::Send, {End down}{End up}
!Enter::Send, {Esc down}{Esc up}

;; copy file name 
#IfWinActive ahk_class CabinetWClass
!+n::
path := CopySelection()
if path = 
return
if (path = 1){
    return
}
SplitPath, path, name 
clipboard = %name%
MouseGetPos,x0
tooltip File name: "%clipboard%" copied.
loop
{
    MouseGetPos,x1 ;鼠标挪动取消提示框
        if x1!=%x0%
        {
            tooltip
                break
        }
}
return 
#IfWinActive

;;alt+2 copy 此文件所在的路径名 
#IfWinActive ahk_class CabinetWClass
!+d:: 
path := CopySelection()
if path = 
return
if (path = 1){
    return
}
SplitPath, path, , dir 
clipboard = %dir%
MouseGetPos,x0
; tooltip File Location: "%clipboard%" copied.
loop
{
    MouseGetPos,x1 ;鼠标挪动取消提示框
        if x1!=%x0%
        { 
            tooltip
                break
        }
}
return 
#IfWinActive 

;;Alt+3 copy 此文件的全路径名 
#IfWinActive ahk_class CabinetWClass
!+p:: 
path := CopySelection()
if path = 
return
if (path = 1){
    return
}
MouseGetPos,x0
clipboard = %path%
tooltip Path: "%clipboard%" copied
loop
{
    MouseGetPos,x1 ;鼠标挪动取消提示框
        if x1!=%x0%
        { 
            tooltip
                break
        }
}
return
#IfWinActive

; md5
!+m::
path := CopySelection()
if path = 
return
if (path = 1){
    return
}
fhash := "D:\fHash\fHash64.exe"
cmd := fhash " " path
Run, %cmd%
return

; vim
!+v::
path := CopySelection()
if path = 
return
if (path = 1){
    return
}
vim := "gvim.exe"
cmd := vim " " path
Run, %cmd%
return
; #IfWinActive ahk_class EVERYTHING
; #IfWinActive
#IfWinActive ahk_class ATL:0000000140128B10
!+t::
num = 0
disk = ""
str = ""
path := CopySelection()
if path = 
return
if (path = 1){
    return
}
SplitPath, path, , dir 
directory = %dir%
mintty = C:\Users\AlexDu\app\Cygwin\bin\touch.exe
StringSplit, ColorArray, directory, `:
Loop, %ColorArray0%
{
this_color := ColorArray%a_index%
                ; MsgBox, Color number %a_index% is %this_color%.
                if (num = 0){
                    num = 1
                        disk = %this_color%
                }
            if (num = 1){
                str = %this_color%
            }
}
if(disk = "C"){
    disk = cdrive
}else if(disk = "D"){
    disk = ddrive
}else if(disk = "E"){
    disk = edrive
}
; StringReplace, NewStr, str, \, /, All
StringReplace, NewStr, directory, \, /, All
; cmd := disk NewStr "/touch"
cmd := NewStr "/touch.txt"
total := mintty " " cmd
Run, %total%
return
#IfWinActive

$!+b::
path := CopySelection()
if path = 
return
if (path = 1){
    return
}
StringSplit, ColorArray, path, `\
        len := % ColorArray0
        name := % ColorArray%len%
        cp = cp.exe
        FormatTime, time,,MM-dd-HH-mm
        bak := path "." time
        cmd := cp " -frp " path " " bak
        msg := bak
        Tray("Backup files",msg,3)
        Run, %cmd%
        return

        ; replace string
        !+s::
        content := clipboard
        StringReplace, content, content, \", ", All
        StringReplace, content, content, `r`n, , All
        StringReplace, content, content, \", ", All
        StringReplace, content, content, \", ", All
        StringReplace, content, content, "{, {, All
        StringReplace, content, content, }", }, All
        clipboard := content
        Tray("Replace",content,3)
        return

        !^p:: 
        path := "D:\python"
        rsync := "C:\Users\AlexDu\app\Cygwin\bin\rsync.exe -achp "
        StringReplace, path, path, C:, /home/AlexDu/cdrive, All
        StringReplace, path, path, D:, /home/AlexDu/ddrive, All
        StringReplace, path, path, E:, /home/AlexDu/edrive, All
        StringReplace, path, path, \, /, All
        remote := "root@112.74.206.48:/root/rsync_dir/" 
        cmd := rsync " " path " " remote
        Run, %cmd%
        Tray("Rsync to aliyun",cmd,3)
        return

        !^c:: 
        path := "D:\cpp_test"
        rsync := "C:\Users\AlexDu\app\Cygwin\bin\rsync.exe -achp "
        StringReplace, path, path, C:, /home/AlexDu/cdrive, All
        StringReplace, path, path, D:, /home/AlexDu/ddrive, All
        StringReplace, path, path, E:, /home/AlexDu/edrive, All
        StringReplace, path, path, \, /, All
        remote := "root@112.74.206.48:/root/rsync_dir/" 
        cmd := rsync " " path " " remote
        Run, %cmd%
        Tray("Rsync to aliyun",cmd,3)
        return

        !^s:: 
        path := "D:\shell"
        rsync := "C:\Users\AlexDu\app\Cygwin\bin\rsync.exe -achp "
        StringReplace, path, path, C:, /home/AlexDu/cdrive, All
        StringReplace, path, path, D:, /home/AlexDu/ddrive, All
        StringReplace, path, path, E:, /home/AlexDu/edrive, All
        StringReplace, path, path, \, /, All
        remote := "root@112.74.206.48:/root/rsync_dir/" 
        cmd := rsync " " path " " remote
        Run, %cmd%
        Tray("Rsync to aliyun",cmd,3)
        return

Tool(content,time)
{
    ToolTip, %content%, 2000, 250
        time := time*1000
        SetTimer, RemoveToolTip, %time%
        return
}
Tray(title,content,time)
{
    TrayTip, %title%, %content%
        time := time*1000
        SetTimer, RemoveTrayTip, %time%
        return
}

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

RemoveTrayTip:
SetTimer, RemoveTrayTip, Off
TrayTip
return

    ; --------------------------------------------------------------
CopySelection()
{
    clipboard =
        send ^c 
        ClipWait, 1
        if ErrorLevel
        {
msg := "The attempt to copy text onto the clipboard failed!"
         Tray("Failed",msg,3)
         return 1
        }
    return clipboard
}

CopyToClipboard()
{
    ; Wait for modifier keys to be released before we send ^C
        KeyWait LWin
        KeyWait Alt
        KeyWait Shift
        KeyWait Ctrl

        ; Capture to clipboard, then restore clipboard's value from before capture
        ExistingClipboard := ClipboardAll
        Clipboard =
        ClipWait, 4
        NewClipboard := Clipboard
        Clipboard := ExistingClipboard
        if (ErrorLevel)
        {
msg := "The attempt to copy text onto the clipboard failed!"
         Tray("Failed",msg,3)
         ;Tip("The attempt to copy text onto the clipboard failed.")
         return ""
        }
    return NewClipboard
}

ConvertToCygPath(path)
{
    StringReplace, path, path, C:, /home/AlexDu/cdrive, All
        StringReplace, path, path, D:, /home/AlexDu/ddrive, All
        StringReplace, path, path, E:, /home/AlexDu/edrive, All
        StringReplace, path, path, \, /, All
        return path
}

^#c::
; null= 
;多谢 helfee 的提醒，删除线部分是多余的。
send ^c
sleep,200
clipboard=%clipboard% ;%null%
; 这句还是废话一下：windows 复制的时候，剪贴板保存的是“路径”。只是路径不是字符串，只要转换成字符串就可以粘贴出来了。
tooltip,%clipboard%
sleep,500
tooltip,
    return
