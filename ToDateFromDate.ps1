# Get the files which should be moved, without folders
$files = Get-ChildItem 'C:\Users\Chris\Downloads\0 Liv Phone Images\0_Camera' -Recurse | where {!$_.PsIsContainer}
 
# List Files which will be moved
$files
 
# Target Filder where files should be moved to. The script will automatically create a folder for the year and month.
$targetPath = 'C:\Users\Chris\Downloads\0 Liv Phone Images\0_Camera_albumns'
 
foreach ($file in $files)
{
# Get year and Month of the file
# I used LastWriteTime since this are synced files and the creation day will be the date when it was synced
$year = $file.LastWriteTime.Year.ToString()
$month = $file.LastWriteTime.Month.ToString()
$day = $file.LastWriteTime.Day.ToString()

# Out FileName, year and month
$file.Name
$year
$month
$day
 
# Set Directory Path
$Directory = $targetPath + "\" + $year + "\" + $day + "-" + $month + "-" + $year
# Create directory if it doesn't exsist
if (!(Test-Path $Directory))
{
New-Item $directory -type directory
}
 
# Move File to new location
$file | Move-Item -Destination $Directory
}