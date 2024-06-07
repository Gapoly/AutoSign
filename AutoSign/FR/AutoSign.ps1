param([switch]$Elevated)


###  Créer une fonction pour voir si l'utilisateur est admin ###
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

### Lance un prompt admin ### 
function prompt{
    if ((Test-Admin) -eq $false)  {
        if ($elevated) {
        } else {
            Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
        }
    }
}
 

 ### On prend le certificat apte à pouvoir signer des scripts, avec le bon utilisateur ###
$DN = Invoke-Command { whoami /FQDN }
$DN = $DN.Replace(",", ", ")
$CertCodeSigning = Get-ChildItem Cert:\CurrentUser\TrustedPublisher\ -CodeSigningCert | Where-Object {$_.Subject -eq "$DN"}

### L'heure et la date de la signature
$TimestampServer = "http://timestamp.comodoca.com/authenticode"

### On prend les variables qu'on a créer en haut pour les rappeler ici et faire la signature ###
function sign{
Set-AuthenticodeSignature $ScriptToSign -Certificate $CertCodeSigning -TimestampServer $TimestampServer
Write-Host "`nVotre script est maintenant signé `n"
pause
exit
}

### Les différentes fonctions ###
#1: Un fichier se trouvant dans le dossier préciser
#2: Tous les fichiers se trouvant dans le dossier préciser
#3: Un fichier dans un dossier spécifique
#4: Tous les fichiers dans un dossier spécifique

### A partir de la ces options vont lancer un prompt admin pour pouvoir signer des scripts non écris par l'utilisateur ###
#5: Un fichier se trouvant dans le dossier préciser
#6: Tous les fichiers se trouvant dans le dossier préciser
#7: Un fichier dans un dossier spécifique
#8: Tous les fichiers dans un dossier spécifique

#9: Quitter

function fichier1{

Clear-Host

$file1 = Read-Host "Entrez le nom de votre script PowerShell"

$ScriptToSign = "C:\Script\$file1.ps1"

sign
}

function dossier2{

Clear-Host

$ScriptToSign = "C:\Script\*.ps1"

sign
}

function fichier3{

Clear-Host

$file3 = Read-Host "Chemin de votre script PowerShell"
$ScriptToSign = "$file3.ps1"

sign
}

function dossier4{

Clear-Host

$dir4 = Read-Host "Chemin de votre dossier"
$ScriptToSign = "$dir4\*.ps1"

sign
}

function fichier5{

Clear-Host

prompt

$file5 = Read-Host "Entrez le nom du script PowerShell"

$ScriptToSign = "C:\Script\$file5.ps1"

sign
}

function dossier6{

Clear-Host

prompt

$ScriptToSign = "C:\Script\*.ps1"

sign
}

function fichier7{

Clear-Host

prompt

$file7 = Read-Host "Chemin du script PowerShell"
$ScriptToSign = "$file7.ps1"

sign
}

function dossier8{

Clear-Host

prompt

$dir8 = Read-Host "Chemin du dossier"
$ScriptToSign = "$dir8\*.ps1"

sign
}


### Le joli menu ###
function menu{

    
       Write-Host "##############################################"

       Write-Host "
                _        _____ _             
     /\        | |      / ____(_)            
    /  \  _   _| |_ ___| (___  _  __ _ _ __  
   / /\ \| | | | __/ _ \\___ \| |/ _` | '_ \ 
  / ____ \ |_| | || (_) |___) | | (_| | | | |
 /_/    \_\__,_|\__\___/_____/|_|\__, |_| |_|
                                  __/ |      
                                 |___/       


        "

        Write-Host "############################################## `n"


        Write-Host "Ce script permet de signer des scripts PowerShell `n"

        Write-Host "Vos scripts :`n"
        Write-Host "1 : Fichier"
        Write-Host "2 : Dossier `n"
        Write-Host "3 : Fichier spécifique"
        Write-Host "4 : Dossier spécifique `n"

        Write-Host "Tous les scripts (admin) :`n"
        Write-Host "5 : Fichier"
        Write-Host "6 : Dossier `n"
        Write-Host "7 : Fichier spécifique"
        Write-Host "8 : Dossier spécifique`n"


        Write-Host "9 : Quitter `n"
}
menu

### Faire son choix ###
do{
     $choix = Read-Host "Entrez votre option"

     switch($choix){
        "1"{
            fichier1
        }
        "2"{
            dossier2
        }
        "3"{
            fichier3
        }
        "4"{
            dossier4
        }
        "5"{
            fichier5
        }
        "6"{
            dossier6
        }
        "7"{
            fichier7
        }
        "8"{
            dossier8
        }
        "9"{
            exit
        }
        default {
            Write-Host "Choix invalide"
        }
    }

} while($true)
