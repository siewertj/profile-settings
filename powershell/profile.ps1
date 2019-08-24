#$ProfileRoot = ${PSScriptRoot}
#$env:PSModulePath

#. "${PSScriptRoot}\load-vim.ps1"
#. "${PSScriptRoot}\load-git.ps1"

Set-PSReadlineOption -BellStyle None

Set-Alias which Get-Command
Set-Alias ssh "$(Split-Path (Get-Command git).path -Parent))\..\usr\bin\ssh"


function Test-Administrator {
	$user = [Security.Principal.WindowsIdentity]::GetCurrent();
	(New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
$IsRunningAsAdmin = Test-Administrator

function List-Colors {
	[enum]::GetValues([System.ConsoleColor]) | ForEach-Object {
		Write-Host $_ -ForegroundColor $_
	}
}


function git_prompt {
	$branch = git rev-parse --abbrev-ref HEAD
	if ($NULL -eq $branch) { return }

	if ("" -eq "$(git diff --shortstat)" ) {
		Write-Host "[${branch}]" -NoNewline -ForegroundColor "Green"
	} else { 
		Write-Host "[${branch}]+" -NoNewline -ForegroundColor "Red"
	}
}

function prompt {
	# This is let us know if whatever we last ran failed or not
	if (!$(Invoke-Expression '$?') ) {
		Write-Host "Last command exited with error status." -ForegroundColor "Red"
	}

	# This will make sure we are aware we are running with Admin rights
	if ($IsRunningAsAdmin) {
		Write-Host "[ADMIN] "-NoNewline -ForegroundColor "Red"
	}

	# I like to have the date on my prompt
	#Write-Host $(Get-Date -UFormat "%m/%d %H:%M:%S %Z ") -NoNewline
	Write-Host $(Get-Date -UFormat "%H:%M:%S ") -NoNewline -ForegroundColor "DarkGray"

	# Now to put my path here
	$mypath = $(Get-Location).Path
	# This makes network paths look cleaner
	if((Split-Path ${mypath} -Qualifier) -eq "Microsoft.PowerShell.Core\FileSystem::") {
		$mypath = $(Split-Path ${mypath} -NoQualifier)
	}
	#if (${mypath}.length -ge 30) {
	#	$mypath = (${mypath}.substring(0,20)) + "...\" + (${mypath} -split('\\'))[-1]
	#}
	Write-Host "${mypath} " -NoNewLine -ForegroundColor "DarkCyan"

	git_prompt

	# Not yet ready ...
	Write-Host "`n(>'')>" -NoNewline -ForegroundColor "DarkMagenta"
	return " "
}
