#Determine the folder structure to create
$structures = [System.Management.Automation.Host.ChoiceDescription[]](
(New-Object System.Management.Automation.Host.ChoiceDescription "&Group by Date","Group by Date"),
(New-Object System.Management.Automation.Host.ChoiceDescription "&Group by Year","Group by Year"),
(New-Object System.Management.Automation.Host.ChoiceDescription "&Group by Year then Date","Group by Year then Date"),
(New-Object System.Management.Automation.Host.ChoiceDescription "&Group by Year then Month","Group by Year then Month"),
(New-Object System.Management.Automation.Host.ChoiceDescription "&Group by Year then Month then Day","Group by Year then Month then Day"))
$Grouping = $host.ui.PromptForChoice('Bulk File Organizer', "Select Output Folder Structure", $structures, 2)

if($Grouping -eq 0 -or $Grouping -eq 2){
	#Determine the folder structure to create
	$formats = [System.Management.Automation.Host.ChoiceDescription[]](
	(New-Object System.Management.Automation.Host.ChoiceDescription "&DD-MM-YYYY","DD-MM-YYYY"),
	(New-Object System.Management.Automation.Host.ChoiceDescription "&MM-DD-YYYY","MM-DD-YYYY"),
	(New-Object System.Management.Automation.Host.ChoiceDescription "&YYYY-DD-MM","YYYY-DD-MM"),
	(New-Object System.Management.Automation.Host.ChoiceDescription "&YYYY-MM-DD","YYYY-MM-DD"))
	$Format = $host.ui.PromptForChoice('Bulk File Organizer', "Select Date Format", $formats, 1)

	#Determine the folder structure to create
	$datesources = [System.Management.Automation.Host.ChoiceDescription[]](
	(New-Object System.Management.Automation.Host.ChoiceDescription "&File Name","File Name"),
	(New-Object System.Management.Automation.Host.ChoiceDescription "&Date Created","Date Created"),
	(New-Object System.Management.Automation.Host.ChoiceDescription "&Date Modified","Date Modified"))
	$DateSource = $host.ui.PromptForChoice('Bulk File Organizer', "Select Date Source", $datesources, 0)
}

#Determine where the images are that need to be sorted
$source = Read-Host "Enter Photos Source Path"

#Determine where the images will be moved and sorted
$destination = Read-Host "Enter Photos Destination Path"

#If the source or destination input was blank or the input paths don't exist then exit
#No need to test if the destination exists since it will be created if it does not exist
if(!($source) -or !($destination)){
	Write-Host "Source and Destination cannot be null and must exist" -fore Yellow
	exit
}
if(!(Test-Path $source)){
	Write-Host "Failed to move. Source does not exist." -fore Yellow
	exit
}

# Get the files which should be moved, without folders
$files = Get-ChildItem $source -Recurse | where {!$_.PsIsContainer}
  
foreach ($file in $files){
	# Get year and Month of the file using the filename
	$bn = $file.basename.ToString()

	#Get date source preferences
	if(!($DateSource)){
		$year = $bn.substring(0,4)
		$month = $bn.substring(4,2)
		$day = $bn.substring(6,2)
	}elseif($DateSource -eq 1){
		$year = $file.LastWriteTime.Year.ToString()
		$month = $file.LastWriteTime.Month.ToString()
		$day = $file.LastWriteTime.Day.ToString()
		$hour = $file.LastWriteTime.Hour.ToString()
	}elseif($DateSource -eq 2){
		$year = $file.CreationTime.Year.ToString()
		$month = $file.CreationTime.Month.ToString()
		$day = $file.CreationTime.Day.ToString()
		$hour = $file.CreationTime.Hour.ToString()
	}

	#Get date preferences if they exist - which is only when the option uses dates for folder names
	if(!($Format)){
		#This catches null and empty format as well as format selection of 0
		$Date = $day + "-" + $month + "-" + $year
	}elseif($Format -eq 1){
		$Date = $month + "-" + $day + "-" + $year
	}elseif($Format -eq 2){
		$Date = $year + "-" + $day + "-" + $month
	}elseif($Format -eq 3){
		$Date = $year + "-" + $month + "-" + $day
	}

	#Create the full directory name using grouping and date preferences
	if($Grouping -eq 0){
		$Directory = $destination + "\" + $Date
	}elseif($Grouping -eq 1){
		$Directory = $destination + "\" + $year
	}elseif($Grouping -eq 2){
		$Directory = $destination + "\" + $year + "\" + $Date
	}elseif($Grouping -eq 3){
		$Directory = $destination + "\" + $year + "\" + $month
	}elseif($Grouping -eq 4){
		$Directory = $destination + "\" + $year + "\" + $month + "\" + $day
	}
	
	#$ConfirmPreference = 'None'
	
	
	# Create directory if it doesn't exsist
	if (!(Test-Path $Directory))
	{
		#New-Item $directory -type directory -Confirm "False"
		#-ErrorAction SilentlyContinue -Confirm:$false  -Recurse
		New-Item -ItemType Directory -Path $directory -Force:$true | Out-Null
		#md $Directory
		#mkdir "c:\test2200" #$Directory
	}
	 
	# Move File to new location
	$file | Move-Item -Destination $Directory
}
#$NULL = Read-Host "Press enter to exit"