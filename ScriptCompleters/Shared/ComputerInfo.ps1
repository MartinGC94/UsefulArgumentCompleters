using module .\Classes\CompletionHelper.psm1

Register-ArgumentCompleter -CommandName Get-ComputerInfo -ParameterName Property -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)

    foreach ($Property in [Microsoft.PowerShell.Commands.ComputerInfo].GetProperties() | Sort-Object -Property Name)
    {
        if ($Property.Name.StartsWith($TrimmedWord, [System.StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionHelper]::NewParamCompletionResult($Property.Name)
        }
    }
}