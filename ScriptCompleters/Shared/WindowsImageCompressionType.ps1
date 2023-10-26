using module .\Classes\CompletionHelper.psm1

Register-ArgumentCompleter -CommandName Export-WindowsImage,New-WindowsImage -ParameterName CompressionType -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'
    foreach ($CompressionType in "None","Fast","Max")
    {
        if ($CompressionType -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($CompressionType)
        }
    }
}