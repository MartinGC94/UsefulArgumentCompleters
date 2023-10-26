using module .\Classes\CompletionHelper.psm1
using namespace System

Register-ArgumentCompleter -CommandName Disconnect-VIServer -ParameterName Server -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'

    foreach ($Item in $global:DefaultVIServers.Name)
    {
        if ($Item -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($Item)
        }
    }
}