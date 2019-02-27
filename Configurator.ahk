#NoEnv
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force

	GuiHeight := 0
	Array := []
	Gui, +AlwaysOnTop +ToolWindow -Caption +Border
	Loop, read, ChatTool.conf.ini
	{
		equalPos := InStr(A_LoopReadLine, "=" , false, 1)
		keyStr := SubStr(A_LoopReadLine, 1 , equalPos-1)
		valueStr := SubStr(A_LoopReadLine, equalPos+1)
		Array.Push(keyStr)
		
		if (valueStr == "true") {
			Gui, Add, Checkbox, v%keyStr%Val Checked x5 y+5 w150 h20, %keyStr%
			%keyStr%ValB := true
			GuiHeight += 25
		}
		else if (valueStr == "false"){
			Gui, Add, Checkbox, v%keyStr%Val x5 y+5 w150 h20, %keyStr%
			%keyStr%ValB := true
			GuiHeight += 25
		}
		else if (inStr(keyStr, "[") == 0) {
			Gui, Add, Text, x5 y+5 w90 h20, %keyStr%
			Gui, Add, Edit, v%keyStr%Val x5 y+1 w150 h20, %valueStr%
			%keyStr%ValB := false
			GuiHeight += 47
		}
	}
	Gui, Add, Button, gSave x5 y+5 w70 h20, Save
	Gui, Add, Button, gQuit x+5 w70 h20, Quit
	GuiHeight += 25
	Gui, Show, x0 y0 w160 h%GuiHeight% NoActivate
return

Save:
	Gui, Submit, NoHide
	MyVar = Contents of MyVar
	RefToMyVar = MyVar
	for index, keyStrI in Array
	{
		if (inStr(keyStrI, "[") == 0) {
			valI :=  %keyStrI%Val
			valB := %keyStrI%ValB
			if (valB == 1){
				if (valI == 1)
					valI := "true"
				else if (valI == 0)
					valI := "false"
				;msgbox, valB %valB% valI %valI%
			}
			IniWrite, %valI%, ChatTool.conf.ini, Gui, %keyStrI%
		}
	}
return

Quit:
	ExitApp
return

toBool(v) {
	v := %v%
	return v
}