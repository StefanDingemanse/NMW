#description: Download and install language packs Reference https://docs.microsoft.com/nl-nl/powershell/module/languagepackmanagement/?view=windowsserver2022-ps for more information
#execution mode: Combined
#tags: Custom, Language, Preview
<# 
Notes:
This script installs language packs for AVD/W365 Session hosts and configures the default language for new user profiles

For a complete list of available Language/region tags see: https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/available-language-packs-for-windows?view=windows-11
#>
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
Write-host "The following languages will be installed"
Write-Host "$languagePacks"

# Download and install the language packs
foreach ($language in $languagePacks)
{
Write-Host "Installing $language"
Install-Language $language
Write-Host "Installation of $language language completed"
}

if ($defaultLanguage -eq $null)
{
Write-Host "Default Language not set"
}
else
{
Write-Host "Setting default language to $defaultLanguage"
Set-SystemPreferredUILanguage $defaultLanguage
}
# End Logging
Stop-Transcript
$VerbosePreference=$SaveVerbosePreference
