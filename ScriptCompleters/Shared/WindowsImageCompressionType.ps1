using module .\Classes\CompletionHelper.psm1

Register-ArgumentCompleter -CommandName Export-WindowsImage,New-WindowsImage -ParameterName CompressionType -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)
    foreach ($CompressionType in "None","Fast","Max")
    {
        if ($CompressionType.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionHelper]::NewParamCompletionResult($CompressionType)
        }
    }
}