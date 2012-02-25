; Made with AutoIt
;
; Author:         Chris Shannon (Dr Chi)
;
; Script Function:
;   Find file named "whereami" and sets the drive location to that.
;   Used for finding the usb drive with your programs.
;
AutoItSetOption ( "TrayIconHide", 1)

SLEEP(2000)

$var = DriveGetDrive( "REMOVABLE" )
$location = $var[0]
If NOT @error Then
    For $i = 1 to $var[0]
    	If DriveStatus ($var[$i]) = "READY" then
    		If FileExists ($var[$i] & "\what2start.ini" ) then
    			$location = $var[$i]
    		EndIf
    	Else
    		$location = "oops"
    	EndIf
    Next
EndIf

$what2open = IniRead ($location & "\what2start.ini", "menutostart", "name", "")

If $location <> "oops" then
Run($location & "\" & $what2open, "")
Else
MsgBox (0,"Error", "Check your what2start.ini file...or it doesn't exist.")
EndIf