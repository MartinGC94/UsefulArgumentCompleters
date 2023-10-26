using module .\Classes\CompletionHelper.psm1

Register-ArgumentCompleter -CommandName Get-ComputerInfo -ParameterName Property -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'

    foreach ($Property in [Microsoft.PowerShell.Commands.ComputerInfo].GetProperties() | Sort-Object -Property Name)
    {
        if ($Property.Name -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($Property.Name)
        }
    }
}