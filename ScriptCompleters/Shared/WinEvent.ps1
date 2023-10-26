using module .\Classes\CompletionHelper.psm1

$Scriptblock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'

    foreach ($Log in [CompletionHelper]::GetCachedResults('Get-WinEvent -ListLog *', $false))
    {
        if ($null -eq $Log)
        {
            continue
        }
        if ($Log.LogName -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($Log.LogName)
        }
    }
}
Register-ArgumentCompleter -CommandName Get-WinEvent -ParameterName LogName -ScriptBlock $Scriptblock
Register-ArgumentCompleter -CommandName Get-WinEvent -ParameterName ListLog -ScriptBlock $Scriptblock
$Scriptblock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'

    foreach ($Log in [CompletionHelper]::GetCachedResults('Get-WinEvent -ListProvider *', $false))
    {
        if ($null -eq $Log)
        {
            continue
        }
        if ($Log.Name -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($Log.Name)
        }
    }
}
Register-ArgumentCompleter -CommandName Get-WinEvent,New-WinEvent -ParameterName ProviderName -ScriptBlock $Scriptblock
Register-ArgumentCompleter -CommandName Get-WinEvent -ParameterName ListProvider -ScriptBlock $Scriptblock