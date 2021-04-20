﻿

$functionFolders = @('Functions', 'Internal')

# Importing all the Functions required for the module from the subfolders.
ForEach ($folder in $functionFolders) {
    $folderPath = Join-Path -Path $PSScriptRoot -ChildPath $folder
    If (Test-Path -Path $folderPath)
    {
        Write-Verbose -Message "Importing from $folder"
        $functions = Get-ChildItem -Path $folderPath -Recurse -Filter '*.ps1'
        ForEach ($function in $functions)
        {
            Write-Verbose -Message "  Loading $($function.FullName)"
            . ($function.FullName)
        }
    } else {
         Write-Warning "Path $folderPath not found. Some parts of the module will not work."
    }
}


$PSModuleMSAL = Get-Module -Name MSAL.PS
if($PSModuleMSAL){
    Write-Verbose -Message "MSAL.PS PowerShell module is loaded."
} else {
    Write-Warning -Message "MSAL.PS PowerShell module is not loaded, trying to import it."
    Import-Module -Name MSAL.PS -ErrorAction Stop
}

$PSModulePSWriteWord = Get-Module -Name PSWriteWord
if($PSModulePSWriteWord){
    Write-Verbose -Message "PSWriteWord PowerShell module is loaded."
} else {
    Write-Warning -Message "PSWriteWord PowerShell module is not loaded, trying to import it."
    Import-Module -Name PSWriteWord -ErrorAction Stop
}

# Class definition
class DocSection {
    [DocSection[]]$SubSections
    [string]$Title
    [string]$Text
    [object]$Objects
    [bool]$Transpose
}
class Doc {
    [DocSection[]]$SubSections
    [string]$Organization
    [string[]]$Components
    [DateTime]$CreationDate
    [bool]$Translated
}


# SIG # Begin signature block
# MIIZwgYJKoZIhvcNAQcCoIIZszCCGa8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUrVlBFG9PKIBD0gpNLcI2AXDX
# 06igghUDMIID7jCCA1egAwIBAgIQfpPr+3zGTlnqS5p31Ab8OzANBgkqhkiG9w0B
# AQUFADCBizELMAkGA1UEBhMCWkExFTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTEUMBIG
# A1UEBxMLRHVyYmFudmlsbGUxDzANBgNVBAoTBlRoYXd0ZTEdMBsGA1UECxMUVGhh
# d3RlIENlcnRpZmljYXRpb24xHzAdBgNVBAMTFlRoYXd0ZSBUaW1lc3RhbXBpbmcg
# Q0EwHhcNMTIxMjIxMDAwMDAwWhcNMjAxMjMwMjM1OTU5WjBeMQswCQYDVQQGEwJV
# UzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9yYXRpb24xMDAuBgNVBAMTJ1N5bWFu
# dGVjIFRpbWUgU3RhbXBpbmcgU2VydmljZXMgQ0EgLSBHMjCCASIwDQYJKoZIhvcN
# AQEBBQADggEPADCCAQoCggEBALGss0lUS5ccEgrYJXmRIlcqb9y4JsRDc2vCvy5Q
# WvsUwnaOQwElQ7Sh4kX06Ld7w3TMIte0lAAC903tv7S3RCRrzV9FO9FEzkMScxeC
# i2m0K8uZHqxyGyZNcR+xMd37UWECU6aq9UksBXhFpS+JzueZ5/6M4lc/PcaS3Er4
# ezPkeQr78HWIQZz/xQNRmarXbJ+TaYdlKYOFwmAUxMjJOxTawIHwHw103pIiq8r3
# +3R8J+b3Sht/p8OeLa6K6qbmqicWfWH3mHERvOJQoUvlXfrlDqcsn6plINPYlujI
# fKVOSET/GeJEB5IL12iEgF1qeGRFzWBGflTBE3zFefHJwXECAwEAAaOB+jCB9zAd
# BgNVHQ4EFgQUX5r1blzMzHSa1N197z/b7EyALt0wMgYIKwYBBQUHAQEEJjAkMCIG
# CCsGAQUFBzABhhZodHRwOi8vb2NzcC50aGF3dGUuY29tMBIGA1UdEwEB/wQIMAYB
# Af8CAQAwPwYDVR0fBDgwNjA0oDKgMIYuaHR0cDovL2NybC50aGF3dGUuY29tL1Ro
# YXd0ZVRpbWVzdGFtcGluZ0NBLmNybDATBgNVHSUEDDAKBggrBgEFBQcDCDAOBgNV
# HQ8BAf8EBAMCAQYwKAYDVR0RBCEwH6QdMBsxGTAXBgNVBAMTEFRpbWVTdGFtcC0y
# MDQ4LTEwDQYJKoZIhvcNAQEFBQADgYEAAwmbj3nvf1kwqu9otfrjCR27T4IGXTdf
# plKfFo3qHJIJRG71betYfDDo+WmNI3MLEm9Hqa45EfgqsZuwGsOO61mWAK3ODE2y
# 0DGmCFwqevzieh1XTKhlGOl5QGIllm7HxzdqgyEIjkHq3dlXPx13SYcqFgZepjhq
# IhKjURmDfrYwggSjMIIDi6ADAgECAhAOz/Q4yP6/NW4E2GqYGxpQMA0GCSqGSIb3
# DQEBBQUAMF4xCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1hbnRlYyBDb3Jwb3Jh
# dGlvbjEwMC4GA1UEAxMnU3ltYW50ZWMgVGltZSBTdGFtcGluZyBTZXJ2aWNlcyBD
# QSAtIEcyMB4XDTEyMTAxODAwMDAwMFoXDTIwMTIyOTIzNTk1OVowYjELMAkGA1UE
# BhMCVVMxHTAbBgNVBAoTFFN5bWFudGVjIENvcnBvcmF0aW9uMTQwMgYDVQQDEytT
# eW1hbnRlYyBUaW1lIFN0YW1waW5nIFNlcnZpY2VzIFNpZ25lciAtIEc0MIIBIjAN
# BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAomMLOUS4uyOnREm7Dv+h8GEKU5Ow
# mNutLA9KxW7/hjxTVQ8VzgQ/K/2plpbZvmF5C1vJTIZ25eBDSyKV7sIrQ8Gf2Gi0
# jkBP7oU4uRHFI/JkWPAVMm9OV6GuiKQC1yoezUvh3WPVF4kyW7BemVqonShQDhfu
# ltthO0VRHc8SVguSR/yrrvZmPUescHLnkudfzRC5xINklBm9JYDh6NIipdC6Anqh
# d5NbZcPuF3S8QYYq3AhMjJKMkS2ed0QfaNaodHfbDlsyi1aLM73ZY8hJnTrFxeoz
# C9Lxoxv0i77Zs1eLO94Ep3oisiSuLsdwxb5OgyYI+wu9qU+ZCOEQKHKqzQIDAQAB
# o4IBVzCCAVMwDAYDVR0TAQH/BAIwADAWBgNVHSUBAf8EDDAKBggrBgEFBQcDCDAO
# BgNVHQ8BAf8EBAMCB4AwcwYIKwYBBQUHAQEEZzBlMCoGCCsGAQUFBzABhh5odHRw
# Oi8vdHMtb2NzcC53cy5zeW1hbnRlYy5jb20wNwYIKwYBBQUHMAKGK2h0dHA6Ly90
# cy1haWEud3Muc3ltYW50ZWMuY29tL3Rzcy1jYS1nMi5jZXIwPAYDVR0fBDUwMzAx
# oC+gLYYraHR0cDovL3RzLWNybC53cy5zeW1hbnRlYy5jb20vdHNzLWNhLWcyLmNy
# bDAoBgNVHREEITAfpB0wGzEZMBcGA1UEAxMQVGltZVN0YW1wLTIwNDgtMjAdBgNV
# HQ4EFgQURsZpow5KFB7VTNpSYxc/Xja8DeYwHwYDVR0jBBgwFoAUX5r1blzMzHSa
# 1N197z/b7EyALt0wDQYJKoZIhvcNAQEFBQADggEBAHg7tJEqAEzwj2IwN3ijhCcH
# bxiy3iXcoNSUA6qGTiWfmkADHN3O43nLIWgG2rYytG2/9CwmYzPkSWRtDebDZw73
# BaQ1bHyJFsbpst+y6d0gxnEPzZV03LZc3r03H0N45ni1zSgEIKOq8UvEiCmRDoDR
# EfzdXHZuT14ORUZBbg2w6jiasTraCXEQ/Bx5tIB7rGn0/Zy2DBYr8X9bCT2bW+IW
# yhOBbQAuOA2oKY8s4bL0WqkBrxWcLC9JG9siu8P+eJRRw4axgohd8D20UaF5Mysu
# e7ncIAkTcetqGVvP6KUwVyyJST+5z3/Jvz4iaGNTmr1pdKzFHTx/kuDDvBzYBHUw
# ggWtMIIElaADAgECAhAEP0tn9l4Sf9gdog2gb/SWMA0GCSqGSIb3DQEBBQUAMGUx
# CzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3
# dy5kaWdpY2VydC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0IEVWIENvZGUgU2lnbmlu
# ZyBDQTAeFw0yMDAzMDYwMDAwMDBaFw0yMzAzMTUxMjAwMDBaMIHOMRMwEQYLKwYB
# BAGCNzwCAQMTAkNIMRowGAYLKwYBBAGCNzwCAQITCVNvbG90aHVybjEdMBsGA1UE
# DwwUUHJpdmF0ZSBPcmdhbml6YXRpb24xGDAWBgNVBAUTD0NIRS0zMTQuNjM5LjUy
# MzELMAkGA1UEBhMCQ0gxEjAQBgNVBAgTCVNvbG90aHVybjERMA8GA1UEBwwIRMOk
# bmlrZW4xFjAUBgNVBAoTDWJhc2VWSVNJT04gQUcxFjAUBgNVBAMTDWJhc2VWSVNJ
# T04gQUcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCn0xZCT8yT681H
# ZVY8gtUlURKywy8Nfq8uiv/jJJU+/Tf4HHXXJzHo96ZFo/WOWMD3WMWRYRnpj95P
# ZbfLaF+ki/PURRhp9/oT/p5O3zTv4Jqnig7AOeIL5dt9W5Uij9rDOEZhmFpVT08K
# CKhMNMMu7MhBs+uHBlyQ70j5H2IjBjePtEDYcakbv1RNDK5hU+k2UqKZEQSaqt2+
# riewxS2R4RUvZJ5nRraf4pNYqDdem2H0vJ17zHsG+ZB0YFLk/P3i6r4tJEAksYAU
# kuJsFDt0Yz9xM2qmG2Rr4iw7AUTfE5Gx0NNWD/fMWFP/2sD3VkHA8Mz8PAokDfFz
# 21OqYrXPAgMBAAGjggHtMIIB6TAfBgNVHSMEGDAWgBStaQZw/IAbFrOpGJRrlAKG
# XvcnjDAdBgNVHQ4EFgQURdlk/2RkqKDvZs8sol0UhzmJTCowNwYDVR0RBDAwLqAs
# BggrBgEFBQcIA6AgMB4MHENILVNPTE9USFVSTi1DSEUtMzE0LjYzOS41MjMwDgYD
# VR0PAQH/BAQDAgeAMBMGA1UdJQQMMAoGCCsGAQUFBwMDMHMGA1UdHwRsMGowM6Ax
# oC+GLWh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9FVkNvZGVTaWduaW5nLWcxLmNy
# bDAzoDGgL4YtaHR0cDovL2NybDQuZGlnaWNlcnQuY29tL0VWQ29kZVNpZ25pbmct
# ZzEuY3JsMEsGA1UdIAREMEIwNwYJYIZIAYb9bAMCMCowKAYIKwYBBQUHAgEWHGh0
# dHBzOi8vd3d3LmRpZ2ljZXJ0LmNvbS9DUFMwBwYFZ4EMAQMweQYIKwYBBQUHAQEE
# bTBrMCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5kaWdpY2VydC5jb20wQwYIKwYB
# BQUHMAKGN2h0dHA6Ly9jYWNlcnRzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEVWQ29k
# ZVNpZ25pbmdDQS5jcnQwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQUFAAOCAQEA
# GYerL9YA8gW4cx7nWEaDFpN2XnaY4+90Nl8gaj6aeQj6kwIfjWLWAzByDdVNvxSk
# rwXdfo3dkG5DNNI3wPR2SE2iyImDF6zXTThccBqkwE1x1Tb5qfhaA48jf18f8Jbv
# VgvtbZWXph1b+ALyD2911b34Qt6cYmolg19vkmWXZUADRjA11S3VHhhH4GLKeHoE
# 23jSSs69tQPNC1jdS+Rx6yO/Ya14UrDwOrJo1qSn2xTilf9s77mSxRJCpL8Cd1PU
# HPvugUFHLw9nqOQAMUb7cHdDUREs7Brvfcyo0qRx7lyKjIM1d0wGtiBz+8kQJcSC
# dK9S8HGSD3y4R1N++Y8gYTCCBrUwggWdoAMCAQICEA3Q4zdKyVvb+mtDSypI7AYw
# DQYJKoZIhvcNAQEFBQAwbDELMAkGA1UEBhMCVVMxFTATBgNVBAoTDERpZ2lDZXJ0
# IEluYzEZMBcGA1UECxMQd3d3LmRpZ2ljZXJ0LmNvbTErMCkGA1UEAxMiRGlnaUNl
# cnQgSGlnaCBBc3N1cmFuY2UgRVYgUm9vdCBDQTAeFw0xMjA0MTgxMjAwMDBaFw0y
# NzA0MTgxMjAwMDBaMGUxCzAJBgNVBAYTAlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJ
# bmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAiBgNVBAMTG0RpZ2lDZXJ0
# IEVWIENvZGUgU2lnbmluZyBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
# ggEBALkGdBxdtCCqqSGoKkJGqyUgFyXLIo+QoqAxa4MFda+yDnwSSXtqhmSED4Pc
# ZLmxbhYFPhyVuefniG24YoGQedTd9eKW+cO1iCNXShrPcSnpCACPtZjjpzL9rC64
# 9JNT9Ao5Q5Gv1Wvo1J9GvY49q+L5K9TqAEBmJLfof7REdY14mq4xwTfPTh9b+EVK
# 1z/CyZIGZL7eBoqv0OiKsfAsiABvC9yFp0zLBr/WLioybilxr44i8w/Q2JhILagI
# y7aLI8Jj4LZz6299Jk+L9zQ9N4YMt3gn9MKG20NrWvg9PfTosGJWxufteKH7/Xpy
# TzJlxHzDxHegBDIy7Y8/r4bdftECAwEAAaOCA1gwggNUMBIGA1UdEwEB/wQIMAYB
# Af8CAQAwDgYDVR0PAQH/BAQDAgGGMBMGA1UdJQQMMAoGCCsGAQUFBwMDMH8GCCsG
# AQUFBwEBBHMwcTAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29t
# MEkGCCsGAQUFBzAChj1odHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNl
# cnRIaWdoQXNzdXJhbmNlRVZSb290Q0EuY3J0MIGPBgNVHR8EgYcwgYQwQKA+oDyG
# Omh0dHA6Ly9jcmwzLmRpZ2ljZXJ0LmNvbS9EaWdpQ2VydEhpZ2hBc3N1cmFuY2VF
# VlJvb3RDQS5jcmwwQKA+oDyGOmh0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNvbS9EaWdp
# Q2VydEhpZ2hBc3N1cmFuY2VFVlJvb3RDQS5jcmwwggHEBgNVHSAEggG7MIIBtzCC
# AbMGCWCGSAGG/WwDAjCCAaQwOgYIKwYBBQUHAgEWLmh0dHA6Ly93d3cuZGlnaWNl
# cnQuY29tL3NzbC1jcHMtcmVwb3NpdG9yeS5odG0wggFkBggrBgEFBQcCAjCCAVYe
# ggFSAEEAbgB5ACAAdQBzAGUAIABvAGYAIAB0AGgAaQBzACAAQwBlAHIAdABpAGYA
# aQBjAGEAdABlACAAYwBvAG4AcwB0AGkAdAB1AHQAZQBzACAAYQBjAGMAZQBwAHQA
# YQBuAGMAZQAgAG8AZgAgAHQAaABlACAARABpAGcAaQBDAGUAcgB0ACAAQwBQAC8A
# QwBQAFMAIABhAG4AZAAgAHQAaABlACAAUgBlAGwAeQBpAG4AZwAgAFAAYQByAHQA
# eQAgAEEAZwByAGUAZQBtAGUAbgB0ACAAdwBoAGkAYwBoACAAbABpAG0AaQB0ACAA
# bABpAGEAYgBpAGwAaQB0AHkAIABhAG4AZAAgAGEAcgBlACAAaQBuAGMAbwByAHAA
# bwByAGEAdABlAGQAIABoAGUAcgBlAGkAbgAgAGIAeQAgAHIAZQBmAGUAcgBlAG4A
# YwBlAC4wHQYDVR0OBBYEFK1pBnD8gBsWs6kYlGuUAoZe9yeMMB8GA1UdIwQYMBaA
# FLE+w2kD+L9HAdSYJhoIAu9jZCvDMA0GCSqGSIb3DQEBBQUAA4IBAQCeW5Y6LhKI
# rKsBbaSfdeQBh6OlMte8uql+o9YUF/fCE2t8c48rauUPJllosI4lm2zv+myTkgjB
# Tc9FnpxG1h50oZsUo/oBL0qxAeFyQEgRE2i5Np2RS9fCORIQwcTcu2IUFCphXU84
# fGYfxhv/rb5Pf5Rbc0MAD01zt1HPDvZ3wFvNNIzZYxOqDmER1vKOJ/y0e7i5ESCR
# hnjqDtQo/yrVJDjoN7LslrufvEoWUOFev1F9I6Ayx8GUnnrJwCaizCWHoBJ+dJ8t
# jbHI54S+udHp3rtqTohzceEiOMskh+lzflGy/5jrTn4v4MoO+rNe0boFQqhIn4P2
# P8TKqN9ooFBhMYIEKTCCBCUCAQEweTBlMQswCQYDVQQGEwJVUzEVMBMGA1UEChMM
# RGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSQwIgYDVQQD
# ExtEaWdpQ2VydCBFViBDb2RlIFNpZ25pbmcgQ0ECEAQ/S2f2XhJ/2B2iDaBv9JYw
# CQYFKw4DAhoFAKB4MBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZIhvcN
# AQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUw
# IwYJKoZIhvcNAQkEMRYEFPg2H1LaLO4J1JRq2UG1JFwz+XMgMA0GCSqGSIb3DQEB
# AQUABIIBAFmCFx17Hryn2af72FL4Rbu4hsZipZG4mD6zGyaqQuPyYCT4IFIKE433
# gLMbl7drzOKALXmubDat7tF19hpxMi66vbw0nQaMDo2XTZhnJMnSKLnqLjh4ynCK
# VLDHLBVd9KdQfQGBQgJm5O4ZhrYL5qMudt9HuuGuxCnRy3pAP3f6NGGUovGfXDdS
# bkojPmdWx3pnlZ0LSjY6Kma2uVG7dWqEdhtMU8B/4lYaRvJGGHIuKkOFht8525mf
# sOmRMf1W8Ilqh62n5j8xWuwzvePZDWjpBpiatptEF7WAgrvd5oH2rRzw2WDuDL5W
# 8pMKAl45aM5/MeqEOr+Rghr6pilCo3qhggILMIICBwYJKoZIhvcNAQkGMYIB+DCC
# AfQCAQEwcjBeMQswCQYDVQQGEwJVUzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9y
# YXRpb24xMDAuBgNVBAMTJ1N5bWFudGVjIFRpbWUgU3RhbXBpbmcgU2VydmljZXMg
# Q0EgLSBHMgIQDs/0OMj+vzVuBNhqmBsaUDAJBgUrDgMCGgUAoF0wGAYJKoZIhvcN
# AQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjAwNDI2MTE0NTMzWjAj
# BgkqhkiG9w0BCQQxFgQUQ4RqGnbt+JQxUTs1pRkUXcGpS40wDQYJKoZIhvcNAQEB
# BQAEggEAOpyvJKDD3WM8YMP/7S5q8fxmCuB8W0Rr563WuAv4bKvc5aMbska/jK8G
# L3ETTd7QC8hHrrRvBJEou8yEys7UfeZnTVbm/ND7Ms+A14BBSiwMZuT0mUoPu//G
# 9Rxfk5NYRKgjDdXNa8yx/cQD8pkexZpqKzQ7lQQb5YG92ScBddUJfq7r09HM7cD/
# 5AU16Se/E09bfbKcamW3Vv+YRRzXU8bYPk5EQ42OVqhbvmciUeLfhW67obFvIak9
# dvbP/HErGGBzdpcfeC/74NXl5BFrey0blutg/BqhamiTbkjLcn8pdnWSXvlGodFq
# n8bNAofRomWwz3Lq47zteTnVYm0+DQ==
# SIG # End signature block
