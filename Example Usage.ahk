
#SingleInstance, force
#MaxThreadsPerHotkey, 3
w::		; To prevent a sent string from activating a hotkey, use $ before the hotkey
string:="={click}Foo{click, 300, 200}{ctrl down}a{ctrl up}" ; Click at current mouse position ; send "Foo" ; click at 300, 200 ; send control-a
keyDelay:=300			; Delay to sleep between key strokes
checkKeyInterval:=30	; Interval of milliseconds to check for interrupting key strokes
onKeyDown:="D"			; Interrupt When key is pressed down
res:=sendInterrupt(string, keyDelay, checkKeyInterval, onKeyDown, "w", "e")  ; Type w or e to interrupt
	MsgBox % (res ? "Successfully" : "Unsuccessfully") " sent string " string
return 

q::
sendInterrupt("{click}ABCDE{click, 300, 200}", 330,,, "Hotkeys", "q")
Return 
; 
r::
sendInterrupt("op1", 330,700,, "r")
return

esc::ExitApp 
