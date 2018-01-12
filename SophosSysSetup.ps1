#This script reproduces steps found in Sophos Central Endpoint: How to install on a gold image to avoid duplicate identities:
#https://community.sophos.com/kb/en-us/120560

#First Disable Tamper Protection for endpoint

#Optional stop all sophos related services, not in steps
#Get-Service -displayname 'Sophos*' | where {$_.status -eq 'running'} | Stop-Service -force -ErrorAction SilentlyContinue

# Stop Sophos MCS Client service
Stop-Service -Name 'Sophos MCS Client' -ErrorAction SilentlyContinue

# Delete files in C:\ProgramData\Sophos\Management Communications System\Endpoint\Persist
Remove-Item -path 'C:\ProgramData\Sophos\Management Communications System\Endpoint\Persist\*.xml' -Force -ErrorAction SilentlyContinue
Remove-Item -path 'C:\ProgramData\Sophos\Management Communications System\Endpoint\Persist\EndpointIdentity.txt' -Force -ErrorAction SilentlyContinue
Remove-Item -path 'C:\ProgramData\Sophos\Management Communications System\Endpoint\Persist\Credentials' -Force -ErrorAction SilentlyContinue

# Delete C:\ProgramData\Sophos\AutoUpdate\data\machine_ID.txt
Remove-Item -path 'C:\ProgramData\Sophos\AutoUpdate\data\machine_ID.txt' -Force -ErrorAction SilentlyContinue

# Get the MCS token from C:\ProgramData\Sophos\Management Communications System\Endpoint\Config\Config.xml <registrationToken>
$XMLFile = "C:\ProgramData\Sophos\Management Communications System\Endpoint\Config\Config.xml"
$oXMLDocument=New-Object System.XML.XMLDocument  
$oXMLDocument.Load($XMLFile)
$MCSToken = $oXMLDocument.Configuration.McsClient.registrationToken

# edit C:\ProgramData\Sophos\Management Communications System\Endpoint\Config\registration.txt add reg token to Token=
$regtxt = "C:\ProgramData\Sophos\Management Communications System\Endpoint\Config\registration.txt"
$new = "Token=$MCSToken"
(Get-Content $regtxt ).Replace('Token=',$new) | Out-File $regtxt 

# Shutdown Template