# Hardlink the files 
$original_file = "${env:AppData}\Code\User\settings.json"
if ( (Test-Path $original_file -PathType Leaf) ) {
	Write-Host "'${original_file}' already exists. Moving to ${original_file}.bak."
	Copy-Item -Path ${original_file} -Destination ${original_file}.bak
}
#cmd /c mklink /H 
#$dest = "${PSScriptRoot}\settings.json"
