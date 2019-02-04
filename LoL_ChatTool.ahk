#InstallKeybdHook
#InstallMouseHook
#UseHook
#SingleInstance, Force
#NoEnv
SendMode, Event
SetKeyDelay, 15, 15

messagesFile := "messages.csv"
settingsFile := "ChatTool.conf.ini"

; need if exist
IfExist, %messagesFile% 
{
	pageNb = 0
	FileRead, Table, %A_ScriptDir%\messages.csv
	Table := StrSplit(Table, "`n", "`r")    ; Split the table into rows
	for i, Row in Table {
		Table[i] := StrSplit(Row, ";")      ; Split the rows into columns
		pageNb++
	}
}
else
	FileAppend,, %messagesFile%

;for i, Row in Table
;    msgBox, % Table[1,1]

IfNotExist, %settingsFile%
{
	IniWrite, true, %settingsFile%, Gui, btnsEnabled
	IniWrite, 410, %settingsFile%, Gui, windowWidth
	IniWrite, 110, %settingsFile%, Gui, windowHeight
	IniWrite, 250, %settingsFile%, Gui, windowX
	IniWrite, 0, %settingsFile%, Gui, windowY
	IniWrite, true, %settingsFile%, Gui, rightAlign
	IniWrite, true, %settingsFile%, Gui, guiTransparent
	IniWrite, false, %settingsFile%, Gui, Black
	IniWrite, false, %settingsFile%, Gui, 3Mode
	IniWrite, false, %settingsFile%, Gui, 6Mode
	IniWrite, true, %settingsFile%, Gui, 9Mode
	
}
IfExist, %settingsFile%
{
	IniRead, btnsEnabled, %settingsFile%, Gui, btnsEnabled, true
	IniRead, windowWidth, %settingsFile%, Gui, windowWidth, 410
	IniRead, windowHeight, %settingsFile%, Gui, windowHeight, 110
	IniRead, windowX, %settingsFile%, Gui, windowX, 250
	IniRead, windowY, %settingsFile%, Gui, windowY, 0
	IniRead, rightAlign, %settingsFile%, Gui, rightAlign, true
	IniRead, guiTransparent, %settingsFile%, Gui, guiTransparent, true
	IniRead, guiBlack, %settingsFile%, Gui, guiBlack, false
	IniRead, 3Mode, %settingsFile%, Gui, 3Mode, false
	IniRead, 6Mode, %settingsFile%, Gui, 6Mode, false
	IniRead, 9Mode, %settingsFile%, Gui, 9Mode, true
}

global count = 1
global page := 1

global colorToggle := 0
if (guiTransparent == "true")
	colorToggle := 1
else if (guiBlack == "true")
	colorToggle := 2

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

Gui, Add, Text, vText0 Center x%titleXPos% y5 w%messagesWidth% h%messagesHeight%, % "1. " . Table[1,1] 			;title

Gui, Add, Text, vText1 x5 y+5 w%messagesWidth% h%messagesHeight%, % "1. " . Table[1,2]					;text 1
Gui, Add, Text, vText4 x+5  w%messagesWidth% h%messagesHeight%, % "4. " . Table[1,5]
Gui, Add, Text, vText7 x+5 w%messagesWidth% h%messagesHeight%, % "7. " . Table[1,8]

Gui, Add, Text, vText2 x5 y+5 w%messagesWidth% h%messagesHeight%, % "2. " . Table[1,3]					;text 2
Gui, Add, Text, vText5 x+5 w%messagesWidth% h%messagesHeight%, % "5. " . Table[1,6]
Gui, Add, Text, vText8 x+5 w%messagesWidth% h%messagesHeight%, % "8. " . Table[1,9]

Gui, Add, Text, vText3 x5 y+5 w%messagesWidth% h%messagesHeight%, % "3. " . Table[1,4]					;text 3
Gui, Add, Text, vText6 x+5 w%messagesWidth% h%messagesHeight%, % "6. " . Table[1,7]
Gui, Add, Text, vText9 x+5 w%messagesWidth% h%messagesHeight%, % "9. " . Table[1,10]


if (btnsEnabled == "true" && guiTransparent != "true") {
	Gui, Add, Button, vBtnPrev gPrev c808080 x0 y%btnYPos% w%buttonWidth% h%buttonHeight% , Previous
	Gui, Add, Button, vBtnNext gNext c808080 x+%btnNextXPos% y%btnYPos% w%buttonWidth% h%buttonHeight% , Next
}
else if (btnsEnabled == "false" || guiTransparent == "true") {
	GuiControlGet, t6, Pos, Text6
	windowHeight := t6H+t6Y+5
}
if (rightAlign == "true"){
	GuiControl, +Right, Text4
	GuiControl, +Right, Text5
	GuiControl, +Right, Text6
}
Gui, Font, s10 Bold, Arial
GuiControl, Font, Text0
if (guiTransparent == "true") {
	Gui, Color, 000000
	WinSet, TransColor, 000000
	
	i := 0
	loop, 10
	{
		controlName := "Text"i
		GuiControl, +cWhite, %controlName%
		i++
	}
}


if (9Mode == "true")
{
	i := 4
	loop, 3
	{
		controlName := "Text"i
		GuiControl, +Center -Right, %controlName%
		i++
	}
	
	i := 7
	loop, 3
	{
		controlName := "Text"i
		GuiControl, +Right, %controlName%
		i++
	}
	
	GuiControlGet, t9, Pos, Text9
	windowWidth := t9X+t9W+5
	titleXPos := (windowWidth/2)-messagesWidth/2
	GuiControl, Move, Text0, x%titleXPos%
}
else if (6Mode == "true")
{
	i := 7
	loop, 3
	{
		controlName := "Text"i
		GuiControl, Hide, %controlName%
		i++
	}
	GuiControlGet, t6, Pos, Text6
	windowWidth := t6X+t6W+5
	titleXPos := (windowWidth/2)-messagesWidth/2
	GuiControl, Move, Text0, x%titleXPos%
}
else if (3Mode == "true")
{
	i := 4
	loop, 6
	{
		controlName := "Text"i
		GuiControl, Hide, %controlName%
		i++
	}
	GuiControlGet, t3, Pos, Text3
	windowWidth := t3X+t3W+5
	titleXPos := (windowWidth/2)-messagesWidth/2
	GuiControl, Move, Text0, x%titleXPos%
}
return

^f4::ExitApp
^f5::Reload

#if (WinActive("ahk_exe League of Legends.exe") || DllCall("IsWindowVisible", UInt, Gui1)) || WinActive("ahk_exe notepad.exe") || WinActive("ahk_exe notepad++.exe")
$numpad0::
If DllCall("IsWindowVisible", UInt, Gui1)
	Gui, Hide
else
	Gui, Show, x%windowX% y%windowY% w%windowWidth% h%windowHeight% NoActivate
return

$numpad1::
sendMsg(Table[page, 2])
return

$numpad2::
sendMsg(Table[page, 3])
return

$numpad3::
sendMsg(Table[page, 4])
return

$numpad4::
sendMsg(Table[page, 5])
return

$numpad5::
sendMsg(Table[page, 6])
return

$numpad6::
sendMsg(Table[page, 7])
return

$numpad7::
sendMsg(Table[page, 8])
return

$numpad8::
sendMsg(Table[page, 9])
return

$numpad9::
sendMsg(Table[page, 10])
return

/*$numpad9::
	StringReplace, Clipboard, Clipboard, `n, % " ", All
	StringReplace, Clipboard, Clipboard, `r, % " ", All
	StringReplace, Clipboard, Clipboard, `n`r, % " ", All
	sendMsg(Clipboard)
	return
*/

NumpadMult::
Gui, +LastFound
if (colorToggle == 0) {
	colorToggle := 1
	i := 0
	loop, 10
	{
		controlName := "Text"i
		GuiControl, +cWhite, %controlName%
		i++
	}
	Gui, Color, 000000
	WinSet, TransColor, 000000
	GuiControlGet, t6, Pos, Text6
	windowHeightNB := t6H+t6Y+5
	Gui, Show, x%windowX% y%windowY% w%windowWidth% h%windowHeightNB% NoActivate
}
else if (colorToggle == 1){
	colorToggle := 2
	Gui, Color, Default
	WinSet, TransColor, Off
	i := 0
	loop, 10
	{
		controlName := "Text"i
		GuiControl, +cBlack, %controlName%
		i++
	}
	Gui, Show, x%windowX% y%windowY% w%windowWidth% h%windowHeight% NoActivate
}
else if (colorToggle == 2){
	colorToggle := 0
	Gui, Color, Black
	WinSet, TransColor, Off
	i := 0
	loop, 10
	{
		controlName := "Text"i
		GuiControl, +cWhite, %controlName%
		i++
	}
	Gui, Show, x%windowX% y%windowY% w%windowWidth% h%windowHeight% NoActivate
}
return

$Left::
Prev:
page--
if (page < 1)
	page := pageNb-1
i = 0
loop, 10
{
	if (i == 0)
		updateMsgText("Text"i, page . ". " . Table[page, 1])
	else
		updateMsgText("Text"i, i . ". " . Table[page, i+1])
	i++
}
return

$Right::
Next:
page++
if (page >= pageNb)
	page := 1
i = 0
loop, 10
{
	if (i == 0)
		updateMsgText("Text"i, page . ". " . Table[page, 1])
	else
		updateMsgText("Text"i, i . ". " . Table[page, i+1])
	i++
}
return

sendMsg(msg) {
	if (msg != "")
	{
		send, ^{enter}
		send, {Enter}
		sleep, 80
		SendRaw, %msg%
		sleep, 80
		send, {Enter}
	}
}

updateMsgText(controlName, msg) {
	GuiControl, Text, %controlName%, %msg%
}