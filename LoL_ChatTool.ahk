#InstallKeybdHook
#InstallMouseHook
#UseHook
#SingleInstance, Force
#NoEnv
SendMode, Event
SetKeyDelay, 17, 17

messagesFile := "Messages.dat"
settingsFile := "ChatTool.conf.ini"

msgArray := []
if (FileExist(messagesFile)) 
{
	Loop, read, %messagesFile%
	{
		msgArray.Push(A_LoopReadLine)
	}
}
else
	FileAppend,, %messagesFile%

IfNotExist, %settingsFile%
{
	IniWrite, true, %settingsFile%, Gui, btnsEnabled
	IniWrite, 410, %settingsFile%, Gui, windowWidth
	IniWrite, 110, %settingsFile%, Gui, windowHeight
	IniWrite, 250, %settingsFile%, Gui, windowX
	IniWrite, 0, %settingsFile%, Gui, windowY
	
}
IfExist, %settingsFile%
{
	IniRead, btnsEnabled, %settingsFile%, Gui, btnsEnabled, true
	IniRead, windowWidth, %settingsFile%, Gui, windowWidth, 410
	IniRead, windowHeight, %settingsFile%, Gui, windowHeight, 110
	IniRead, windowX, %settingsFile%, Gui, windowX, 250
	IniRead, windowY, %settingsFile%, Gui, windowY, 0
}

global count = 1
messagesWidth := ((windowWidth-15)/2)
messagesHeight = 15
buttonWidth = 70
buttonHeight = 22

titleXPos := (windowWidth/2)-messagesWidth/2
btnNextXPos := windowWidth-(buttonWidth*2)
btnYPos := windowHeight-(buttonHeight)

Gui, +LastFound +AlwaysOnTop +ToolWindow -Caption +Border +E0x08000000
Gui1 := WinExist()
Gui, Font, s9, Arial

Gui, Add, Text, vText0 Center x%titleXPos% y5 w%messagesWidth% h%messagesHeight%, % SubStr(msgArray[count], 3) 	;title
Gui, Add, Text, vText1 x5 y+5 w%messagesWidth% h%messagesHeight%, % "1. " . msgArray[count+1]					;text 1
Gui, Add, Text, vText4 Right x+5  w%messagesWidth% h%messagesHeight%, % "4. " . msgArray[count+4]
Gui, Add, Text, vText2 x5 y+5 w%messagesWidth% h%messagesHeight%, % "2. " . msgArray[count+2]					;text 2
Gui, Add, Text, vText5 Right x+5 w%messagesWidth% h%messagesHeight%, % "5. " . msgArray[count+5]
Gui, Add, Text, vText3 x5 y+5 w%messagesWidth% h%messagesHeight%, % "3. " . msgArray[count+3]					;text 3
Gui, Add, Text, vText6 Right x+5 w%messagesWidth% h%messagesHeight%, % "6. " . msgArray[count+6]
if (btnsEnabled == "true") {
	Gui, Add, Button, vBtnPrev gPrev c808080 x0 y%btnYPos% w%buttonWidth% h%buttonHeight% , Previous
	Gui, Add, Button, vBtnNext gNext c808080 x+%btnNextXPos% y%btnYPos% w%buttonWidth% h%buttonHeight% , Next
}
else if (btnsEnabled == "false") {
	GuiControlGet, t6, Pos, Text6
	windowHeight := t6H+t6Y+5
}
Gui, Font, s10 Bold, Arial
GuiControl, Font, Text0
return

^f4::ExitApp
^f5::Reload

#if (WinActive("ahk_exe League of Legends.exe") || DllCall("IsWindowVisible", UInt, Gui1)) || WinActive("ahk_exe notepad.exe") || WinActive("ahk_exe notepad++.exe")
$numpad0::
	If DllCall("IsWindowVisible", UInt, Gui1)
		Gui, Hide
	else
		Gui, Show, x%windowX% y%windowY% w%windowWidth% h%windowHeight% NoActivate, Untitled GUI
return

$numpad1::
	sendMsg(msgArray[count+1])
return

$numpad2::
	sendMsg(msgArray[count+2])
return

$numpad3::
	sendMsg(msgArray[count+3])
return

$numpad4::
	sendMsg(msgArray[count+4])
return

$numpad5::
	sendMsg(msgArray[count+5])
return

$numpad6::
	sendMsg(msgArray[count+6])
return

$numpad9::
	StringReplace, Clipboard, Clipboard, `n, % " ", All
	StringReplace, Clipboard, Clipboard, `r, % " ", All
	StringReplace, Clipboard, Clipboard, `n`r, % " ", All
	sendMsg(Clipboard)
return

$Left::
Prev:
	if (count <= 1) 
		count := msgArray.MaxIndex()-2
	else if (count > 7)
		count := count - 7
	i = 0
	loop, 7
	{
		if (i == 0)
			updateMsgText("Text"i, SubStr(msgArray[count], 3))
		else
			updateMsgText("Text"i, i . ". " . msgArray[count+i])
		i++
	}
return

$Right::
Next:
	if (count >= msgArray.MaxIndex()-7) {
		count = 1
	}
	else if (count < msgArray.MaxIndex()-7){
		count := count + 7
	}
	i = 0
	loop, 7
	{
		if (i == 0)
			updateMsgText("Text"i,SubStr(msgArray[count], 3))
		else
			updateMsgText("Text"i, i . ". " . msgArray[count+i])
		i++
	}
return

sendMsg(msg) {
	send, ^{enter}
	send, {Enter}
	sleep, 80
	SendRaw, %msg%
	sleep, 80
	send, {Enter}
}

updateMsgText(controlName, msg) {
	GuiControl, Text, %controlName%, %msg%
}