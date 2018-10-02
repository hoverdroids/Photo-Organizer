#Determine the folder structure to create
$choices = [System.Management.Automation.Host.ChoiceDescription[]](
(New-Object System.Management.Automation.Host.ChoiceDescription "&DD-MM-YYYY","DD-MM-YYYY"),
(New-Object System.Management.Automation.Host.ChoiceDescription "&MM-DD-YYYY","MM-DD-YYYY"))

$Answer = $host.ui.PromptForChoice('Folder Output Structure', "Question", $choices, 2)
#Write-Output $Answer

#Determine where the images are that need to be sorted
$source = Read-Host "Enter Photos Source Path"
#Write-Output $source

#Determine where the images will be moved and sorted
$destination = Read-Host "Enter Photos Destination Path"
#Write-Output $destination


# Get the files which should be moved, without folders
$files = Get-ChildItem $source -Recurse | where {!$_.PsIsContainer}
 
# List Files which will be moved
#$files
 
foreach ($file in $files)
{
# Get year and Month of the file using the filename
$bn = $file.basename.ToString()

$year = $bn.substring(0,4)
$month = $bn.substring(4,2)
$day = $bn.substring(6,2)

# Set Directory Path
$Directory = $destination + "\" + $year + "\" + $day + "-" + $month + "-" + $year

if($Answer -eq 1)
{
# Set Directory Path
$Directory = $destination + "\" + $year + "\" + $month + "-" + $day + "-" + $year
}

# Out FileName, year and month
#$file.Name
#$year
#$month
#$day
 
# Create directory if it doesn't exsist
if (!(Test-Path $Directory))
{
New-Item $directory -type directory
}
 
# Move File to new location
$file | Move-Item -Destination $Directory
}