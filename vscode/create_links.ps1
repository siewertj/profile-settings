# Hardlink the files 
$original_file = "${env:AppData}\Code\User\settings.json"
$new_file = "${PSScriptRoot}\settings.json"
if ( (Test-Path $original_file -PathType Leaf) ) {
	$backup_file = "${original_file}.bak"
	Remove-Item -Path ${backup_file}
	Write-Host "'${original_file}' already exists. Moving to ${backup_file}"
	Move-Item -Path ${original_file} -Destination ${backup_file}
}
cmd /c mklink /H ${original_file} ${new_file}

$original_file = "${env:AppData}\Code\User\keybindings.json"
$new_file = "${PSScriptRoot}\keybindings.json"
if ( (Test-Path $original_file -PathType Leaf) ) {
	$backup_file = "${original_file}.bak"
	Remove-Item -Path ${backup_file}
	Write-Host "'${original_file}' already exists. Moving to ${backup_file}"
	Move-Item -Path ${original_file} -Destination ${backup_file}
}
cmd /c mklink /H ${original_file} ${new_file}
