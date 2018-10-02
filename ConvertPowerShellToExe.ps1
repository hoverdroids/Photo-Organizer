# Markus Scholtes, DEVK 2017
# Create Scripts in subdir "Scripts"

$SCRIPTPATH = Split-Path $SCRIPT:MyInvocation.MyCommand.Path -parent
ls "$SCRIPTPATH\Scripts\*.ps1" | %{
	."$SCRIPTPATH\Source\ps2exe.ps1" "$($_.Fullname)" "$($_.Fullname -replace '.ps1','.exe')" -verbose
	."$SCRIPTPATH\Source\ps2exe.ps1" "$($_.Fullname)" "$($_.Fullname -replace '.ps1','-GUI.exe')" -verbose -noConsole
}

Remove-Item "$SCRIPTPATH\Scripts\Progress.exe*"
Remove-Item "$SCRIPTPATH\Scripts\ScreenBuffer-GUI.exe*"

#$NULL = Read-Host "Press enter to exit"