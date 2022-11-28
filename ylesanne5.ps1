#Lisame mooduli
add-type -AssemblyName System.Web
#Küsime konto info
$Eesnimi = Read-Host -Prompt "Sisesta oma eesnimi"
$Perenimi = Read-Host -Prompt "Sisesta oma Perenimi"
$Kasutajanimi = $Eesnimi + "." + $Perenimi
$Taisnimi = $Eesnimi + " " + $Perenimi
Write-Output "Kasutaja nimi on: $($Kasutajanimi.ToLower())"
$Kontokirjeldus = Read-Host -Prompt "Sisesta konto kirjeldus" 
#Loob parooli
$Parool = [System.Web.Security.Membership]::GeneratePassword(8,2)
Write-Output "Su parool on: $Parool"

"$Kasutajanimi;$Parool" | Out-File -FilePath C:\Users\Administrator\Documents\win_skriptimine\kasutajanimi.txt -Append

#loome paarooli
$KasutajaParool = ConvertTo-SecureString "$Parool" -AsPlainText -Force
#Teeme konto
Try {
New-LocalUser $Kasutajanimi.ToLower() -Password $KasutajaParool -FullName $Taisnimi -Description $Kontokirjeldus -ErrorAction Stop
}
Catch {Write-Host "Midagi läks valesti"}