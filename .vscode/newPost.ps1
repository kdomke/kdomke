#
# newEntry.ps1
#

#
# This script ensures, that a current journal entry is existing. 
# If it is missing, it gets created.

[CmdletBinding()]
param (
    [Parameter()]
    [String]
    $BasePath = "./_posts",
    [Parameter()]
    [String]
    $DateFormat = "%Y-%m-%d",
    [Parameter()]
    [String]
    $WithTitle = ""
)

$Pattern  = '[^0-9a-zA-ZäöüÄÖÜ_]'
$PostDate = Get-Date -UFormat "%Y-%m-%d %H:%M:%S %Z00"

$CleanTitle = $WithTitle -replace $Pattern,'-'

$FileName = Get-Date -UFormat $DateFormat
$FileName = $FileName + "-" + $CleanTitle + ".md"

$FullPath = (Join-Path -Path $BasePath -ChildPath $FileName)


if (-not(Test-Path -PathType Leaf -Path $FullPath)) {
    $InitialContent  = "---`n"
    $InitialContent += "layout:     post`n"
    $InitialContent += 'title:      "' + $WithTitle + "`"`n"
    $InitialContent += 'date:       ' + $PostDate + "`n"
    $InitialContent += "categories: `n"
    $InitialContent += "tags:       `n"
    $InitialContent += "published:  false`n"
    $InitialContent += "---`n"

    try {
        New-Item -Path $FullPath -Force
        Set-Content -Path $FullPath $InitialContent
    }
    catch{}
}

Code $FullPath


# SIG # Begin signature block
# MIIJbgYJKoZIhvcNAQcCoIIJXzCCCVsCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUA7BC761NkWSHhro+R7T57Ub1
# 8rGgggbSMIIGzjCCBbagAwIBAgITOwAAFlhNXSeJ2Wb40AAAAAAWWDANBgkqhkiG
# 9w0BAQsFADBOMRMwEQYKCZImiZPyLGQBGRYDY29tMRkwFwYKCZImiZPyLGQBGRYJ
# a2ktZ3J1cHBlMRwwGgYDVQQDExNLaXJjaGhlaW0tR3J1cHBlIENBMB4XDTIwMDUy
# NzA3MTcyN1oXDTIyMDUyNzA3MjcyN1owgYsxEzARBgoJkiaJk/IsZAEZFgNjb20x
# GTAXBgoJkiaJk/IsZAEZFglraS1ncnVwcGUxDDAKBgNVBAsTA05ERTEOMAwGA1UE
# CxMFVXNlcnMxDjAMBgNVBAMTBURvbWtlMSswKQYJKoZIhvcNAQkBFhxrcmlzdGlh
# bi5kb21rZUBuYXNzbWFnbmV0LmRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
# CgKCAQEAnZ3OcH+o0uipuKrcGnC7ZF5Kocho+ps/Gvdwfk78mFAbx/4X8p8+duMq
# QOIrIDD8g86jcdaQl6L8IPEYnbPc/qwYtbfcPC+iDKRQnKMzgus2gmwndK+eyAlv
# i8UgEffeu6Xqil+YdYYeWmclc9oHnWNaBfpC0QMyD5lhMKM2bG4p2Kix66szrlM0
# OhhKr8nCpy/ewwe+cDQgPkibfTBDHo8ItGGvapzdQNm4NkGjowoadVGpIybZBdmS
# YlDieo8CfxSjEUTzfWLUGQE/Io/MUCglJAwbHD9xkoRhw/+tQeRdDFZ76VR2p4aB
# Or/5JNfzGqoKpICD1obhNLH6gUXFFQIDAQABo4IDZTCCA2EwPQYJKwYBBAGCNxUH
# BDAwLgYmKwYBBAGCNxUIgtPqZIWl2VXJlTeDvt8AgbOVAIERhqa5IYHTtyICAWQC
# AQMwMwYDVR0lBCwwKgYKKwYBBAGCNwoDBAYIKwYBBQUHAwQGCCsGAQUFBwMDBggr
# BgEFBQcDAjALBgNVHQ8EBAMCBaAwQQYJKwYBBAGCNxUKBDQwMjAMBgorBgEEAYI3
# CgMEMAoGCCsGAQUFBwMEMAoGCCsGAQUFBwMDMAoGCCsGAQUFBwMCMEQGCSqGSIb3
# DQEJDwQ3MDUwDgYIKoZIhvcNAwICAgCAMA4GCCqGSIb3DQMEAgIAgDAHBgUrDgMC
# BzAKBggqhkiG9w0DBzAdBgNVHQ4EFgQUXrwKUfyiTB8U6SZli1wvFTzVKtQwHwYD
# VR0jBBgwFoAUkFnmUWmUJXsBY8RouwFRjfAAiEQwgdAGA1UdHwSByDCBxTCBwqCB
# v6CBvIaBuWxkYXA6Ly8vQ049S2lyY2hoZWltLUdydXBwZSUyMENBLENOPWNhLENO
# PUNEUCxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1D
# b25maWd1cmF0aW9uLERDPWtpLWdydXBwZSxEQz1jb20/Y2VydGlmaWNhdGVSZXZv
# Y2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50
# MIHzBggrBgEFBQcBAQSB5jCB4zCBtgYIKwYBBQUHMAKGgalsZGFwOi8vL0NOPUtp
# cmNoaGVpbS1HcnVwcGUlMjBDQSxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2Vy
# dmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1raS1ncnVwcGUs
# REM9Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1jZXJ0aWZpY2F0
# aW9uQXV0aG9yaXR5MCgGCCsGAQUFBzABhhxodHRwOi8vY2Eua2ktZ3J1cHBlLmNv
# bS9vY3NwMEwGA1UdEQRFMEOgIwYKKwYBBAGCNxQCA6AVDBNEb21rZUBraS1ncnVw
# cGUuY29tgRxrcmlzdGlhbi5kb21rZUBuYXNzbWFnbmV0LmRlMA0GCSqGSIb3DQEB
# CwUAA4IBAQBP4TQozXwpbHs6BmfI5v/3r5vEkJ2yiBUGcvUeFxzps01tcc9sipvk
# Uwl7RhBXZebfcwTDB6Cy1QpCgdML+RDsAN7g4hEwkGv1MBAkfdxPfQmgNrP4UKp4
# k+ABPUe7TwgbtPXPlgD2y/wBkGhLoZ/phE/XDVXtnrVR7ern+bvlzXWEobxlMyGo
# MPgbYAqbPHdu2Xg4Jo/Q9qsPOzQGRG9ulX0SZjLRdQ4UR3SNdx1d0lWggoMXeJHl
# wRt/rS3AVn1X9K/+W/2MNBPpsxvQ0i4FamZL2ZScRYsV64j0evXgE2mUF3WuVkz7
# keM9PWKKI5F7b3ETYrRgUYnER30/HVFMMYICBjCCAgICAQEwZTBOMRMwEQYKCZIm
# iZPyLGQBGRYDY29tMRkwFwYKCZImiZPyLGQBGRYJa2ktZ3J1cHBlMRwwGgYDVQQD
# ExNLaXJjaGhlaW0tR3J1cHBlIENBAhM7AAAWWE1dJ4nZZvjQAAAAABZYMAkGBSsO
# AwIaBQCgeDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEM
# BgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqG
# SIb3DQEJBDEWBBRveEEWwobsCKF1ggyvgwdYQOINcTANBgkqhkiG9w0BAQEFAASC
# AQBjkoOCFhIrhq22HjcCp7k1Y6tPSuozutswfIOVxcnq6DlNflURMxljU0/SbV1K
# AbgxaKvDAwBMsXfUTrIX0iFqWZOEAUX2J6QWml0wumMc9yExzRnBVTGKJ5TNE9MS
# AR1/cU0DlIQKky4AQVRSa743FiyC8vQf1ijQQbK8474dUp8YozMEqIIlz0z3BKeN
# URBy9xfKhKgbjfMWR9WCFZAkYuAibh7L5ftD3Q8AJA71nt0d40Ehpe4SiNtujvbs
# KrhisLwzQfRm3ai5yGrSWZp8XYyldvsxvj2bO59h0MfDIqU47jTuF7Em3gvvIKTJ
# XX5ipW/Urj1fOFZSD47ssmFM
# SIG # End signature block
