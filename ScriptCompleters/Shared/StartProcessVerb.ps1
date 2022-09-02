using module .\Classes\CompletionHelper.psm1
using namespace System
using namespace System.Management.Automation

Register-ArgumentCompleter -CommandName Start-Process -ParameterName Verb -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)

    $FilePath = $fakeBoundParameters['FilePath']
    if ([string]::IsNullOrWhiteSpace($FilePath))
    {
        return
    }

    $Executable = [CompletionHelper]::GetCachedResults("Get-Command -Name '$FilePath' -CommandType Application -ErrorAction Ignore", $true)
    if ($null -eq $Executable)
    {
        return
    }

    $CommandInfo = [CompletionHelper]::GetCachedResults("[System.Diagnostics.ProcessStartInfo]::new('A$($Executable.Extension)')", $false)

    foreach ($Verb in $CommandInfo.Verbs)
    {
        if ($Verb.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionHelper]::NewParamCompletionResult($Verb)
        }
    }
}