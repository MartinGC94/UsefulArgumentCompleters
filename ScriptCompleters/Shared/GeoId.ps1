using module .\Classes\CompletionHelper.psm1
using namespace System
using namespace System.Management.Automation

Register-ArgumentCompleter -CommandName Set-WinHomeLocation -ParameterName GeoId -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)

    $AllRegions = [CompletionHelper]::GetCachedResults(@'
foreach ($Culture in [cultureinfo]::GetCultures([System.Globalization.CultureTypes]::AllCultures))
{
    if ($Culture.IsNeutralCulture -or $Culture.Name -eq "")
    {
        continue
    }
    [System.Globalization.RegionInfo]::new($Culture.Name)
}
'@, $false)

    foreach ($RegionInfo in $AllRegions)
    {
        if ($null -eq $RegionInfo)
        {
            continue
        }

        if ($RegionInfo.EnglishName.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionResult]::new(
                $RegionInfo.GeoId,
                $RegionInfo.EnglishName,
                [CompletionResultType]::ParameterValue,
                $RegionInfo.EnglishName
            )
        }
    }
}