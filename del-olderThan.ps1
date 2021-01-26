# archivo 

Write-Host "Agarrado archivo: $($args[0])`n"
$date = Get-Item "$($args[0])" | Foreach {$_.LastWriteTime}
Write-Host "Fecha del item: $date`n"
$dirName = "_files older than" + " " + $($date.ToString('yyyy-MM-dd'))

function makeFolderDate {
	Write-Host "__Entrando a funcion makeFolderDate`n"
	# armar carpeta donde se va a mover eso	
	New-Item -ItemType Directory -Path . -Name "$dirName" > $null
	Write-Host "folder HECHO, llamado: .\$dirName`n"
	
}

# activando funcion para crear carpeta
makeFolderDate

function moveToFolder {

	$files = Get-Childitem . | Where-Object { $_.LastWriteTime -lt "$date" }
	ForEach($file in $files) {
		Write-Host "moviendo archivo " -NoNewline
		Write-Host "$file" -ForegroundColor Green -NoNewline
		Write-Host " a " -NoNewline
		Write-Host "$dirName`r`n" -ForegroundColor DarkGreen
		$file | Move-Item -Destination $dirName

	}
	
}

# activando funcion para mover archivos
moveToFolder

#ForEach-Object { Move-Item -Force -Destination ".\coso" }


# mover todos los items a la carpeta temporal
# Get-Childitem . | Where-Object { $_.LastWriteTime -lt "$date" }
#Get-Childitem . | Where-Object { $_.LastWriteTime -lt "$date" } | Sort CreationTime -Descending | Select -Skip 1 | Select -First 1 | ForEach-Object { Move-Item -Force -Destination ".\coso" }
#| Select -Skip 1 | Select -First 1 
#| ForEach-Object { Move-Item -Force -Destination  $dirName }
## remover carpeta con items
# obtener full path de la carpeta "older than x"
#$delPath = (Resolve-Path "$dirName").Path
#Write-Host "se borraria $delPath"
#Add-Type -AssemblyName Microsoft.VisualBasic
#[Microsoft.VisualBasic.FileIO.FileSystem]::Deletedirectory('e:\test\testfolder','OnlyErrorDialogs','SendToRecycleBin')

#delete that folder with trash
