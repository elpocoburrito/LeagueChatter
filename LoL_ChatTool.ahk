#InstallKeybdHook
#InstallMouseHook
#UseHook
#SingleInstance, Force
#NoEnv
SendMode, Event
SetKeyDelay, 15, 15

msgArray := []
if (FileExist("Messages.dat")) 
{
	Loop, read, Messages.dat 
	{
		msgArray.Push(A_LoopReadLine)
	}
}
else
	FileAppend,, Messages.dat

count = 1

Gui, +LastFound +AlwaysOnTop +ToolWindow -Caption +Border +E0x08000000
Gui1 := WinExist()
Gui, Font, s07, Arial
Gui, Add, Text, vText x0 y0 w350 h70, % msgArray[count]
Gui, Add, Button, gPrev x0 y75 w80 h30 , Previous
Gui, Add, Button, gNext x270 y75 w80 h30 , Next
return

f4::ExitApp

#if (WinActive("ahk_exe League of Legends.exe") || DllCall("IsWindowVisible", UInt, Gui1))
$numpad1::
	If DllCall("IsWindowVisible", UInt, Gui1) {
		Gui, Hide
	}
	else {
		Gui, Show, x0 y0 w350 h105 NoActivate, Untitled GUI
	}
return

$numpad2::
	sendMsg(msgArray[count])
return

$Left::
Prev:
	if (count > 1){
		count--
		GuiControl, Text, Text, % msgArray[count]
	}
return

$Right::
Next:
	if (count < msgArray.MaxIndex()){
		count++
		GuiControl, Text, Text, % msgArray[count]
	}
return

sendMsg(msg) {
	send, ^{enter}
	send {Enter}
	sleep, 200
	SendRaw %msg%
	send {Enter}
}