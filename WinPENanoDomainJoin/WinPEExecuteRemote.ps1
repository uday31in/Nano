param (
    [string]$path = "\\contosodc\share"

)


Write-Host "Mapping $path"

$filename = "x:\sources\wdsunattend\wdsunattend.xml"
Write-host "Reading Domain Join Information from $filename"
[xml] $xml = Get-Content $filename

$offlineUnattendedJoin = (($xml.unattend.settings | Where-Object {$_.pass -eq "specialize"}).component | Where-Object {$_.name -eq "Microsoft-Windows-UnattendedJoin"})

$user = $offlineUnattendedJoin.Identification.Credentials.Username
$domain = $offlineUnattendedJoin.Identification.Credentials.Domain
$password = $offlineUnattendedJoin.Identification.Credentials.Password

$credential = new-object -typename System.Management.Automation.PSCredential -argumentlist "$domain\$user", (ConvertTo-SecureString $password -AsPlainText -Force)

New-PSDrive -PSProvider FileSystem -Credential $credential -Name "Z" -Root "$path" -Persist -Scope Global

. z:\WinPERemoteScript.ps1