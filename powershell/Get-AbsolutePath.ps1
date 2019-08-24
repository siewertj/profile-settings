param(
	[Parameter(Mandatory=$true)][string] $ProfileRoot
)

function Get-AbsolutePath ($Path) {
	# System.IO.Path.Combine has two properties making it necesarry here:
	#   1) correctly deals with situations where $Path (the second term) is an absolute path
	#   2) correctly deals with situations where $Path (the second term) is relative
	# (join-path) commandlet does not have this first property
	$Path = [System.IO.Path]::Combine( ((Get-Location).Path), ($Path) );

	# this piece strips out any relative path modifiers like '..' and '.'
	$Path = [System.IO.Path]::GetFullPath($Path);

	return $Path;
}
