# Määrame, kus kohas on fail, mille sees on kasutaja andmed
$Fail = "C:\Users\Administrator\Documents\kasutajad.csv"
# Loeme failist sisu, info jaotatakse ; järgi
$Kasutajad = Import-Csv $Fail -Encoding Default -Delimiter ";"
# Failis on iga kastaja andmed eraldi reas
# Vaatama faili sisu ridade kaupa
# Selleks avame iga rida $kasutaja muutuja sisse

foreach ($kasutaja in $Kasutajad)
{
    # Reas in mitu väärtust, siis iga element on kätte saadav veeru nimetuse järgi, mis me sisestame
    # $muutuja.VeeruNimetus kujul
    $Kasutajanimi = $kasutaja.Kasutajanimi
    $Taisnimi = $kasutaja.Taisnimi
    $Kontokirjeldus = $kasutaja.KontoKirjeldus
    $Parool = $kasutaja.Parool | ConvertTo-SecureString -AsPlainText -Force
    # Kasutades saadud info lisame kasutaja
    New-LocalUser -Name $Kasutajanimi -Password $Parool -FullName "$Taisnimi" -Description "$KontoKirjeldus"
}