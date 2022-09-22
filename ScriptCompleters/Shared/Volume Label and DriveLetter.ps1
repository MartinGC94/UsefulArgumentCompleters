using module .\Classes\CompletionHelper.psm1
using namespace System

$ScriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)

    $FoundVolumes = if ($parameterName -eq "FileSystemLabel")
    {
        Get-Volume -FileSystemLabel "$TrimmedWord*"
    }
    else
    {
        Get-Volume
    }

    foreach ($Volume in $FoundVolumes)
    {
        $MatchText = if ($parameterName -eq "FileSystemLabel")
        {
            $Volume.FileSystemLabel
        }
        else
        {
            [string]$Volume.DriveLetter
        }

        if ($MatchText.Length -gt 0 -and $MatchText.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionHelper]::NewParamCompletionResult($MatchText, $Volume.FileSystemLabel)
        }
    }
}
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName FileSystemLabel -CommandName @(
    'Debug-Volume'
    'Format-Volume'
    'Get-DedupProperties'
    'Get-SupportedClusterSizes'
    'Get-SupportedFileSystems'
    'Get-Volume'
    'Get-VolumeCorruptionCount'
    'Get-VolumeScrubPolicy'
    'Optimize-Volume'
    'Repair-Volume'
    'Set-Volume'
    'Set-VolumeScrubPolicy'
    'Write-VolumeCache'
)
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName DriveLetter -CommandName @(
    'Debug-Volume'
    'Format-Volume'
    'Get-DedupProperties'
    'Get-Volume'
    'Get-VolumeCorruptionCount'
    'Get-VolumeScrubPolicy'
    'Optimize-Volume'
    'Repair-Volume'
    'Set-Volume'
    'Set-VolumeScrubPolicy'
    'Write-VolumeCache'
    'Clear-RecycleBin'
)