#errori korral ei soovi veateadet
$ErrorActionPreference = 'SilentlyContinue'

#Küsime konto info
$Eesnimi = Read-Host -Prompt "Sisesta oma eesnimi"
$Perenimi = Read-Host -Prompt "Sisesta oma Perenimi"
$Kasutajanimi = $Eesnimi + "." + $Perenimi
Write-Output "Kustutakse kasutaja $($Kasutajanimi.ToLower())" 


#Kustutame konto
Remove-LocalUser $Kasutajanimi

if ($?) {
    Write-Output "Kasutaja $($Kasutajanimi.ToLower()) on kustutatud"
}
else {
    Write-Host "Kasutaja ei eksisteeri või tekkis probleem kustutamisel. Palun proovige uuesti."
}

#errori korral ei soovi veateadet
$ErrorActionPreference = 'Stop'