param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
# CrÃ©er une fonction pour voir si l'utilisateur est admin
function prompt{
    if ((Test-Admin) -eq $false)  {
        if ($elevated) {
        } else {
            Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
        }
    }
}
# Lance un prompt admin

$CertCodeSigning = Get-ChildItem Cert:\CurrentUser\TrustedPublisher\ -CodeSigningCert
# On prend le certificat apte Ã  pouvoir signer des scripts
$TimestampServer = "http://timestamp.comodoca.com/authenticode"
# L'heure et la date de la signature

function sign{
Set-AuthenticodeSignature $ScriptToSign -Certificate $CertCodeSigning -TimestampServer $TimestampServer
# On prend les variables qu'on a crÃ©er en haut pour les rappeler ici et faire la signature

Write-Host "`nVotre script est maintenant signÃ© `n"

pause
exit
}

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
        Write-Host "3 : Fichier spÃ©cifique"
        Write-Host "4 : Dossier spÃ©cifique `n"

        Write-Host "Tous les scripts (admin) :`n"
        Write-Host "5 : Fichier"
        Write-Host "6 : Dossier `n"
        Write-Host "7 : Fichier spÃ©cifique"
        Write-Host "8 : Dossier spÃ©cifique`n"


        Write-Host "9 : Quitter `n"
}
menu
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
