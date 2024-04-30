$CertCodeSigning = Get-ChildItem Cert:\CurrentUser\TrustedPublisher\ -CodeSigningCert
# Get the certificate able to sign scripts
$TimestampServer = "http://timestamp.comodoca.com/authenticode"
# Date and time of the signature

function fichier{

Clear-Host

$file = Read-Host "Enter the Name of your PowerShell script"

$FileToSign = "C:\Script\$file.ps1"

Set-AuthenticodeSignature $FileToSign -Certificate $CertCodeSigning -TimestampServer $TimestampServer
# With the given variable, we sign the script

Write-Host "`nYour script is now signed `n"

pause
exit
}

function dossier{

Clear-Host

$DirToSign = "C:\Script\*.ps1"

Set-AuthenticodeSignature $DirToSign -Certificate $CertCodeSigning -TimestampServer $TimestampServer
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

    
        Write-Host "1 : File `n"
        Write-Host "2 : Directory `n"
        Write-Host "3 : Exit `n"
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
            Write-Host "Incorrect value"
        }
    }

} while($true)
