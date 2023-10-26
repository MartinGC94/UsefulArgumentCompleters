using module .\Classes\CompletionHelper.psm1
using namespace System

Register-ArgumentCompleter -CommandName Get-Command -ParameterName ParameterName -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'

    if ($fakeBoundParameters.ContainsKey('ParameterName'))
    {
        $fakeBoundParameters.Remove('ParameterName')
    }

    if ($fakeBoundParameters.Count -eq 0)
    {
        return
    }

    foreach ($ParameterName in (Get-Command @fakeBoundParameters).Parameters.Keys | Sort-Object -Unique)
    {
        if ($parameterName -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($parameterName)
        }
    }
}

Register-ArgumentCompleter -CommandName Get-Command,Get-Verb -ParameterName Verb -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'

    foreach ($Verb in [CompletionHelper]::GetCachedResults('Get-Verb', $false))
    {
        if ($null -eq $Verb)
        {
            continue
        }
        if ($Verb.Verb -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($Verb.Verb, $Verb.Description)
        }
    }
}

Register-ArgumentCompleter -CommandName Get-Command -ParameterName Noun -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'

    if ($fakeBoundParameters.ContainsKey('Noun'))
    {
        $fakeBoundParameters.Remove('Noun')
    }

    foreach ($Noun in (Get-Command @fakeBoundParameters).Noun | Sort-Object -Unique)
    {
        if ($Noun -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($Noun)
        }
    }
}