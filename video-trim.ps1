#script para cortar video simple usando ffmpeg
$param1 = $args[0]
$comienzo = Read-Host "Ingresa COMIENZO video"	
$final = Read-Host "Ingresa FINAL video"	

#obteniendo nombre de nuevo archivo
$confirmation = Read-Host "dejas nombre DEFAULT al archivo? (default 'nombreOriginal - cortado'): y = NO // otro = SI"
if ($confirmation -ne 'y') {
	$nombreOutput = Read-Host "ingresa nombre de output de archivo: "
	Write-Host "NOMBRE QUEDA COMO: $nombreOutput"

} else {
	$nombreOutput = (Get-Item $param1).Basename
	$nombreOutput = "$($nombreOutput) - cortado"
	Write-Host "NOMBRE QUEDA COMO: $nombreOutput"
}

Write-Host "comenzando trim..."
ffmpeg -hide_banner -loglevel panic  -i $($param1) -ss $($comienzo) -to $($final) -c:v copy -c:a copy "$($nombreOutput).mp4"