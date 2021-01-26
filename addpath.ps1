function AddTo-Path{
	param(
		[string]$Dir
	)

	IF (!$Dir)
	{ Return ‘No Folder Supplied. $ENV:PATH Unchanged’}

	IF ($ENV:PATH | Select-String -SimpleMatch $Dir)
	{ Return ‘Folder already within $ENV:PATH’ }

	if( !(Test-Path $Dir) ){
		Write-warning "Supplied directory was not found!"
		return
	}
	$PATH = [Environment]::GetEnvironmentVariable("PATH", "Machine")
	if( $PATH -notlike "*"+$Dir+"*" ){
		[Environment]::SetEnvironmentVariable("PATH", "$PATH;$Dir", "Machine")
	}
	#get $PATH again so I can print the new result
	$PATH = [Environment]::GetEnvironmentVariable("PATH", "Machine")
	# Show our results back to the world

	Return $PATH
}

AddTo-Path($args[0])