using module .\Classes\CompletionHelper.psm1
using namespace System
using namespace System.Management.Automation

Register-ArgumentCompleter -CommandName Get-NetTCPConnection -ParameterName OwningProcess -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)

    foreach ($Process in Get-Process -Name "$TrimmedWord*")
    {
        $ListItem = "$($Process.Name) $($Process.Id)"
        if ($ListItem.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionResult]::new(
                $Process.Id,
                $ListItem,
                [CompletionResultType]::ParameterValue,
                $ListItem
            )
        }
    }
}