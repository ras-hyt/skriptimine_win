#vaatab kas error on
try {
#Küsime konto info
$Eesnimi = Read-Host -Prompt "Sisesta oma eesnimi"
$Perenimi = Read-Host -Prompt "Sisesta oma Perenimi"
$Kasutajanimi = $Eesnimi + "." + $Perenimi
$Taisnimi = $Eesnimi + " " + $Perenimi
Write-Output "Kasutaja nimi on: $($Kasutajanimi.ToLower())"
$Kontokirjeldus = Read-Host -Prompt "Sisesta konto kirjeldus" 



#loome paarooli
$KasutajaParool = ConvertTo-SecureString "Parool1!" -AsPlainText -Force
#Teeme konto
New-LocalUser $Kasutajanimi.ToLower() -Password $KasutajaParool -FullName $Taisnimi -Description $Kontokirjeldus
}
Catch{Write-Host "Midagi läks valesti"}