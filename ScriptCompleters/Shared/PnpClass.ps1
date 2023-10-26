using module .\Classes\CompletionHelper.psm1

Register-ArgumentCompleter -CommandName Get-PnpDevice -ParameterName Class -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'
    foreach ($Class in [CompletionHelper]::GetCachedResults("Get-PnpDevice | Select-Object -ExpandProperty Class | Sort-Object -Unique", $false))
    {
        if ($null -eq $Class)
        {
            continue
        }
        if ($Class -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($Class)
        }
    }
}