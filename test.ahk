windowWidth := 1400
windowHeight := 110
messagesWidth := 200
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

Gui, chatOL:Add, Text, border vText1 x5 y+5 w%messagesWidth% h%messagesHeight%, % "1. " . Table[1,2]					;text 1
Gui, chatOL:Add, Text, border center vText4 x+5  w%messagesWidth% h%messagesHeight%, % "4. " . Table[1,5]
Gui, chatOL:Add, Text, border right vText7 x+5 w%messagesWidth% h%messagesHeight%, % "7. " . Table[1,8]

Gui, chatOL:Add, Text, border vText2 x5 y+5 w%messagesWidth% h%messagesHeight%, % "2. " . Table[1,3]					;text 2
Gui, chatOL:Add, Text, border center vText5 x+5 w%messagesWidth% h%messagesHeight%, % "5. " . Table[1,6]
Gui, chatOL:Add, Text, border right vText8 x+5 w%messagesWidth% h%messagesHeight%, % "8. " . Table[1,9]

Gui, chatOL:Add, Text, border vText3 x5 y+5 w%messagesWidth% h%messagesHeight%, % "3. " . Table[1,4]					;text 3
Gui, chatOL:Add, Text, border center vText6 x+5 w%messagesWidth% h%messagesHeight%, % "6. " . Table[1,7]
Gui, chatOL:Add, Text, border right vText9 x+5 w%messagesWidth% h%messagesHeight%, % "9. " . Table[1,10]

Gui, chatOL:Font, s10 Bold, Arial
GuiControl, chatOL:Font, Text0

Gui, chatOL:Show, x0 y0 w%windowWidth% h%windowHeight% NoActivate


f3::exitapp