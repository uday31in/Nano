
#Region Reading Credential for Domain Join

#$filename = "C:\RemoteInstall\WdsClientUnattend\Gen2NoCredential.xml"
$filename = "x:\sources\wdsunattend\wdsunattend.xml"
Write-host "Reading Domain Join Information from $filename"

$xml = New-Object -TypeName System.Xml.XmlDocument
$xml.Load($filename)

$offlineUnattendedJoin = (($xml.unattend.settings | Where-Object {$_.pass -eq "specialize"}).component | Where-Object {$_.name -eq "Microsoft-Windows-UnattendedJoin"})

if($offlineUnattendedJoin -ne $null)
{

    Write-Host "Using Cashed Credential from $filename"

    $offlineUnattendedJoin.Identification

    $user = $offlineUnattendedJoin.Identification.Credentials.Username
    $domain = $offlineUnattendedJoin.Identification.Credentials.Domain
    $password = $offlineUnattendedJoin.Identification.Credentials.Password


}
else
{
    Write-Host "No Credentials Found in $filename"
    $credential = Get-Credential -Message "Enter Domain Credentials To Domain Join" 

    $user = $credential.GetNetworkCredential().username 
    $domain = $credential.GetNetworkCredential().Domain 
    $password = $credential.GetNetworkCredential().password

    
}


$shellsetup = (($xml.unattend.settings | Where-Object {$_.pass -eq "specialize"}).component | Where-Object {$_.name -eq "Microsoft-Windows-Shell-Setup"})

if($shellsetup -ne $null)
{
    $machinename = $shellsetup.ComputerName
    Write-Host "Using ComputerName: $machinename"

}
else
{
    Write-Host "No ComputerName Found in $filename"
    $machinename = Read-Host "Domain Computername"
}


$offlinedomainblob = [ECGCAT.WinPENanoDomainJoin]::WinPE_DJoin( $user,$domain,$password , $machinename)

Write-Host "Domain Blob Created Successfully: $offlinedomainblob"

[string]$winpedomainjoin = @"
<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
    <settings pass="offlineServicing">
        <component name="Microsoft-Windows-UnattendedJoin" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <OfflineIdentification>
                <Provisioning>
                    <AccountData>$offlinedomainblob</AccountData>
                </Provisioning>
            </OfflineIdentification>
        </component>
    </settings>
</unattend>
"@ 



$winpedomainjoinxml = New-Object -TypeName System.Xml.XmlDocument
$winpedomainjoinxml.LoadXml($winpedomainjoin)

$enc = New-Object System.Text.UTF8Encoding( $false )
$wrt = New-Object System.XML.XMLTextWriter((join-path -path "$env:SystemDrive" -ChildPath "winpedomainjoin.xml"), $enc )
$wrt.Formatting = 'Indented'
$winpedomainjoinxml.Save($wrt)
$wrt.close()

Write-Host "WinPE Domain Join Unattend File Created Successfully at " (join-path -path "$env:SystemDrive" -ChildPath "winpedomainjoin.xml")

Write-Host "Applying Unattend File"

$InstallVolume = (get-volume |? {$_.FileSystem -eq 'NTFS'} | sort-object SizeRemaining -Descending | select -First 1).DriveLetter

Write-Host "Applying Unattend File at " ("$InstallVolume" + ":\") 

Apply-WindowsUnattend -UnattendPath (join-path -path "$env:SystemDrive" -ChildPath "winpedomainjoin.xml") -Path ("$InstallVolume" + ":\")

Write-Host "Applying Unattend File - Success! Go Nano!"

#Start-Sleep -s 300

Write-Host "Setup Complete!"