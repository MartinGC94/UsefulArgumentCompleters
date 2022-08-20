using module .\Classes\CompletionHelper.psm1

$ScriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)
    foreach ($TimeZone in [CompletionHelper]::GetCachedResults('Get-TimeZone -ListAvailable', $false))
    {
        $MatchText = if ($parameterName -eq "Name")
        {
            $TimeZone.StandardName
        }
        else
        {
            $TimeZone.Id
        }

        if ($MatchText.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionHelper]::NewParamCompletionResult($MatchText, $TimeZone.DisplayName)
        }
    }
}
Register-ArgumentCompleter -CommandName Get-TimeZone -ParameterName Name -ScriptBlock $ScriptBlock
Register-ArgumentCompleter -CommandName Get-TimeZone -ParameterName Id -ScriptBlock $ScriptBlock