$source = @'
using System;
using System.Security.Principal;
using System.Runtime.InteropServices;

namespace ECGCAT
{
    public class Kernel32
    {
        [DllImport("Kernel32.dll", SetLastError = true)]
        public static extern int GetLastError();
        [DllImport("Kernel32.dll", SetLastError = true)]
        public static extern void CloseHandle(IntPtr existingTokenHandle);

    }

    public class Netapi32
    {

        [System.Runtime.InteropServices.StructLayoutAttribute(System.Runtime.InteropServices.LayoutKind.Sequential)]
        public class NetsetupProvisoningParams
        {

            // Version 1 fields  

            public uint dwVersion;

            [MarshalAs(UnmanagedType.LPWStr)]
            public string lpDomain;

            [MarshalAs(UnmanagedType.LPWStr)]
            public string lpHostName;

            [MarshalAs(UnmanagedType.LPWStr)]
            public string lpMachineAccountOU;

            [MarshalAs(UnmanagedType.LPWStr)]
            public string lpDcName;

            public uint dwProvisionOptions;

            public IntPtr aCertTemplateNames;  // hack until correct MarshalAs setting is figured out  

            public uint cCertTemplateNames;

            //[MarshalAs(UnmanagedType.LPWStr)]  
            //public string[] aMachinePolicyNames;  

            public IntPtr aMachinePolicyNames;  // hack until correct MarshalAs setting is figured out  

            public uint cMachinePolicyNames;

            //[MarshalAs(UnmanagedType.LPWStr)]  
            //public string[] aMachinePolicyPaths;  

            public IntPtr aMachinePolicyPaths;  // hack until correct MarshalAs setting is figured out  

            public uint cMachinePolicyPaths;


            // Version 2 fields  

            [MarshalAs(UnmanagedType.LPWStr)]
            public string lpNetbiosName;

            [MarshalAs(UnmanagedType.LPWStr)]
            public string lpSiteName;

            [MarshalAs(UnmanagedType.LPWStr)]
            public string lpPrimaryDNSDomain;

        }

        [DllImport("Netapi32.dll", EntryPoint = "NetCreateProvisioningPackage", SetLastError = true, ExactSpelling = true, CharSet = CharSet.Unicode)]

        public static extern int NetCreateProvisioningPackage  (

             NetsetupProvisoningParams pProvisioningParams,

             //[MarshalAs(UnmanagedType.LPArray, ArraySubType=UnmanagedType.U1, SizeParamIndex=2)]  

             IntPtr ppPackageBinData,

             IntPtr pdwPackageBinDataSize,

             //[MarshalAs(UnmanagedType.LPWStr)]  

             //working - IntPtr ppPackageText // should be out - not needed for now  
             [MarshalAs(UnmanagedType.LPWStr)]
             out string ppPackageText // should be out - not needed for now  
         );

    }

    public class AdvApi32
    {

        [DllImport("advapi32.DLL", SetLastError = true)]
        public static extern bool LogonUser(string lpszUsername, string lpszDomain, string lpszPassword, int dwLogonType, int dwLogonProvider, out IntPtr phToken);

        [DllImport("advapi32.dll", SetLastError = true)]
        public extern static bool DuplicateToken(IntPtr ExistingTokenHandle, int SECURITY_IMPERSONATION_LEVEL, out IntPtr DuplicateTokenHandle);
        public enum LogonTypes
        {

            /// <summary>
            /// This logon type is intended for users who will be interactively using the computer, such as a user being logged on  
            /// by a terminal server, remote shell, or similar process.
            /// This logon type has the additional expense of caching logon information for disconnected operations; 
            /// therefore, it is inappropriate for some client/server applications,
            /// such as a mail server.
            /// </summary>
            LOGON32_LOGON_INTERACTIVE = 2,

            /// <summary>
            /// This logon type is intended for high performance servers to authenticate plaintext passwords.

            /// The LogonUser function does not cache credentials for this logon type.
            /// </summary>
            LOGON32_LOGON_NETWORK = 3,

            /// <summary>
            /// This logon type is intended for batch servers, where processes may be executing on behalf of a user without 
            /// their direct intervention. This type is also for higher performance servers that process many plaintext
            /// authentication attempts at a time, such as mail or Web servers. 
            /// The LogonUser function does not cache credentials for this logon type.
            /// </summary>
            LOGON32_LOGON_BATCH = 4,

            /// <summary>
            /// Indicates a service-type logon. The account provided must have the service privilege enabled. 
            /// </summary>
            LOGON32_LOGON_SERVICE = 5,

            /// <summary>
            /// This logon type is for GINA DLLs that log on users who will be interactively using the computer. 
            /// This logon type can generate a unique audit record that shows when the workstation was unlocked. 
            /// </summary>
            LOGON32_LOGON_UNLOCK = 7,

            /// <summary>
            /// This logon type preserves the name and password in the authentication package, which allows the server to make 
            /// connections to other network servers while impersonating the client. A server can accept plaintext credentials 
            /// from a client, call LogonUser, verify that the user can access the system across the network, and still 
            /// communicate with other servers.
            /// NOTE: Windows NT:  This value is not supported. 
            /// </summary>
            LOGON32_LOGON_NETWORK_CLEARTEXT = 8,

            /// <summary>
            /// This logon type allows the caller to clone its current token and specify new credentials for outbound connections.
            /// The new logon session has the same local identifier but uses different credentials for other network connections. 
            /// NOTE: This logon type is supported only by the LOGON32_PROVIDER_WINNT50 logon provider.
            /// NOTE: Windows NT:  This value is not supported. 
            /// </summary>
            LOGON32_LOGON_NEW_CREDENTIALS = 9,
        }

        public enum LogonProvider
        {

            /// <summary>
            /// Use the standard logon provider for the system. 
            /// The default security provider is negotiate, unless you pass NULL for the domain name and the user name 
            /// is not in UPN format. In this case, the default provider is NTLM. 
            /// NOTE: Windows 2000/NT:   The default security provider is NTLM.
            /// </summary>
            LOGON32_PROVIDER_DEFAULT = 0,
            LOGON32_PROVIDER_WINNT35 = 1,
            LOGON32_PROVIDER_WINNT40 = 2,
            LOGON32_PROVIDER_WINNT50 = 3
        }

        public enum SecurityImpersonationLevel : int
        {

            /// <summary>
            /// The server process cannot obtain identification information about the client, 
            /// and it cannot impersonate the client. It is defined with no value given, and thus, 
            /// by ANSI C rules, defaults to a value of zero. 
            /// </summary>
            SecurityAnonymous = 0,

            /// <summary>
            /// The server process can obtain information about the client, such as security identifiers and privileges, 
            /// but it cannot impersonate the client. This is useful for servers that export their own objects, 
            /// for example, database products that export tables and views. 
            /// Using the retrieved client-security information, the server can make access-validation decisions without 
            /// being able to use other services that are using the client's security context. 
            /// </summary>
            SecurityIdentification = 1,

            /// <summary>
            /// The server process can impersonate the client's security context on its local system. 
            /// The server cannot impersonate the client on remote systems. 
            /// </summary>
            SecurityImpersonation = 2,

            /// <summary>
            /// The server process can impersonate the client's security context on remote systems. 
            /// NOTE: Windows NT:  This impersonation level is not supported.
            /// </summary>
            SecurityDelegation = 3,
        }

        [DllImport("advapi32.DLL")]
        public static extern bool ImpersonateLoggedOnUser(IntPtr hToken); //handle to token for logged-on user

        [DllImport("advapi32.DLL")]
        public static extern bool RevertToSelf();

        [DllImport("kernel32.dll")]
        public extern static bool CloseHandle(IntPtr hToken);

    }

    public class WinPENanoDomainJoin
    {

        public static string WinPE_DJoin(String machinename, String domain, String username, String password, String ou = null)
        {

            WindowsIdentity winId = WindowsIdentity.GetCurrent();

            //define the handles
            IntPtr existingTokenHandle = IntPtr.Zero;
            IntPtr duplicateTokenHandle = IntPtr.Zero;
          
            try
            {
                //get a security token
                bool isOkay = AdvApi32.LogonUser(username, domain, password,
                    (int)AdvApi32.LogonTypes.LOGON32_LOGON_NEW_CREDENTIALS,
                    (int)AdvApi32.LogonProvider.LOGON32_PROVIDER_WINNT50,
                    out existingTokenHandle);

                if (!isOkay)
                {
                    int lastWin32Error = Marshal.GetLastWin32Error();
                    int lastError = Kernel32.GetLastError();

                    throw new Exception("LogonUser Failed: " + lastWin32Error + " - " + lastError);
                }

                // copy the token
                isOkay = AdvApi32.DuplicateToken(existingTokenHandle,
                    (int)AdvApi32.SecurityImpersonationLevel.SecurityImpersonation,
                    out duplicateTokenHandle);

                if (!isOkay)
                {
                    int lastWin32Error = Marshal.GetLastWin32Error();
                    int lastError = Kernel32.GetLastError();
                    Kernel32.CloseHandle(existingTokenHandle);
                    throw new Exception("DuplicateToken Failed: " + lastWin32Error + " - " + lastError);
                }

                // create an identity from the token
                AdvApi32.ImpersonateLoggedOnUser(duplicateTokenHandle);

                Netapi32.NetsetupProvisoningParams provisioningParams = new Netapi32.NetsetupProvisoningParams();
                provisioningParams.dwVersion = 1;
                provisioningParams.lpDomain = domain;
                provisioningParams.lpHostName = machinename;
                provisioningParams.lpMachineAccountOU = ou;
                provisioningParams.dwProvisionOptions = 2;

                String blob = String.Empty;

                int result = Netapi32.NetCreateProvisioningPackage(provisioningParams, IntPtr.Zero, IntPtr.Zero, out blob);

                WindowsIdentity newId = new WindowsIdentity(duplicateTokenHandle);

                WindowsImpersonationContext impersonatedUser = newId.Impersonate();

                return blob;
            }
            finally
            {
                //free all handles
                if (existingTokenHandle != IntPtr.Zero)
                {
                    Kernel32.CloseHandle(existingTokenHandle);
                }
                if (duplicateTokenHandle != IntPtr.Zero)
                {
                    Kernel32.CloseHandle(duplicateTokenHandle);
                }
            }
        }
    }
}
'@

Add-Type -TypeDefinition $source -Language CSharp |
    Out-Null

$machinename = $args[0]
$domain = $args[1]
$username = $args[2]
$password = $args[3]
$ou = $args[4]
$OSDisk = $args[5]

try {
    $offlinedomainblob = [ECGCAT.WinPENanoDomainJoin]::WinPE_DJoin(
        $machinename,
        $domain,
        $username,
        $password, 
        $ou
    )
} catch {
    throw $_
}

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

try {
    $winpedomainjoinxml = New-Object -TypeName System.Xml.XmlDocument
    $winpedomainjoinxml.LoadXml(
        $winpedomainjoin
    )

    $wrt = New-Object -TypeName System.XML.XMLTextWriter(
        (Join-Path -Path "$env:SystemDrive" -ChildPath "winpedomainjoin.xml"), 
        New-Object -TypeName System.Text.UTF8Encoding(
            $false
        )
    )
    $wrt.Formatting = "Indented"

    $winpedomainjoinxml.Save(
        $wrt
    )

    $wrt.Close()

    $installVolume = $OSDisk -replace ":"

    if (Test-Path (Join-Path -Path $installVolume -ChildPath ":\Windows")) {
        Apply-WindowsUnattend -UnattendPath ( Join-Path -Path "$env:SystemDrive" -ChildPath "winpedomainjoin.xml" ) -Path ( "${installVolume}:\" )
    }
} catch {
    throw $_  
}
