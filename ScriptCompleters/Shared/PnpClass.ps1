using module .\Classes\CompletionHelper.psm1

Register-ArgumentCompleter -CommandName Get-PnpDevice -ParameterName Class -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)
    foreach ($Class in [CompletionHelper]::GetCachedResults("Get-PnpDevice | Select-Object -ExpandProperty Class | Sort-Object -Unique", $false))
    {
        if ($Class.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionHelper]::NewParamCompletionResult($Class)
        }
    }
}