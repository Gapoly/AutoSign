Import-Module -Name ADCSAdministration

$CertCodeSigning = Get-ChildItem Cert:\CurrentUser\My\ -CodeSigningCert
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

# SIG # Begin signature block
# MIIZXwYJKoZIhvcNAQcCoIIZUDCCGUwCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU7NQe0ReJ6C7qL1TUZ8RtMpxm
# fOKgghN2MIIFiTCCBHGgAwIBAgITJwAAAAOki7bIP7Z/uwAAAAAAAzANBgkqhkiG
# 9w0BAQsFADBMMRMwEQYKCZImiZPyLGQBGRYDbGFuMRcwFQYKCZImiZPyLGQBGRYH
# ZG9tc2tvdjEcMBoGA1UEAxMTZG9tc2tvdi1TUlYtQURDUy1DQTAeFw0yNDA0MjQx
# NjM4MzZaFw0yNTA0MjQxNjM4MzZaMFYxEzARBgoJkiaJk/IsZAEZFgNsYW4xFzAV
# BgoJkiaJk/IsZAEZFgdkb21za292MQswCQYDVQQLEwJTSTEZMBcGA1UEAxMQTm9y
# bWFuIFNrb3ZnYWFyZDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMcq
# w8IxRZlaJG6o83O6VuBMw9/ngdKWMnlKHO1GuQkOgJq6h8/xgu/iO2dnXQfdRpD3
# cwlhk20h33onxUQmexzGJbcGXzOj2TyxkC7AwWyOSI4/eFFJLzddVYi6HGAbjZGd
# VOxjjvNfHstvgzrQPDXHZGgzDQ7RYSIwHhDt04pGKCQozu8OnWTbB4Ssh4worJPh
# lfqFyViwoLAPnzb1CqOtLCjZ3XebRfDJaiWuIuItv/LmGzBbkbrjvfbqJkn6sSb+
# g3Ka4R1fJpN36Ma7PtOqglWyf+sZDb9tf+mN1WZ/FVwyDQQM9o9n/vDsjI8G50/d
# WUjlHlvvM0bVKq/ujV0CAwEAAaOCAlgwggJUMCUGCSsGAQQBgjcUAgQYHhYAQwBv
# AGQAZQBTAGkAZwBuAGkAbgBnMBMGA1UdJQQMMAoGCCsGAQUFBwMDMA4GA1UdDwEB
# /wQEAwIHgDAdBgNVHQ4EFgQUVBiumANNK4fYcp8N7Iq7SEROZM4wHwYDVR0jBBgw
# FoAU+BX2J10VuQ1KbGweMeYdL38FGK4wgdIGA1UdHwSByjCBxzCBxKCBwaCBvoaB
# u2xkYXA6Ly8vQ049ZG9tc2tvdi1TUlYtQURDUy1DQSxDTj1TUlYtQURDUyxDTj1D
# RFAsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29u
# ZmlndXJhdGlvbixEQz1kb21za292LERDPWxhbj9jZXJ0aWZpY2F0ZVJldm9jYXRp
# b25MaXN0P2Jhc2U/b2JqZWN0Q2xhc3M9Y1JMRGlzdHJpYnV0aW9uUG9pbnQwgcUG
# CCsGAQUFBwEBBIG4MIG1MIGyBggrBgEFBQcwAoaBpWxkYXA6Ly8vQ049ZG9tc2tv
# di1TUlYtQURDUy1DQSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2VydmljZXMs
# Q049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1kb21za292LERDPWxhbj9j
# QUNlcnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhv
# cml0eTApBgNVHREEIjAgoB4GCisGAQQBgjcUAgOgEAwObnNAZG9tc2tvdi5sYW4w
# DQYJKoZIhvcNAQELBQADggEBACj+yaE5yolhroE792uq2TPS5N3Ocll/q2PyshCq
# vWemDAw6Uim/5gtqkFO5CR/hlU5ef5EvNb9RV7RmWLUCK8p+2eshI4qU/LywRUDl
# YoLcLmeSH1xMaoFmAP1nXq9QoBIsZKGhoOh+WCyAW0AOpq9yp1UCgLJ32akSdC4x
# c4DaIUseR1G0Be8A9s3n6aMbvjJp2isHyRHl1XyI5RmJ19xufaXXVfkMdFeC4efA
# y+a0qeECljommihIZbpBVxPFt3DQ8zQT5G7RvckDe3Tg7a7/rEq+Vg876uGT3n71
# +mDI0G/nv9CjfL1g4PZYwNFE3+/Jy2BFOnfaUuO2aghQtdUwggbsMIIE1KADAgEC
# AhAwD2+s3WaYdHypRjaneC25MA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAc
# BgNVBAoTFVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0
# IFJTQSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0xOTA1MDIwMDAwMDBaFw0z
# ODAxMTgyMzU5NTlaMH0xCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1h
# bmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
# aXRlZDElMCMGA1UEAxMcU2VjdGlnbyBSU0EgVGltZSBTdGFtcGluZyBDQTCCAiIw
# DQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMgbAa/ZLH6ImX0BmD8gkL2cgCFU
# k7nPoD5T77NawHbWGgSlzkeDtevEzEk0y/NFZbn5p2QWJgn71TJSeS7JY8ITm7aG
# PwEFkmZvIavVcRB5h/RGKs3EWsnb111JTXJWD9zJ41OYOioe/M5YSdO/8zm7uaQj
# QqzQFcN/nqJc1zjxFrJw06PE37PFcqwuCnf8DZRSt/wflXMkPQEovA8NT7ORAY5u
# nSd1VdEXOzQhe5cBlK9/gM/REQpXhMl/VuC9RpyCvpSdv7QgsGB+uE31DT/b0OqF
# jIpWcdEtlEzIjDzTFKKcvSb/01Mgx2Bpm1gKVPQF5/0xrPnIhRfHuCkZpCkvRuPd
# 25Ffnz82Pg4wZytGtzWvlr7aTGDMqLufDRTUGMQwmHSCIc9iVrUhcxIe/arKCFiH
# d6QV6xlV/9A5VC0m7kUaOm/N14Tw1/AoxU9kgwLU++Le8bwCKPRt2ieKBtKWh97o
# aw7wW33pdmmTIBxKlyx3GSuTlZicl57rjsF4VsZEJd8GEpoGLZ8DXv2DolNnyrH6
# jaFkyYiSWcuoRsDJ8qb/fVfbEnb6ikEk1Bv8cqUUotStQxykSYtBORQDHin6G6Ui
# rqXDTYLQjdprt9v3GEBXc/Bxo/tKfUU2wfeNgvq5yQ1TgH36tjlYMu9vGFCJ10+d
# M70atZ2h3pVBeqeDAgMBAAGjggFaMIIBVjAfBgNVHSMEGDAWgBRTeb9aqitKz1SA
# 4dibwJ3ysgNmyzAdBgNVHQ4EFgQUGqH4YRkgD8NBd0UojtE1XwYSBFUwDgYDVR0P
# AQH/BAQDAgGGMBIGA1UdEwEB/wQIMAYBAf8CAQAwEwYDVR0lBAwwCgYIKwYBBQUH
# AwgwEQYDVR0gBAowCDAGBgRVHSAAMFAGA1UdHwRJMEcwRaBDoEGGP2h0dHA6Ly9j
# cmwudXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FDZXJ0aWZpY2F0aW9uQXV0aG9y
# aXR5LmNybDB2BggrBgEFBQcBAQRqMGgwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQu
# dXNlcnRydXN0LmNvbS9VU0VSVHJ1c3RSU0FBZGRUcnVzdENBLmNydDAlBggrBgEF
# BQcwAYYZaHR0cDovL29jc3AudXNlcnRydXN0LmNvbTANBgkqhkiG9w0BAQwFAAOC
# AgEAbVSBpTNdFuG1U4GRdd8DejILLSWEEbKw2yp9KgX1vDsn9FqguUlZkClsYcu1
# UNviffmfAO9Aw63T4uRW+VhBz/FC5RB9/7B0H4/GXAn5M17qoBwmWFzztBEP1dXD
# 4rzVWHi/SHbhRGdtj7BDEA+N5Pk4Yr8TAcWFo0zFzLJTMJWk1vSWVgi4zVx/AZa+
# clJqO0I3fBZ4OZOTlJux3LJtQW1nzclvkD1/RXLBGyPWwlWEZuSzxWYG9vPWS16t
# oytCiiGS/qhvWiVwYoFzY16gu9jc10rTPa+DBjgSHSSHLeT8AtY+dwS8BDa153fL
# nC6NIxi5o8JHHfBd1qFzVwVomqfJN2Udvuq82EKDQwWli6YJ/9GhlKZOqj0J9QVs
# t9JkWtgqIsJLnfE5XkzeSD2bNJaaCV+O/fexUpHOP4n2HKG1qXUfcb9bQ11lPVCB
# bqvw0NP8srMftpmWJvQ8eYtcZMzN7iea5aDADHKHwW5NWtMe6vBE5jJvHOsXTpTD
# eGUgOw9Bqh/poUGd/rG4oGUqNODeqPk85sEwu8CgYyz8XBYAqNDEf+oRnR4GxqZt
# Ml20OAkrSQeq/eww2vGnL8+3/frQo4TZJ577AWZ3uVYQ4SBuxq6x+ba6yDVdM3aO
# 8XwgDCp3rrWiAoa6Ke60WgCxjKvj+QrJVF3UuWp0nr1Irpgwggb1MIIE3aADAgEC
# AhA5TCXhfKBtJ6hl4jvZHSLUMA0GCSqGSIb3DQEBDAUAMH0xCzAJBgNVBAYTAkdC
# MRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQx
# GDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDElMCMGA1UEAxMcU2VjdGlnbyBSU0Eg
# VGltZSBTdGFtcGluZyBDQTAeFw0yMzA1MDMwMDAwMDBaFw0zNDA4MDIyMzU5NTla
# MGoxCzAJBgNVBAYTAkdCMRMwEQYDVQQIEwpNYW5jaGVzdGVyMRgwFgYDVQQKEw9T
# ZWN0aWdvIExpbWl0ZWQxLDAqBgNVBAMMI1NlY3RpZ28gUlNBIFRpbWUgU3RhbXBp
# bmcgU2lnbmVyICM0MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEApJMo
# UkvPJ4d2pCkcmTjA5w7U0RzsaMsBZOSKzXewcWWCvJ/8i7u7lZj7JRGOWogJZhEU
# WLK6Ilvm9jLxXS3AeqIO4OBWZO2h5YEgciBkQWzHwwj6831d7yGawn7XLMO6EZge
# /NMgCEKzX79/iFgyqzCz2Ix6lkoZE1ys/Oer6RwWLrCwOJVKz4VQq2cDJaG7OOkP
# b6lampEoEzW5H/M94STIa7GZ6A3vu03lPYxUA5HQ/C3PVTM4egkcB9Ei4GOGp779
# 0oNzEhSbmkwJRr00vOFLUHty4Fv9GbsfPGoZe267LUQqvjxMzKyKBJPGV4agczYr
# gZf6G5t+iIfYUnmJ/m53N9e7UJ/6GCVPE/JefKmxIFopq6NCh3fg9EwCSN1YpVOm
# o6DtGZZlFSnF7TMwJeaWg4Ga9mBmkFgHgM1Cdaz7tJHQxd0BQGq2qBDu9o16t551
# r9OlSxihDJ9XsF4lR5F0zXUS0Zxv5F4Nm+x1Ju7+0/WSL1KF6NpEUSqizADKh2ZD
# oxsA76K1lp1irScL8htKycOUQjeIIISoh67DuiNye/hU7/hrJ7CF9adDhdgrOXTb
# WncC0aT69c2cPcwfrlHQe2zYHS0RQlNxdMLlNaotUhLZJc/w09CRQxLXMn2YbON3
# Qcj/HyRU726txj5Ve/Fchzpk8WBLBU/vuS/sCRMCAwEAAaOCAYIwggF+MB8GA1Ud
# IwQYMBaAFBqh+GEZIA/DQXdFKI7RNV8GEgRVMB0GA1UdDgQWBBQDDzHIkSqTvWPz
# 0V1NpDQP0pUBGDAOBgNVHQ8BAf8EBAMCBsAwDAYDVR0TAQH/BAIwADAWBgNVHSUB
# Af8EDDAKBggrBgEFBQcDCDBKBgNVHSAEQzBBMDUGDCsGAQQBsjEBAgEDCDAlMCMG
# CCsGAQUFBwIBFhdodHRwczovL3NlY3RpZ28uY29tL0NQUzAIBgZngQwBBAIwRAYD
# VR0fBD0wOzA5oDegNYYzaHR0cDovL2NybC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNB
# VGltZVN0YW1waW5nQ0EuY3JsMHQGCCsGAQUFBwEBBGgwZjA/BggrBgEFBQcwAoYz
# aHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBVGltZVN0YW1waW5nQ0Eu
# Y3J0MCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zZWN0aWdvLmNvbTANBgkqhkiG
# 9w0BAQwFAAOCAgEATJtlWPrgec/vFcMybd4zket3WOLrvctKPHXefpRtwyLHBJXf
# ZWlhEwz2DJ71iSBewYfHAyTKx6XwJt/4+DFlDeDrbVFXpoyEUghGHCrC3vLaikXz
# vvf2LsR+7fjtaL96VkjpYeWaOXe8vrqRZIh1/12FFjQn0inL/+0t2v++kwzsbaIN
# zMPxbr0hkRojAFKtl9RieCqEeajXPawhj3DDJHk6l/ENo6NbU9irALpY+zWAT18o
# cWwZXsKDcpCu4MbY8pn76rSSZXwHfDVEHa1YGGti+95sxAqpbNMhRnDcL411TCPC
# QdB6ljvDS93NkiZ0dlw3oJoknk5fTtOPD+UTT1lEZUtDZM9I+GdnuU2/zA2xOjDQ
# oT1IrXpl5Ozf4AHwsypKOazBpPmpfTXQMkCgsRkqGCGyyH0FcRpLJzaq4Jgcg3Xn
# x35LhEPNQ/uQl3YqEqxAwXBbmQpA+oBtlGF7yG65yGdnJFxQjQEg3gf3AdT4LhHN
# nYPl+MolHEQ9J+WwhkcqCxuEdn17aE+Nt/cTtO2gLe5zD9kQup2ZLHzXdR+PEMSU
# 5n4k5ZVKiIwn1oVmHfmuZHaR6Ej+yFUK7SnDH944psAU+zI9+KmDYjbIw74Ahxyr
# +kpCHIkD3PVcfHDZXXhO7p9eIOYJanwrCKNI9RX8BE/fzSEceuX1jhrUuUAxggVT
# MIIFTwIBATBjMEwxEzARBgoJkiaJk/IsZAEZFgNsYW4xFzAVBgoJkiaJk/IsZAEZ
# Fgdkb21za292MRwwGgYDVQQDExNkb21za292LVNSVi1BRENTLUNBAhMnAAAAA6SL
# tsg/tn+7AAAAAAADMAkGBSsOAwIaBQCgeDAYBgorBgEEAYI3AgEMMQowCKACgACh
# AoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAM
# BgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBQ3gcnqrhoQE53LrR5cl2X5maRw
# OjANBgkqhkiG9w0BAQEFAASCAQCCLilZAwp9wNwh0SnExsNHLIHIo0VQbeynJUiO
# T4yoXORT3U9LLVayJISoRlbZxa8vzrwhbGOjKEpAaI4ZzfBpeTq2Skuah1kVBgmL
# DdgyRGhqzHjcQt8BChB591qGpPaON9FFc+UfOqnem4C0nzQ0gIbvcdqbFuEc/y4F
# tsH5OSIz91qsn75M4PMoj8tk7J4whQU3buOTur8B1HLzDfuBtrrmUNN56kAKc5YB
# 7WiSKXf/E3C3WdRF1HIo7cGnbYHXINNPg9wjcjS5RZgTiczYaMYGyBZGuMNa06nF
# SNHvNcwiV3s4AbfYhazeMwNkP2JlMMNof/aH3Hc+mLS26PDkoYIDSzCCA0cGCSqG
# SIb3DQEJBjGCAzgwggM0AgEBMIGRMH0xCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
# cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1Nl
# Y3RpZ28gTGltaXRlZDElMCMGA1UEAxMcU2VjdGlnbyBSU0EgVGltZSBTdGFtcGlu
# ZyBDQQIQOUwl4XygbSeoZeI72R0i1DANBglghkgBZQMEAgIFAKB5MBgGCSqGSIb3
# DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQyNzE5NTIyMFow
# PwYJKoZIhvcNAQkEMTIEMJChD7cSNJusQmxKlhSCaJMkYX0tipuKJW+Sr59197J+
# K7GVFbhh+Tnmtj5Owj9ekTANBgkqhkiG9w0BAQEFAASCAgBm68GjtoMlK8yGMYR2
# vzcQ01Fpm8wvG/vI92Diwdtbkj5ynhGNRps+RutHa9GLqGVGjv7RhCBM7WOhfVGJ
# 2vFBJMQtMdmKXKygpxfLqWSyiCDtQQ+iHAJNMBS2g8uZh5YYJ8McdomrOiObiNSA
# MZ7nD81txAL21iz2Jg8e7yHHoK/m578XqObI1dQxwVsdRf8G1FTibKQ0jpPq++uR
# HC/g24W9v2JKUHGDGA9j/OP9JSul8H1OqNp3HPv9uWl8xufj2A5tOcvM1QKURM//
# pzhcX+pf3nf2v3O/HpKA30zQTB6qzyFfSzKUXXN4Dhf+/RSZOdU9pJvvIigrW6sO
# 2yDnlueQKu0HHKruTK0SdHWu6Pw1CgCfvITcf5xx8kpgZTHG10rSo4+t3bM/A8Vj
# hSZumfS+p0+3K/k84+HB+rwmrpyH0OyJ4p2rpfgTlfndMPnHQVVKbJHdjiebvRGY
# l4pBKnvgzJwsHV7wqcvWrdGKH9P7jms/0Op6sLCskA439qwlfNpyNcaSROMAfwfp
# fLWiD2g6bLCMWFzji6LA5u5oI/MuEQQRJFQZ+cquVtyZ9tvYo4Q30Sgx+tX4MhgS
# wslrAroRgFL6s/CUqQv6qvuZgX1Ig0UiisYrfRrA8ymRD/rYB7pnOJnWExWf+9E5
# 6BRvddsfo0PgLXJ3bkm9bc3NBg==
# SIG # End signature block
