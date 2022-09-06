using module .\Classes\CompletionHelper.psm1
using namespace System
using namespace System.Management.Automation

Register-ArgumentCompleter -CommandName Test-NetConnection -ParameterName Port -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)
    $KnownPorts = @(
        @{Name="FTPData"                ;Value="20"   ;ToolTip='TCP Port 20. FTP (File Transfer Protocol) data transfer.'}
        @{Name="FTPControl"             ;Value="21"   ;ToolTip='TCP Port 21. FTP (File Transfer Protocol) control.'}
        @{Name="SSH"                    ;Value="22"   ;ToolTip='TCP port 22. SSH (Secure Shell).'}
        @{Name="SCP"                    ;Value="22"   ;ToolTip='TCP port 22. SCP (Secure Copy).'} #Obviously it's the same as SSH, but it's more convenient to have multiple text options.
        @{Name="SFTP_SSH"               ;Value="22"   ;ToolTip='TCP port 22. SFTP (SSH File Transfer Protocol).'}
        @{Name="Telnet"                 ;Value="23"   ;ToolTip='TCP port 23. Telnet.'}
        @{Name="SMTP"                   ;Value="25"   ;ToolTip='TCP port 25. SMTP (Simple Mail Transfer Protocol).'}
        @{Name="DNS"                    ;Value="53"   ;ToolTip='TCP and UDP port 53. DNS (Domain Name System)'}
        @{Name="HTTP"                   ;Value="80"   ;ToolTip='TCP and UDP port 80. HTTP (Hypertext Transfer Protocol)'}
        @{Name="Kerberos"               ;Value="88"   ;ToolTip='TCP and UDP port 88. Kerberos authentication.'}
        @{Name="SFTP"                   ;Value="115"  ;ToolTip='TCP port 115. SFTP (Simple File Transfer Protocol)'}
        @{Name="RPCEPMap"               ;Value="135"  ;ToolTip='TCP Port 135. RPC Endpoint mapper.'}
        @{Name="NetBiosNameService"     ;Value="137"  ;ToolTip='TCP and UDP port 137. Netbios name registration and resolution.'}
        @{Name="NetBiosSessionService"  ;Value="139"  ;ToolTip='TCP port 139. Netbios session service.'}
        @{Name="IMAP"                   ;Value="143"  ;ToolTip='TCP port 143. IMAP (Internet Message Access Protocol).'}
        @{Name="SNMPTrap"               ;Value="162"  ;ToolTip='TCP and UDP port 162. SNMP (Simple Network Management Protocol) trap'}
        @{Name="LDAP"                   ;Value="389"  ;ToolTip='TCP port 389. LDAP (Lightweight Directory Access Protocol)'}
        @{Name="HTTPS"                  ;Value="443"  ;ToolTip='TCP and UDP port 443. HTTPS (Hypertext Transfer Protocol Secure)'}
        @{Name="SMB"                    ;Value="445"  ;ToolTip='TCP and UDP port 445. SMB (Server Message Block)'}
        @{Name="KerberosSetPassword"    ;Value="464"  ;ToolTip='TCP and UDP port 464. Kerberos update password.'}
        @{Name="LDAPS"                  ;Value="636"  ;ToolTip='TCP port 636. LDAPS (Lightweight Directory Access Protocol over TLS/SSL)'}
        @{Name="IMAPS"                  ;Value="993"  ;ToolTip='TCP port 993. IMAPS (Internet Message Access Protocol over TLS/SSL)'}
        @{Name="MSSQL"                  ;Value="1433" ;ToolTip='TCP and UDP port 1433. Default instance MS SQL server port.'}
        @{Name="KMS"                    ;Value="1688" ;ToolTip='TCP port 1688. Default KMS (Key management service) port.'}
        @{Name="LDAPGC"                 ;Value="3268" ;ToolTip='TCP and UDP port 3268. LDAP global catalog.'}
        @{Name="LDAPSGC"                ;Value="3269" ;ToolTip='TCP and UDP port 3269. LDAPS global catalog.'}
        @{Name="RDP"                    ;Value="3389" ;ToolTip='TCP and UDP port 3389. Default RDP port.'}
        @{Name="WinRM"                  ;Value="5985" ;ToolTip='TCP port 5985. Default WinRM port.'}
        @{Name="WinRMHttps"             ;Value="5986" ;ToolTip='TCP port 5986. Default WinRM HTTPs port.'}
    )
    foreach ($Port in $KnownPorts)
    {
        if ($Port['Name'].StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionResult]::new(
                $Port['Value'],
                $Port['Name'],
                [CompletionResultType]::ParameterValue,
                $Port['ToolTip']
            )
        }
    }
}