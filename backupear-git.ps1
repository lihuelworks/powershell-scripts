	# TODO:
# - poner archivos de chocolatey, psgallery (2 formatos de instalación)

#########################################################################3

# VAR section
$cp_source = "C:\Users\Mathias\Documents\_configs\_otras cosas win"

$confirmationList = Read-Host "ACTUALIZAS lista de modulos?: y = SI // otro = NO"
#Get-Module printear
if ($confirmationList -eq 'y') {
	
	Write-Host ">> Get-Module RESULTADOS: `n"
	Write-Host ">> Get-Module RESULTADOS: `n"
	Get-Module | Select-Object Name
	#Get-Module a .txt
	Write-Host ">> Get-Module RESULTADOS: "  > "$cp_source\installed-modules-powershell.txt"
	Get-Module | Select-Object Name >> "$cp_source\installed-modules-powershell.txt"

	#Get-InstalledModule printear
	Write-Host ">> Get-InstalledModule RESULTADOS: `n"
	Get-InstalledModule | Select-Object Name
	#Get-InstalledModule a .txt
	Write-Host ">> Get-InstalledModule RESULTADOS: "  >> "$cp_source\installed-modules-powershell.txt"
	Get-InstalledModule | Select-Object Name >> "$cp_source\installed-modules-powershell.txt"
}


# SECCION: copiar configs
$confirmation = Read-Host "COPIAS los CONFIGS FILES de otras carpetas? (gallery-dl,mpv,powerheaven,powershell_profile): y = SI // otro = NO"
if ($confirmation -eq 'y') {
	#Tirandote a donde lo va a copiar
	Write-Host "COPIANDO a $cp_source --------------------------`n"
	#Copiando
	Copy-Item -Path "C:/Users/Mathias/.gitconfig" -Destination $cp_source -Force -Recurse
	Write-Host "... .gitconfig COPIADO ! `n"
	
	Copy-Item -Path "C:\Users\Mathias\AppData\Local\Packages\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\LocalState\settings.json" -Destination  $cp_source -Force -Recurse
	Write-Host "...Windows Terminal settings COPIADO ! `n"
	
	Copy-Item -Path "C:\Users\Mathias\gallery-dl" -Destination $cp_source -Force -Recurse
	Write-Host "...gallery-dl config folder COPIADO ! `n"

	Copy-Item -Path "C:\Users\Mathias\AppData\Roaming\mpv" -Destination $cp_source  -Force -Recurse
	Write-Host "...mpv config folder COPIADO ! `n"
	
	Copy-Item -Path "C:\Users\Mathias\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Destination $cp_source -Force -Recurse
	Write-Host "...powershell profile COPIADO ! `n"
	
	Copy-Item -Path "C:\Windows\System32\WindowsPowerShell\v1.0\powerheaven.exe" -Destination $cp_source -Force -Recurse
	Write-Host "...powerheaven (custom admin powershell) COPIADO ! `n"
	
	Copy-Item -Path "C:\Users\Mathias\Pictures\saved_gallery-dl\_download-archives" -Destination $cp_source -Force -Recurse
	Write-Host "...gallery-dl download-archives COPIADOS ! `n"
	
	Copy-Item -Path "C:\Users\Mathias\Documents\_soft\design n art soft\advanced_renamer_portable\BatchMethods" -Destination $cp_source -Force -Recurse
	Write-Host "...advance renamer BatchMethods COPIADOS ! `n"
}

# SECCION: copiar fonts. Separado pq tarda lo suyo en comprimir
$confirmation = Read-Host "backupeas FONT 	folder? (compresion tarda un ratito): y = SI // otro = NO"
if ($confirmation -eq 'y') {
	#copiando fuentes: 7z "switch de formato de copia" "-oDESTINO" "nombre-zip" "carpeta-a-copiar"
	#le mando © el path completo en vez de $otros_destination, pq andaba medio raro
	#7z -mx9 a "C:\Users\Mathias\AppData\Local\Microsoft\Windows\Fonts"
	7z -mx9 a mis-fonts.7z "C:\Users\Mathias\AppData\Local\Microsoft\Windows\Fonts\*"
	Move-Item -Force -Path '.\mis-fonts.7z' '..\_otras cosas win\'	
}


# SECCION: mandarlo a Github
$confirmation2 = Read-Host "SUBIS a GIT?: y = SI // otro = NO"
if ($confirmation2 -eq 'y') {
	Write-Host "GIT STUFF ------------------------------------`n"
	##Write-Host ""
	# Preguntando si vas a escribir tu propio msj git commit
	$confirmationGit = Read-Host "___PERSONALIZAS msj de COMMIT? (Default: actualizado + fecha): y = SI otro = NO"
	if ($confirmationGit -eq 'y') {
		$gitMsj = Read-Host "Escribi tu msj de commit: "
		Write-Host "_____ mensaje quedo como: $gitMsj`n"
		if([string]::IsNullOrEmpty($gitMsj)){
			Write-Host "ERROR ___________________________________`n"
			## Write-Host ""
			Write-Host "Dejaste tu mensaje commit VACIO, saliendo sin commitear...`n"
			## Write-Host ""
			exit
		}
		Write-Host "------------------------------------`n"
		## Write-Host ""
	}else
	{
		$gitMsj = Get-Date -UFormat "Actualizado %A, %b %d // A las: %R (%Y)"
		Write-Host "_____mensaje quedo como: $gitMsj`n"
		Write-Host "------------------------------------`n"
		## Write-Host ""
	}
	Write-Host "COMMITEANDO ___________________________________`n"
	## Write-Host ""
	Write-Host "Todo OK, commiteando...`n"
	cd "C:\Users\Mathias\Documents\_configs\powershell scripts"
	git add --all; git commit -m $gitMsj;git push origin master
	
} else {
	Write-Host "NADA ___________________________________`n"
	## Write-Host ""
	Write-Host "Listo, NADA commiteando. Saliendo...`n"
	## Write-Host ""
}


# SECCION: cleanup de configs copiados a "..\_otras cosas win"
Write-Host "CLEANUP: borrando configs copiados a '..\_otras cosas win' `n"
# test line, -WhatIf te dice q sucedería sin borran nada	
#Get-ChildItem $cp_source  -Recurse | Remove-Item -WhatIf -Recurse -Force -Confirm:$false 
Get-ChildItem $cp_source  -Recurse | Remove-Item -Recurse -Force -Confirm:$false 
Write-Host "CLEANUP terminado ! `n"