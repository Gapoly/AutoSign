param([switch]$Elevated)


###  Check if the user is an admin ###
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

### Lauch admin prompt ### 
function prompt{
    if ((Test-Admin) -eq $false)  {
        if ($elevated) {
        } else {
            Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
        }
    }
}
 

 ### Certificate able to sign scripts ###
$DN = Invoke-Command { whoami /FQDN }
$DN = $DN.Replace(",", ", ")
$CertCodeSigning = Get-ChildItem Cert:\CurrentUser\TrustedPublisher\ -CodeSigningCert | Where-Object {$_.Subject -eq "$DN"}

### Date & Time
$TimestampServer = "http://timestamp.comodoca.com/authenticode"

### Sign the script ###
function sign{
Set-AuthenticodeSignature $ScriptToSign -Certificate $CertCodeSigning -TimestampServer $TimestampServer
Write-Host "`nYour script is now signed `n"
pause
exit
}

### Functions usage ###
#1: File in the directory
#2: All the files in the directory
#3: File in a specific directory
#4: All the files in a specific directory

### Launch an admin prompt to sign scripts made by other users ###
#5: File in the directory
#6: All the files in the directory
#7: File in a specific directory
#8: All the files in a specific directory

#9: Exit

function fichier1{

Clear-Host

$file1 = Read-Host "Enter the name of your PowerShell script"

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

$file3 = Read-Host "PowerShell script filepath"
$ScriptToSign = "$file3.ps1"

sign
}

function dossier4{

Clear-Host

$dir4 = Read-Host "Directory path"
$ScriptToSign = "$dir4\*.ps1"

sign
}

function fichier5{

Clear-Host

prompt

$file5 = Read-Host "Enter the name of the PowerShell script"

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

$file7 = Read-Host "PowerShell script filepath"
$ScriptToSign = "$file7.ps1"

sign
}

function dossier8{

Clear-Host

prompt

$dir8 = Read-Host "Directory path"
$ScriptToSign = "$dir8\*.ps1"

sign
}

### Pretty menu ###
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

        Write-Host "Your scripts :`n"
        Write-Host "1 : File"
        Write-Host "2 : Directory `n"
        Write-Host "3 : Specific File"
        Write-Host "4 : Specific directory `n"

        Write-Host "All scripts (admin) :`n"
        Write-Host "5 : File"
        Write-Host "6 : Directory `n"
        Write-Host "7 : Specific File"
        Write-Host "8 : Specific Directory`n"

        Write-Host "9 : Exit `n"
}
menu

### Faire son choix ###
do{
     $choix = Read-Host "Choose your option"

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
            Write-Host "Invalid Choice"
        }
    }

} while($true)
