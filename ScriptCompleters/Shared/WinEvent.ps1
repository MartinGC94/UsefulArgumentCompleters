using module .\Classes\CompletionHelper.psm1

$Scriptblock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)

    foreach ($Log in [CompletionHelper]::GetCachedResults('Get-WinEvent -ListLog *', $false))
    {
        if ($null -eq $Log)
        {
            continue
        }
        if ($Log.LogName -like "$TrimmedWord*")
        {
            [CompletionHelper]::NewParamCompletionResult($Log.LogName)
        }
    }
}
Register-ArgumentCompleter -CommandName Get-WinEvent -ParameterName LogName -ScriptBlock $Scriptblock
Register-ArgumentCompleter -CommandName Get-WinEvent -ParameterName ListLog -ScriptBlock $Scriptblock
$Scriptblock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)

    foreach ($Log in [CompletionHelper]::GetCachedResults('Get-WinEvent -ListProvider *', $false))
    {
        if ($null -eq $Log)
        {
            continue
        }
        if ($Log.Name -like "$TrimmedWord*")
        {
            [CompletionHelper]::NewParamCompletionResult($Log.Name)
        }
    }
}
Register-ArgumentCompleter -CommandName Get-WinEvent,New-WinEvent -ParameterName ProviderName -ScriptBlock $Scriptblock
Register-ArgumentCompleter -CommandName Get-WinEvent -ParameterName ListProvider -ScriptBlock $Scriptblock