# SendInterrupt
[Function] Sends a string of text/clicks which will be interrupted by stop Keys
# params:
		str: 		The text (or clicks) to send. Supports commands in {} but not +^!
		keyDelay: 	The amount of time in millis to wait between keystrokes
 		checkInterval:	The interval of millis to check for interruption.
		keyState:	The state of the key to cause interruption. 
					"D" (default) interrupt on key down event
					"U" interrupt on key up event
		stopKey:	The key or keys to be used to interrupt. Normal keys will be sent, whereas by default 
					hotkeys will not be launched when pressed. To change this, specify "Hotkeys" as the first of
 					the stopKeys, which will make all hotkeys interrupt the thread, including ones listed as
					stopKeys. However, the thread does not terminate until after the interrupting thread has 
					finished. Accordingly the #maxThreadsperHotkey determines how many times a thread on a 
					particular hotkey may interrupt.
#	 returns:
			True if completed sending str, false if interrupted.
			
#sendInterrupt(str, keyDelay=30, checkInterval=30, keyState="D", stopKey*)
