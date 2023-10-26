using module .\Classes\CompletionHelper.psm1

Register-ArgumentCompleter -CommandName Get-AppxPackage -ParameterName Publisher -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'

    foreach ($Publisher in [CompletionHelper]::GetCachedResults('Get-AppxPackage | Select-Object -ExpandProperty Publisher | Sort-Object -Unique', $false))
    {
        if ($null -eq $Publisher)
        {
            continue
        }

        if ($Publisher -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($Publisher)
        }
    }
}