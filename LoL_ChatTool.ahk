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

IfNotExist, %settingsFile%
{
	IniWrite, false, %settingsFile%, Gui, btnsEnabled
	IniWrite, 410, %settingsFile%, Gui, windowWidth
	IniWrite, 110, %settingsFile%, Gui, windowHeight
	IniWrite, 0250, %settingsFile%, Gui, windowX
	IniWrite, 0, %settingsFile%, Gui, windowY
	IniWrite, 0, %settingsFile%, Gui, align
	IniWrite, true, %settingsFile%, Gui, guiTransparent
	IniWrite, false, %settingsFile%, Gui, guiBlack
	IniWrite, false, %settingsFile%, Gui, 3Mode
	IniWrite, false, %settingsFile%, Gui, 6Mode
	IniWrite, true, %settingsFile%, Gui, 9Mode
	IniWrite, true, %settingsFile%, Gui, LeagueMustBeOpen
	IniWrite, true, %settingsFile%, Gui, borders
	
}
IfExist, %settingsFile%
{
	IniRead, btnsEnabled, %settingsFile%, Gui, btnsEnabled, false
	IniRead, windowWidth, %settingsFile%, Gui, windowWidth, 410
	IniRead, windowHeight, %settingsFile%, Gui, windowHeight, 110
	IniRead, windowX, %settingsFile%, Gui, windowX, 250
	IniRead, windowY, %settingsFile%, Gui, windowY, 0
	IniRead, align, %settingsFile%, Gui, align, true
	IniRead, guiTransparent, %settingsFile%, Gui, guiTransparent, true
	IniRead, guiBlack, %settingsFile%, Gui, guiBlack, false
	IniRead, 3Mode, %settingsFile%, Gui, 3Mode, false
	IniRead, 6Mode, %settingsFile%, Gui, 6Mode, false
	IniRead, 9Mode, %settingsFile%, Gui, 9Mode, true
	IniRead, LeagueMustBeOpen, %settingsFile%, Gui, LeagueMustBeOpen, true
	IniRead, borders, %settingsFile%, Gui, borders, true
}

; ------ to bool ---------
btnsEnabled := toBool(btnsEnabled)
guiTransparent := toBool(guiTransparent)
guiBlack := toBool(guiBlack)
3Mode := toBool(3Mode)
6Mode := toBool(6Mode)
9Mode := toBool(9Mode)
LeagueMustBeOpen := toBool(LeagueMustBeOpen)
borders := toBool(borders)
; ------ to bool ---------

global count = 1
global page := 1

subShow := 1

global colorToggle := 2
if (guiTransparent == true)
	colorToggle := 0
else if (guiBlack == true)
	colorToggle := 1

messagesWidth := ((windowWidth-15)/2)
messagesHeight = 15
buttonWidth = 70
buttonHeight = 22

titleXPos := (windowWidth/2)-messagesWidth/2
btnNextXPos := windowWidth-(buttonWidth*2)
btnYPos := windowHeight-(buttonHeight)

Gui chatOL:New, ,Chat Overlay
Gui, chatOL:+LastFound +AlwaysOnTop +ToolWindow -Caption +Border +E0x08000000
Gui1 := WinExist()
Gui, chatOL:Font, s9, Arial

Gui, chatOL:Add, Text, vText0 Center x%titleXPos% y5 w%messagesWidth% h%messagesHeight%, % "1. " . Table[1,1] 			;title

Gui, chatOL:Add, Text, vText7 x5 y+5 w%messagesWidth% h%messagesHeight%, % "7. " . Table[1,8]
Gui, chatOL:Add, Text, vText8 x+5 w%messagesWidth% h%messagesHeight%, % "8. " . Table[1,9]
Gui, chatOL:Add, Text, vText9 x+5 w%messagesWidth% h%messagesHeight%, % "9. " . Table[1,10]

Gui, chatOL:Add, Text, vText4 x5 y+5 w%messagesWidth% h%messagesHeight%, % "4. " . Table[1,5]
Gui, chatOL:Add, Text, vText5 x+5 w%messagesWidth% h%messagesHeight%, % "5. " . Table[1,6]
Gui, chatOL:Add, Text, vText6 x+5 w%messagesWidth% h%messagesHeight%, % "6. " . Table[1,7]

Gui, chatOL:Add, Text, vText1 x5 y+5 w%messagesWidth% h%messagesHeight%, % "1. " . Table[1,2]	
Gui, chatOL:Add, Text, vText2 x+5 w%messagesWidth% h%messagesHeight%, % "2. " . Table[1,3]
Gui, chatOL:Add, Text, vText3 x+5 w%messagesWidth% h%messagesHeight%, % "3. " . Table[1,4]

Gui, chatOL:Font, s10 Bold, Arial
GuiControl, chatOL:Font, Text0
if (9Mode == true)
{
	i := 4
	loop, 3
	{
		controlName := "Text"i
		;GuiControl, chatOL: +Center -Right, %controlName%
		i++
	}
	i := 7
	loop, 3
	{
		controlName := "Text"i
		;GuiControl, chatOL: +Right, %controlName%
		i++
	}
	GuiControlGet, t9, Pos, Text9
	windowWidth := t9X+t9W+5
	titleXPos := (windowWidth/2)-messagesWidth/2
	GuiControl, chatOL: Move, Text0, x%titleXPos%
}
else if (6Mode == true)
{
	i := 7
	loop, 3
	{
		controlName := "Text"i
		GuiControl, chatOL: Hide, %controlName%
		i++
	}
	GuiControlGet, t6, Pos, Text6
	windowWidth := t6X+t6W+5
	titleXPos := (windowWidth/2)-messagesWidth/2
	GuiControl, chatOL: Move, Text0, x%titleXPos%
}
else if (3Mode == true)
{
	i := 4
	loop, 6
	{
		controlName := "Text"i
		GuiControl, chatOL: Hide, %controlName%
		i++
	}
	GuiControlGet, t3, Pos, Text3
	windowWidth := t3X+t3W+5
	titleXPos := (windowWidth/2)-messagesWidth/2
	GuiControl, chatOL: Move, Text0, x%titleXPos%
}
if (btnsEnabled == true && guiTransparent != true) {
	btnNextXPos := windowWidth-(buttonWidth*2)
	Gui, chatOL:Add, Button, vBtnPrev gPrev c808080 x0 y%btnYPos% w%buttonWidth% h%buttonHeight% , Previous
	Gui, chatOL:Add, Button, vBtnNext gNext c808080 x+%btnNextXPos% y%btnYPos% w%buttonWidth% h%buttonHeight% , Next
}
else if (btnsEnabled == false || guiTransparent == true) {
	GuiControlGet, t1, Pos, Text1
	windowHeight := t1H+t1Y+5
}

if (align == "0"){
	rightTh := "+Right"
}
else if (align == "1"){
	rightTh := "+Center"
}
else if (align == "2"){
	rightTh := "+Left"
}


Gui macroRec:New, ,Chat Overlay
Gui, macroRec: +LastFound +AlwaysOnTop +ToolWindow -Caption  +E0x08000000
Gui2 := WinExist()
Gui, macroRec: Add, Button, gStartGettingPos x+5 y+5 w100 h30, Get Pos
Gui, macroRec: Add, Button, gclick y+5 w100 h30, Click
Gui, macroRec: Add, Text,y+5 w200 vMacroLabel, Position:
goto, setColor
return

^f4::ExitApp
^f5::Reload

#if  (LeagueMustBeOpen == false || (WinActive("ahk_exe League of Legends.exe") || DllCall("IsWindowVisible", UInt, Gui1) || WinActive("ahk_exe notepad.exe") || WinActive("ahk_exe notepad++.exe")|| DllCall("IsWindowVisible", UInt, Gui2)))
$numpad0::

	If DllCall("IsWindowVisible", UInt, Gui1)
		Gui, chatOL:Hide
	else
		Gui, chatOL:Show, x%windowX% y%windowY% w%windowWidth% h%windowHeight% NoActivate
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

setColor:
	subShow := 0
NumpadMult::
	Gui,chatOL:  +LastFound
	if (colorToggle == 0) { ; Transparent
		colorToggle := 1
		i := 0
		loop, 10
		{
			controlName := "Text"i
			GuiControl, chatOL: +cWhite, %controlName%
			GuiControl, chatOL: %rightTh%, %controlName%
			if (borders)
				GuiControl, chatOL: +border, %controlName%
			i++
		}
		Gui, chatOL: Color, 000000
		WinSet, TransColor, 000000
		GuiControlGet, t1, Pos, Text1
		windowHeightNB := t1H+t1Y+5
		if (show == 1)
			Gui, chatOL: Show, x%windowX% y%windowY% w%windowWidth% h%windowHeightNB% NoActivate
		else
			subShow := 1
	}
	else if (colorToggle == 1){ ; Black
		colorToggle := 2
		Gui, chatOL: Color, Black
		WinSet, TransColor, Off
		i := 0
		loop, 10
		{
			controlName := "Text"i
			GuiControl, chatOL: +cWhite, %controlName%
			GuiControl, chatOL: %rightTh%, %controlName%
			if (borders)
				GuiControl, chatOL: +border, %controlName%
			i++
		}
		if (show == 1)
			Gui, chatOL: Show, x%windowX% y%windowY% w%windowWidth% h%windowHeight% NoActivate
		else
			subShow := 1
	}
	else if (colorToggle == 2){ ; Default
		colorToggle := 0
		Gui, chatOL: Color, Default
		WinSet, TransColor, Off
		i := 0
		loop, 10
		{
			controlName := "Text"i
			GuiControl, chatOL: +cBlack, %controlName%
			GuiControl, chatOL: %rightTh%, %controlName%
			if (borders)
				GuiControl, chatOL: +border, %controlName%
			i++
		}
		if (show == 1)
			Gui, chatOL: Show, x%windowX% y%windowY% w%windowWidth% h%windowHeight% NoActivate
		else
			subShow := 1
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
	GuiControl, chatOL: Text, %controlName%, %msg%
}

toBool(v) { ; strict
	if (v == "true" || v == "True" || v == "1")
		return 1
	else
		return 0
}


click:
$^NumpadEnter::
	SysGet, mPos, Monitor
	xNop := xPercent * mPosRight / 100
	yNop := yPercent * mPosBottom / 100
	MouseMove, %xNop%, %yNop%, 010
	Send, !{LButton}
return

$^NumpadDot::
	Gui, macroRec: +lastfound
	If DllCall("IsWindowVisible", UInt, Gui2)
		Gui, macroRec: Hide
	else
		Gui, macroRec: Show, x0 y0 w300 h100 NoActivate, Macro Recorder
return


StartGettingPos:
	SetTimer, FollowMouse, 50
	KeyWait, Enter, D T20
	If (ErrorLevel == 0)
	{
		MouseGetPos, mXPos, mYPos
		SysGet, mPos, Monitor
		xPercent := mXPos / mPosRight * 100
		yPercent := mYPos / mPosBottom * 100
		ToolTip
		SetTimer, FollowMouse, Off
		txtToShow := "Position  x: " . Round(xPercent, 2) . "%" . " y: " . Round(yPercent, 2) . "%"
		GuiControl, macroRec: Text, MacroLabel, %txtToShow%
	}
	else
		MsgBox, Error `, did not work
return

FollowMouse:
	MouseGetPos, px, py
	ToolTip, Position x: %px% y: %py%, px+10, py+10
	
	MouseGetPos, mXPos, mYPos
	SysGet, mPos, Monitor
	xPercent := mXPos / mPosRight * 100
	yPercent := mYPos / mPosBottom * 100
	txtToShow := "Position  x: " . Round(xPercent, 2) . "%" . " y: " . Round(yPercent, 2) . "%"
	GuiControl, macroRec: Text, MacroLabel, %txtToShow%
	
	return
return