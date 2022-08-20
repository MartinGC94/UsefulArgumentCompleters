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
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)
    foreach ($Feature in $FoundFeatures)
    {
        if ($Feature.Name.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionHelper]::NewParamCompletionResult($Feature.Name)
        }
    }
}