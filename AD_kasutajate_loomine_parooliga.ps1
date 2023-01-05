$file = "C:\Users\Administrator\Documents\win_skriptimine\adkasutajd_paroolita.csv" 
2 $ErrorActionPreference = 'Stop' 
3 
 
4 (Get-Content $file -Encoding UTF8) | Set-Content $file -Encoding UTF8 
5 
 
6 Add-Type -AssemblyName System.Web 
7 
 
8 $users = Import-Csv $file -Encoding Default -Delimiter ";" 
9 
 
10 $outfile =  "C:\Users\Administrator\Documents\win_skriptimine\kasutajanimi.csv" 
11 $newcsv = {} | Select "Name","Password" | Export-Csv $outfile -Delimiter ";" 
12 $newcsv = Import-Csv $outfile -Delimiter ";" 
13 
 
14 foreach ($user in $users){ 
15 
 
16      
17 
 
18     echo $newcsv 
19 
 
20     $username = $user.FirstName + "." + $user.LastName 
21     $username = $username.ToLower() 
22     $username = Translit($username) 
23     $upname =$username + "@sv-kool.local" 
24     $displayname = $user.Firstname + " " + $user.LastName 
25     $parool = [System.Web.Security.Membership]::GeneratePassword(8,2) 
26     New-ADUser -Name $username ` 
27         -Displayname $displayname ` 
28         -GivenName $user.FirstName ` 
29         -Surname $user.LastName ` 
30         -Department $user.Department ` 
31         -Title $user.Role ` 
32         -UserPrincipalName $upname ` 
33         –AccountPassword (ConvertTo-SecureString $parool -AsPlainText -force) -ChangePasswordAtLogon $true -Enabled $true 
34 
 
35     echo $username 
36     echo $parool 
37 
 
38     $newcsv.Name = $username 
39     $newcsv.Password = $parool 
40     $newcsv | Export-CSV $outfile –Append -Delimiter ";" 
41 }  
42 
 
47 function Translit { 
48     param( 
49         [string] $inputString 
50     ) 
51     $Translit = @{ 
52         [char]'õ' = 'o' 
53         [char]'ö' = 'o' 
54         [char]'ä' = 'ä' 
55         [char]'ü' = 'u' 
56     } 
57     $outputString = "" 
58     foreach ($character in $inputCharacter = $inputString.ToCharArray()){ 
59         if ($Translit[$character] -cne $null) { 
60             $outputString += $Translit[$character] 
61         } else { 
62            $outputString += $character  
63         } 
64     } 
65     Write-Output $outputString 
66 }  
67 if($?) ` 
68 {    
69 echo "Kasutaja on loodud." 
70 
 
71 } 
72 else 
73 { 
74 $ErrorActionPreference = 'SilentlyContinue' 
75 echo "On tekkinud viga, kasutaja juba eksisteerib." 
76 } 
77 $ErrorActionPreference = 'Stop' 
