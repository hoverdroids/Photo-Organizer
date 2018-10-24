Windows Photo Organizer is a simple script that moves photos into folders based
on the name of the photo. It assumes the beginning of the name is in a date format.

If the photo is not named like yyyymmdd_time_bla then use a renamer like AntRenamer or 
Advanced Renamer to use the date taken or date modified to name it. It is also advisable
to suffix the time so that no photo has the exact same name - which guarentees that moving
the images don't override one another, which is totally possible because we don't check!

ps2exe.ps1
	- The PowerShell script that converts powerShell files into executables

ConvertPowerShellToExe.ps1
	- The PowerShell script that loops through all .ps1 scripts in the scripts folder and converts them into exe files

ToDateFromName.ps1
	- The powerShell script that moves photos/files into folders based on the file name.
	
ToDateFromName.exe
	-Command prompt to gather the following information from the user:
		- Output Folder Structure
			- Group by Date
			- Group by Year
			- Group by Year then Date*
			- Group by Year then Month
			- Group by Year then Month then Day
		- Select Date Format
			- DD-MM-YYYY
			- MM-DD-YYYY*
			- YYYY-DD-MM
			- YYYY-MM-DD
		- Select Date Source
			- File Name*
			- Date Created
			- Date Modified
		- Enter Photos Source Path
		- Enter Photos Destination Path (can be the same as the source, it will simply put the folders in the source; so, don't have the same folders)
		
	- After user prefs are entered, it calls ToDateFromName.ps1 to move photos/files
	
ToDateFromName-GUI.exe
	- Same as ToDateFromName.exe but with a gui instead of command prompt
