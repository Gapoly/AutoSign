param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
# Créer une fonction pour voir si l'utilisateur est admin

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}
# Lance un prompt admin

$CertCodeSigning = Get-ChildItem Cert:\CurrentUser\TrustedPublisher\ -CodeSigningCert
# On prend le certificat apte à pouvoir signer des scripts
$TimestampServer = "http://timestamp.comodoca.com/authenticode"
# L'heure et la date de la signature

function fichier{

Clear-Host

$file = Read-Host "Entrez le nom de votre script PowerShell"

$FileToSign = "C:\Script\$file.ps1"

Set-AuthenticodeSignature $FileToSign -Certificate $CertCodeSigning -TimestampServer $TimestampServer
#On prend les variables qu'on a crÃ©er en haut pour les rappeler ici

Write-Host "`nVotre script est maintenant signé `n"

pause
exit
}

function dossier{

Clear-Host

$DirToSign = "C:\Script\*.ps1"

Set-AuthenticodeSignature $DirToSign -Certificate $CertCodeSigning -TimestampServer $TimestampServer
# On prend les variables qu'on a créer en haut pour les rappeler ici et faire la signature
exit
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

    
        Write-Host "1 : Fichier `n"
        Write-Host "2 : Dossier `n"
        Write-Host "3 : Quiter `n"
}
menu
do{
     $choix = Read-Host "Entrez votre option"

     switch($choix){
        "1"{
             fichier
        }
        "2"{
            dossier
        }
        "3"{
            exit
        }
        default {
            Write-Host "Choix invalide"
        }
    }

} while($true)
