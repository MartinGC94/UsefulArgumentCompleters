using module .\Classes\CompletionHelper.psm1

$ScriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'

    foreach ($SessConfig in [CompletionHelper]::GetCachedResults("Get-PSSessionConfiguration", $false))
    {
        if ($SessConfig.Name -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($SessConfig.Name)
        }
    }
}
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName Name -CommandName "Disable-PSSessionConfiguration", "Enable-PSSessionConfiguration", "Get-PSSessionConfiguration", "Set-PSSessionConfiguration", "Unregister-PSSessionConfiguration"