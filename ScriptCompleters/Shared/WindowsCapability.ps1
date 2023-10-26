using module .\Classes\CompletionHelper.psm1

Register-ArgumentCompleter -CommandName Add-WindowsCapability,Get-WindowsCapability,Remove-WindowsCapability -ParameterName Name -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $FoundFeatures = if ($fakeBoundParameters["Path"])
    {
        [CompletionHelper]::GetCachedResults("Get-WindowsCapability -Path '$($fakeBoundParameters['Path'])'", $true)
    }
    else
    {
        [CompletionHelper]::GetCachedResults('Get-WindowsCapability -Online', $false)
    }
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'
    foreach ($Feature in $FoundFeatures)
    {
        if ($null -eq $Feature)
        {
            continue
        }
        if ($Feature.Name -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($Feature.Name)
        }
    }
}