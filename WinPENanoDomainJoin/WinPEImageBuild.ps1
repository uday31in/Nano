mkdir C:\WinPEImage -ErrorAction:SilentlyContinue
mkdir C:\WinPEImage\mount -ErrorAction:SilentlyContinue

#cd "C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\"

#. copype.cmd x86 C:\WinPEImage

DISM.exe /Mount-Wim /WimFile:"C:\RemoteInstall\Boot\x64\Images\winpe.wim" /index:1 /mountDir:"c:\winpeimage\mount"

#WinPE-WMI
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-WMI.cab"
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-WMI_en-us.cab"

#WinPE-NetFx
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-NetFx.cab"
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-NetFx_en-us.cab"

#WinPE-Scripting
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-Scripting.cab"
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-Scripting_en-us.cab"

#WinPE-PowerShell
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-PowerShell.cab"
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-PowerShell_en-us.cab"

#WinPE-DismCmdlets
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-DismCmdlets.cab"
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-DismCmdlets_en-us.cab"

#WinPE-SecureBootCmdlets
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-SecureBootCmdlets.cab"
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-US\WinPE-SecureBootCmdlets.cab"


#WinPE-StorageWMI
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-StorageWMI.cab"
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-StorageWMI_en-us.cab"

#WinPE-WDS-Tools
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-WDS-Tools.cab"
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-WDS-Tools_en-us.cab"

#WinPE-Setup
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-Setup.cab"
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-Setup_en-us.cab"

#WinPE-Setup-Client
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\WinPE-Setup-Client.cab"
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment\amd64\WinPE_OCs\en-us\WinPE-Setup-Client_en-us.cab"



#WinPE-Setup-Client
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\WinPEImage\WinPE-HTA.cab"
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\WinPEImage\WinPE-HTA_en-us.cab"
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\WinPEImage\WinPE-MDAC.cab"
Dism /Add-Package /Image:"C:\WinPEImage\mount" /PackagePath:"C:\WinPEImage\WinPE-MDAC_en-us.cab"

Dism /Image:"C:\WinPEImage\mount" /Add-Driver /Driver:C:\Plugins\ADSIx64\ADSIx64.inf /forceunsigned


#List installed packages
Dism /Get-Packages /Image:"C:\WinPEImage\mount"


DISM.exe /UnMount-Wim /mountDir:"c:\winpeimage\mount" /commit

DISM.exe /Get-mountedwiminfo
dism.exe /Cleanup-Wim  



DISM.exe /Mount-Wim /WimFile:"C:\RemoteInstall\Boot\x64\Images\winpe.wim" /index:1 /mountDir:"c:\winpeimage\mount"
#notepad C:\WinPEImage\mount\sources\lang.ini
#Notepad C:\WinPEImage\mount\Windows\System32\Winpeshl.ini
#Notepad C:\WinPEImage\mount\boot.cmd

copy C:\WinPEImage\WinPENanoDomainJoin.ps1 C:\WinPEImage\mount\
copy "C:\WinPEImage\WinPEExecuteRemote.ps1" C:\WinPEImage\mount\

DISM.exe /UnMount-Wim /mountDir:"c:\winpeimage\mount" /commit
dism /get-mountedwiminfo 
DISM.exe /UnMount-Wim /mountDir:"c:\winpeimage\mount" /discard
dism.exe /Cleanup-Wim  