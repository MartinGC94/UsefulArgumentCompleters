using module .\Classes\CompletionHelper.psm1

Register-ArgumentCompleter -CommandName Enable-WindowsOptionalFeature,Disable-WindowsOptionalFeature,Get-WindowsOptionalFeature -ParameterName FeatureName -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $FoundFeatures = if ($fakeBoundParameters["Path"])
    {
        [CompletionHelper]::GetCachedResults("Get-WindowsOptionalFeature -Path '$($fakeBoundParameters['Path'])'", $true)
    }
    else
    {
        [CompletionHelper]::GetCachedResults('Get-WindowsOptionalFeature -Online', $false)
    }
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)
    foreach ($Feature in $FoundFeatures)
    {
        if ($null -eq $Feature)
        {
            continue
        }
        if ($Feature.FeatureName.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionHelper]::NewParamCompletionResult($Feature.FeatureName)
        }
    }
}