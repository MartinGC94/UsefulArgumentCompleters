using module .\Classes\CompletionHelper.psm1
using namespace System

Register-ArgumentCompleter -CommandName @(
    'Copy-NetFirewallRule'
    'Copy-NetIPsecMainModeCryptoSet'
    'Copy-NetIPsecMainModeRule'
    'Copy-NetIPsecPhase1AuthSet'
    'Copy-NetIPsecPhase2AuthSet'
    'Copy-NetIPsecQuickModeCryptoSet'
    'Copy-NetIPsecRule'
    'Disable-NetFirewallRule'
    'Disable-NetIPsecMainModeRule'
    'Disable-NetIPsecRule'
    'Enable-NetFirewallRule'
    'Enable-NetIPsecMainModeRule'
    'Enable-NetIPsecRule'
    'Get-NetFirewallAddressFilter'
    'Get-NetFirewallApplicationFilter'
    'Get-NetFirewallDynamicKeywordAddress'
    'Get-NetFirewallInterfaceFilter'
    'Get-NetFirewallInterfaceTypeFilter'
    'Get-NetFirewallPortFilter'
    'Get-NetFirewallProfile'
    'Get-NetFirewallRule'
    'Get-NetFirewallSecurityFilter'
    'Get-NetFirewallServiceFilter'
    'Get-NetFirewallSetting'
    'Get-NetIPsecMainModeCryptoSet'
    'Get-NetIPsecMainModeRule'
    'Get-NetIPsecPhase1AuthSet'
    'Get-NetIPsecPhase2AuthSet'
    'Get-NetIPsecQuickModeCryptoSet'
    'Get-NetIPsecRule'
    'New-NetFirewallRule'
    'New-NetIPsecMainModeCryptoSet'
    'New-NetIPsecMainModeRule'
    'New-NetIPsecPhase1AuthSet'
    'New-NetIPsecPhase2AuthSet'
    'New-NetIPsecQuickModeCryptoSet'
    'New-NetIPsecRule'
    'Open-NetGPO'
    'Remove-NetFirewallDynamicKeywordAddress'
    'Remove-NetFirewallRule'
    'Remove-NetIPsecMainModeCryptoSet'
    'Remove-NetIPsecMainModeRule'
    'Remove-NetIPsecPhase1AuthSet'
    'Remove-NetIPsecPhase2AuthSet'
    'Remove-NetIPsecQuickModeCryptoSet'
    'Remove-NetIPsecRule'
    'Rename-NetFirewallRule'
    'Rename-NetIPsecMainModeCryptoSet'
    'Rename-NetIPsecMainModeRule'
    'Rename-NetIPsecPhase1AuthSet'
    'Rename-NetIPsecPhase2AuthSet'
    'Rename-NetIPsecQuickModeCryptoSet'
    'Rename-NetIPsecRule'
    'Set-NetFirewallAddressFilter'
    'Set-NetFirewallApplicationFilter'
    'Set-NetFirewallInterfaceFilter'
    'Set-NetFirewallInterfaceTypeFilter'
    'Set-NetFirewallPortFilter'
    'Set-NetFirewallProfile'
    'Set-NetFirewallRule'
    'Set-NetFirewallSecurityFilter'
    'Set-NetFirewallServiceFilter'
    'Set-NetFirewallSetting'
    'Set-NetIPsecMainModeCryptoSet'
    'Set-NetIPsecMainModeRule'
    'Set-NetIPsecPhase1AuthSet'
    'Set-NetIPsecPhase2AuthSet'
    'Set-NetIPsecQuickModeCryptoSet'
    'Set-NetIPsecRule'
    'Show-NetFirewallRule'
    'Show-NetIPsecRule'
    'Sync-NetIPsecRule'
    'Update-NetIPsecRule'
    'Get-DAPolicyChange'
) -ParameterName PolicyStore -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)

    $ValidValues = @(
        if ($commandName -ne "Open-NetGPO")
        {
            'PersistentStore'
            'ActiveStore'
            'RSOP'
            'SystemDefaults'
            'StaticServiceStore'
            'ConfigurableServiceStore'
        }
        [CompletionHelper]::GetCachedResults('Get-GPO -All', $false)
    )
    foreach ($PolicyStore in $ValidValues)
    {
        if ($null -eq $PolicyStore)
        {
            continue
        }
        $PolicyStoreName = if ($PolicyStore -is [string])
        {
            $PolicyStore
        }
        else
        {
            "$($PolicyStore.DomainName)\$($PolicyStore.DisplayName)"
        }
        
        if ($PolicyStoreName.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionHelper]::NewParamCompletionResult($PolicyStoreName)
        }
    }
}