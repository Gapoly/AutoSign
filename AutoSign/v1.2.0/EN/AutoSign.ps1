param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
# Function to see if user is an admin

if ((Test-Admin) -eq $false)  {
    if ($elevated) {
    } else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
    }
    exit
}
# Launch admin prompt

$CertCodeSigning = Get-ChildItem Cert:\CurrentUser\TrustedPublisher\ -CodeSigningCert
# Certificate able to sign scripts
$TimestampServer = "http://timestamp.comodoca.com/authenticode"
# Date and time

function fichier{

Clear-Host

$file = Read-Host "Name of your PowerShell script"

$FileToSign = "C:\Script\$file.ps1"

Set-AuthenticodeSignature $FileToSign -Certificate $CertCodeSigning -TimestampServer $TimestampServer
# Sign the script

Write-Host "`nYour script is now signed `n"

pause
exit
}

function dossier{

Clear-Host

$DirToSign = "C:\Script\*.ps1"

Set-AuthenticodeSignature $DirToSign -Certificate $CertCodeSigning -TimestampServer $TimestampServer
# Sign the directory
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


        Write-Host "This script allow you to AutoSign your PowerShell scripts `n"

    
        Write-Host "1 : Fichier `n"
        Write-Host "2 : Dossier `n"
        Write-Host "3 : Quiter `n"
}
menu
do{
     $choix = Read-Host "Choose your option"

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
            Write-Host "Invalid choice"
        }
    }

} while($true)
