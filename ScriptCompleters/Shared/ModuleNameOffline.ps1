using module .\Classes\CompletionHelper.psm1

Register-ArgumentCompleter -CommandName Update-Module,Uninstall-Module -ParameterName Name -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'
    foreach ($Module in [CompletionHelper]::GetCachedResults('Get-Module -ListAvailable | Where-Object -Property RepositorySourceLocation -NE $null | Select-Object -ExpandProperty Name | Sort-Object -Unique', $false))
    {
        if ($null -eq $Module)
        {
            continue
        }
        if ($Module -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($Module)
        }
    }
}