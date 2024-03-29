﻿using module .\Classes\CompletionHelper.psm1

$ScriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'
    foreach ($TimeZone in [CompletionHelper]::GetCachedResults('Get-TimeZone -ListAvailable', $false))
    {
        if ($null -eq $TimeZone)
        {
            continue
        }
        $MatchText = if ($parameterName -eq "Name")
        {
            $TimeZone.StandardName
        }
        else
        {
            $TimeZone.Id
        }

        if ($MatchText -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($MatchText, $TimeZone.DisplayName)
        }
    }
}
Register-ArgumentCompleter -CommandName Get-TimeZone,Set-TimeZone -ParameterName Name -ScriptBlock $ScriptBlock
Register-ArgumentCompleter -CommandName Get-TimeZone,Set-TimeZone -ParameterName Id -ScriptBlock $ScriptBlock