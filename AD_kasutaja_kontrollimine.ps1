$file = "C:\Users\Administrator\Documents\win_skriptimine\adkasutajad.csv" 
2 
 
3 (Get-Content $file -Encoding UTF8) | Set-Content $file -Encoding UTF8 
4 
 
5 $users = Import-Csv $file -Encoding Default -Delimiter ";" 
6 
 
7 foreach ($user in $users){ 
8     $username = $user.FirstName + "." + $user.LastName 
9     $username = $username.ToLower() 
10     $username = Translit($username) 
11     $upname =$username + "@sv-kool.local" 
12     $displayname = $user.Firstname + " " + $user.LastName 
13     New-ADUser -Name $username ` 
14         -Displayname $displayname ` 
15         -GivenName $user.FirstName ` 
16         -Surname $user.LastName ` 
17         -Department $user.Department ` 
18         -Title $user.Role ` 
19         -UserPrincipalName $upname ` 
20         -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -force) -enabled $true 
21 }  
22 
 
23 function Translit { 
24     param( 
25         [string] $inputString 
26     ) 
27     $Translit = @{ 
28         [char]'õ' = 'o' 
29     } 
30     $outputString = "" 
31     foreach ($character in $inputCharacter = $inputString.ToCharArray()){ 
32         if ($Translit[$character] -cne $null) { 
33             $outputString += $Translit[$character] 
34         } else { 
35            $outputString += $character  
36         } 
37     } 
38     Write-Output $outputString 
39 }  
40 if($?) ` 
41 {    
42 echo "Kasutaja on loodud." 
43 
 
44 } 
45 else 
46 { 
47 $ErrorActionPreference = 'SilentlyContinue' 
48 echo "On tekkinud viga, kasutaja juba eksisteerib." 
49 } 
