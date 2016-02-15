; =============================================== Send Interrupt ======================================
;  Sends a string of text which will be interrupted by stop Keys
;  params:
;		str: 		The text (or clicks) to send. Supports commands in {} but not +^!
;		keyDelay: 	The amount of time in millis to wait between keystrokes
; 		checkInterval:	The interval of millis to check for interruption.
;		keyState:	The state of the key to cause interruption. 
;					"D" (default) interrupt on key down event
;					"U" interrupt on key up event
;		stopKey:	The key or keys to be used to interrupt. Normal keys will be sent, whereas by default 
;					hotkeys will not be launched when pressed. To change this, specify "Hotkeys" as the first of
; 					the stopKeys, which will make all hotkeys interrupt the thread, including ones listed as
;					stopKeys. However, the thread does not terminate until after the interrupting thread has 
;					finished. Accordingly the #maxThreadsperHotkey determines how many times a thread on a 
;					particular hotkey may interrupt.
;	returns:
;			True if completed sending str, false if interrupted.
; ==============================================================================================================
sendInterrupt(str, keyDelay=30, checkInterval=30, keyState="D", stopKey*) {
	static cT:=0
	mT:= cT+=1 , r:=round(keyDelay/checkInterval)
	Thread, priority, % stopKey[1] = "Hotkeys" ? 0 : 10
	for i, cK in stopKey 
		if(cK = A_ThisHotkey) 
			KeyWait, %a_thishotkey%, % (keyState="D") ? "" : "D"
loop, parse, str
{
	if(bc) {	
		if(a_loopfield = "}") { ; End Command
			send, % (substr(str, bc, a_index-bc+1)) , bc:=0
		} else 
			continue
	} else if(a_loopfield = "{") ; Begin Command
		bc:=A_Index , continue
	else
		sendraw, %a_loopfield%
	loop, %r%
	{
		sleep %checkInterval%
		if(mT != cT)	; Current thread?
			return false
		for i, cK in stopKey
			if((kp:=getKeyState(cK, "P")) && keyState = "D") ; Physical key state?
				return false
			else if(kp)
				break
		if(keyState != "D")	
			if(!kp, kp:=false) 	; All keys up?
				return false
	} }
return true
}	
