#vaatab kas error on
try {
#Küsime konto info
$Eesnimi = Read-Host -Prompt "Sisesta oma eesnimi"
$Perenimi = Read-Host -Prompt "Sisesta oma Perenimi"
$Kasutajanimi = $Eesnimi + "." + $Perenimi
Write-Output "Kasutaja $($Kasutajanimi.ToLower()) on kustutatud" 

#Kustutame konto
Remove-LocalUser $Kasutajanimi
}
Catch{Write-Host "Midagi läks valesti"}