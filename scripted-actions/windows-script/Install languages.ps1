<#
.SYNOPSIS
Script to install and configure Language Packs via Install-Language

.DESCRIPTION
This script will use the new cmdlets for installing and configuring language packs See https://docs.microsoft.com/nl-nl/powershell/module/languagepackmanagement/?view=windowsserver2022-ps for more information. For this script to work you need at least Wind

.PARAMETER languagePack
This is the language code for the language(s) you want to install

.PARAMETER defaultLanguage
This is the language code for the default language you want to configure

.DOCS
Available languages: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/available-language-packs-for-windows?view=windows-11
New PowerShell cmdlets: https://docs.microsoft.com/nl-nl/powershell/module/languagepackmanagement/?view=windowsserver2022-ps

.LINK
https://github.com/StefanDingemanse/NMW/edit/main/scripted-actions/windows-script/Install%20languages.ps1
$>

# Customize the following variables
$languagePacks="en-US","nl-NL"
$defaultLanguage="nl-NL"

# Start powershell logging
$SaveVerbosePreference = $VerbosePreference
$VerbosePreference = 'continue'
$VMTime = Get-Date
$LogTime = $VMTime.ToUniversalTime()
Start-Transcript -Path "C:\Windows\temp\NMWLogs\ScriptedActions\languages\ps_log.txt" -Append
Write-Host "################# New Script Run #################"
Write-host "Current time (UTC-0): $LogTime"
Write-host "The following language packs will be installed"
Write-Host "$languagePacks"

#Disable Language Pack Cleanup (do not re-enable)
Disable-ScheduledTask -TaskPath "\Microsoft\Windows\AppxDeploymentClient\" -TaskName "Pre-staged app cleanup" | Out-Null

# Download and install the Language Packs
foreach ($language in $languagePacks)
{
Write-Host "Installing Language Pack for: $language"
Install-Language $language
Write-Host "Installing Language Pack for: $language completed."
}

if ($defaultLanguage -eq $null)
{
Write-Host "Default Language not configured."
}
else
{
Write-Host "Setting default Language to: $defaultLanguage"
Set-SystemPreferredUILanguage $defaultLanguage
}

# End Logging
Stop-Transcript
$VerbosePreference=$SaveVerbosePreference
