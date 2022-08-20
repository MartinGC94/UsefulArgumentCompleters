using module .\Classes\CompletionHelper.psm1

Register-ArgumentCompleter -CommandName Register-ArgumentCompleter -ParameterName ParameterName -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $CommandToFind = $fakeBoundParameters['CommandName']
    if ([string]::IsNullOrEmpty($CommandToFind))
    {
        return
    }
    $CommandInfo = Get-Command -Name $CommandToFind
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)
    foreach ($Key in $CommandInfo.Parameters.Keys)
    {
        if (!$Key.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            continue
        }
        [CompletionHelper]::NewParamCompletionResult($Key)
    }
}