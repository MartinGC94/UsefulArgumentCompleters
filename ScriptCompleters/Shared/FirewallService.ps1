using module .\Classes\CompletionHelper.psm1
using namespace System

Register-ArgumentCompleter -CommandName @(
    'Get-NetFirewallServiceFilter'
    'New-NetFirewallRule'
    'Set-NetFirewallRule'
    'Set-NetFirewallServiceFilter'
) -ParameterName Service -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)
    
    if ("Any".StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
    {
        [CompletionHelper]::NewParamCompletionResult("Any")
    }
    foreach ($Service in [CompletionHelper]::GetCachedResults('Get-Service', $false))
    {
        if ($null -eq $Service)
        {
            continue
        }
        if ($Service.Name.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionHelper]::NewParamCompletionResult($Service.Name, $Service.DisplayName)
        }
    }
}