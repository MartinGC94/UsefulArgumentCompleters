using module .\Classes\CompletionHelper.psm1
using namespace System
using namespace System.Management.Automation

Register-ArgumentCompleter -CommandName Get-NetTCPConnection -ParameterName OwningProcess -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'

    foreach ($Process in Get-Process -Name $WildcardInput)
    {
        $ListItem = "$($Process.Name) $($Process.Id)"
        if ($ListItem -like $WildcardInput)
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