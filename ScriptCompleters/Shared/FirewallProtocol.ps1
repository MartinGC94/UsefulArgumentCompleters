using module .\Classes\CompletionHelper.psm1
using namespace System
using namespace System.Management.Automation

Register-ArgumentCompleter -CommandName @(
    'Find-NetIPsecRule'
    'Get-NetFirewallPortFilter'
    'New-NetFirewallRule'
    'New-NetIPsecRule'
    'Set-NetFirewallPortFilter'
    'Set-NetFirewallRule'
    'Set-NetIPsecRule'
) -ParameterName Protocol -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'
    $KnownProtocols = @(
        @{Name="Any";        Value="Any"}
        @{Name="TCP";        Value="TCP"}
        @{Name="UDP";        Value="UDP"}
        @{Name="ICMPv4";     Value="ICMPv4"}
        @{Name="ICMPv6";     Value="ICMPv6"}
        @{Name="HOPOPT";     Value="0"}
        @{Name="IGMP";       Value="2"}
        @{Name="IPv6";       Value="41"}
        @{Name="IPv6-Route"; Value="43"}
        @{Name="IPv6-Frag";  Value="44"}
        @{Name="GRE";        Value="47"}
        @{Name="IPv6-NoNxt"; Value="59"}
        @{Name="IPv6-Opts";  Value="60"}
        @{Name="VRRP";       Value="112"}
        @{Name="PGM";        Value="113"}
        @{Name="L2TP";       Value="115"}
    )
    foreach ($Protocol in $KnownProtocols)
    {
        if ($Protocol['Name'] -like $WildcardInput)
        {
            [CompletionResult]::new(
                $Protocol['Value'],
                $Protocol['Name'],
                [CompletionResultType]::ParameterValue,
                $Protocol['Value']
            )
        }
    }
}