param($ProjectDir, $ConfigurationName, $TargetDir, $TargetFileName)

Write-Host "MyInvocation: " $MyInvocation.MyCommand.Path

Write-Host "ProjectDir: $ProjectDir"
Write-Host "ConfigurationName: $ConfigurationName"
Write-Host "TargetDir: $TargetDir"
Write-Host "TargetFileName: $TargetFileName"

$netcontent  = [IO.File]::ReadAllText( "$ConfigurationName")
Write-Host $netcontent

$source = @'
$source = @'
{0}'@
$result = Add-Type -TypeDefinition $Source -Language CSharp
'@

$content = [String]::Format($source,$netcontent)
$content > $TargetFileName 

$WinPEUnattendXml  = [IO.File]::ReadAllText( "$ProjectDir\WinPEUnattendXml.ps1")
$WinPEUnattendXml >> $TargetFileName 




