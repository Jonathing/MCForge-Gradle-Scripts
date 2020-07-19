# THIS SCRIPT IS COMPLETELY UNUSED! DON'T BOTHER MODIFYING IT!
# It is only kept in the repo in case I need to use this code again at some point.

# $CanRunScripts = 1

# # Check if running Windows PowerShell
# $MyPSVersion = $PSVersionTable.PSVersion.Major
# if ($MyPSVersion -le "5")
# {
#     $MyPWSHExecPolicy = Get-ExecutionPolicy -Scope CurrentUser
#     $CanRunScripts = 0

#     if ($MyPWSHExecPolicy -eq "RemoteSigned") { $CanRunScripts = 1 }
#     if ($MyPWSHExecPolicy -eq "Unrestricted") { $CanRunScripts = 1 }

#     if ($CanRunScripts -eq 0) {
#         $MyPWSHPolicyMsg1 = "Your Windows PowerShell execution policy is currently set to " + $MyPWSHExecPolicy + "."
#         $MyPWSHPolicyMsg2 = "Although you were able to run this script by right-clicking and clicking on " + [char]0x0022 + "Run with PowerShell" + [char]0x0022 + ","
#         $MyPWSHPolicyMsg3 = "this PowerShell script will not be able to get your mod's name since it uses another PowerShell script to get it."
#         $MyPWSHPolicyMsg4 = "We can run a batch script that requests admin perms and then sets the policy to RemoteSigned for you."

#         Write-Host $MyPWSHPolicyMsg1
#         Write-Host $MyPWSHPolicyMsg2
#         Write-Host $MyPWSHPolicyMsg3
#         Write-Host $MyPWSHPolicyMsg4

#         Write-Host "Would you like to do this now? [y/N] " -ForegroundColor Yellow -NoNewline
#         $Readhost = Read-Host 
#         Switch ($ReadHost)
#         { 
#             Y { $DoChangePolicy=1 }
#             N { $DoChangePolicy=0 }
#             Default { $DoChangePolicy=0 }
#         }

#         if ($DoChangePolicy -eq 1) {
#             cmd.exe /C '.\Scripts\Windows cmd Scripts\internal\set_execpolicy.bat'
#             Start-Sleep -Seconds 1

#             $MyPWSHExecPolicy = Get-ExecutionPolicy -Scope CurrentUser
#             if ($MyPWSHExecPolicy -eq "RemoteSigned") { $CanRunScripts = 1 }
#             if ($MyPWSHExecPolicy -eq "Unrestricted") { $CanRunScripts = 1 }

#             if ($CanRunScripts -eq 1) {
#                 $MyPWSHSuccessMsg1 = "Your Windows PowerShell execution policy was changed successfully."
#                 $MyPWSHSuccessMsg2 = "MCGradle Scripts will now be able to get your mod's name from mods.toml."
#                 $MyPWSHSuccessMsg3 = "The PowerShell Script will now run as normal."

#                 Write-Host $MyPWSHSuccessMsg1
#                 Write-Host $MyPWSHSuccessMsg2
#                 Write-Host $MyPWSHSuccessMsg3
#             }
#             else {
#                 $MyPWSHFailMsg1 = "Windows PowerShell failed to set the execution policy to RemoteSigned."
#                 $MyPWSHFailMsg2 = "The PowerShell Script will now run as normal."

#                 Write-Host $MyPWSHFailMsg1
#                 Write-Host $MyPWSHFailMsg2
#             }
#         }
#         else {
#             $MyPWSHCancelMsg1 = "You have chosen not to change your Windows PowerShell execution policy."
#             $MyPWSHCancelMsg2 = "The PowerShell Script will now run as normal."

#             Write-Host $MyPWSHCancelMsg1
#             Write-Host $MyPWSHCancelMsg2
#         }
#     }
# }

# Write-Host ""
# Write-Host $CanRunScripts

# Pause