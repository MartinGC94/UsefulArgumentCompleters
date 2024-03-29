﻿using module .\Classes\CompletionHelper.psm1

$ScriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'
    foreach ($User in Get-LocalUser)
    {
        $MatchText = if ($parameterName -eq "Name")
        {
            $User.Name
        }
        else
        {
            $User.SID
        }

        if ($MatchText -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($MatchText, "$($User.Name) $($User.FullName)")
        }
    }
}
Register-ArgumentCompleter -CommandName Get-LocalUser,Set-LocalUser,Enable-LocalUser,Disable-LocalUser,Remove-LocalUser,Rename-LocalUser -ParameterName Name -ScriptBlock $ScriptBlock
Register-ArgumentCompleter -CommandName Get-LocalUser,Set-LocalUser,Enable-LocalUser,Disable-LocalUser,Remove-LocalUser,Rename-LocalUser -ParameterName SID -ScriptBlock $ScriptBlock