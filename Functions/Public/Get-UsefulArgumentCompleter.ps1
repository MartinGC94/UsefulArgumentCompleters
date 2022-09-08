using module .\Classes\CompletionHelper.psm1
using namespace System
<#
.SYNOPSIS
    Lists all the argument completers supported by this module.

.PARAMETER CommandName
    Filters the displayed argument completers to the specified commands.

.PARAMETER CommandName
    Filters the displayed argument completers to the specified parameters.
#>
function Get-UsefulArgumentCompleter
{
    Param
    (
        [Parameter()]
        [SupportsWildcards()]
        [ArgumentCompleter({
            param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
            $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)
            $Commands = [CompletionHelper]::GetCachedResults("Import-Csv -Path '$PSScriptRoot\ArgumentCompleters.csv' -Delimiter ','", $false) | Select-Object -ExpandProperty CommandName | Sort-Object -Unique
            foreach ($Item in $Commands)
            {
                if ($Item.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
                {
                    [CompletionHelper]::NewParamCompletionResult($Item)
                }
            }
        })]
        [string[]]
        $CommandName = "*",

        [Parameter()]
        [SupportsWildcards()]
        [ArgumentCompleter({
            param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
            $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)
            $Parameters = [CompletionHelper]::GetCachedResults("Import-Csv -Path '$PSScriptRoot\ArgumentCompleters.csv' -Delimiter ','", $false) | Select-Object -ExpandProperty ParameterName | Sort-Object -Unique
            foreach ($Item in $Parameters)
            {
                if ($Item.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
                {
                    [CompletionHelper]::NewParamCompletionResult($Item)
                }
            }
        })]
        [string[]]
        $ParameterName = "*"
    )
    End
    {
        foreach ($Completer in [CompletionHelper]::GetCachedResults("Import-Csv -Path '$PSScriptRoot\ArgumentCompleters.csv' -Delimiter ','", $false))
        {
            $CommandMatch = $false
            foreach ($Name in $CommandName)
            {
                if ($Completer.CommandName -like $Name)
                {
                    $CommandMatch = $true
                    break
                }
            }

            if (!$CommandMatch)
            {
                continue
            }

            foreach ($Name in $ParameterName)
            {
                if ($Completer.ParameterName -like $Name)
                {
                    $Completer
                    break
                }
            }
        }
    }
}