using module .\Classes\CompletionHelper.psm1
using namespace System

$ScriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'

    foreach ($Disk in [CompletionHelper]::GetCachedResults("Get-Disk", $false))
    {
        $MatchText = if ($parameterName -eq "Number" -or $parameterName -eq "DiskNumber")
        {
            [string]$Disk.DiskNumber
        }
        elseif ($parameterName -eq 'UniqueId')
        {
            $Disk.UniqueId
        }
        elseif ($parameterName -eq 'SerialNumber')
        {
            $Disk.SerialNumber
        }
        else
        {
            $Disk.FriendlyName
        }


        if ($MatchText.Length -gt 0 -and $MatchText -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($MatchText, "Number: $($Disk.Number) Model: $($Disk.Model) Location: $($Disk.Location)")
        }
    }
}
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName SerialNumber -CommandName Get-Disk
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName UniqueId -CommandName @(
    'Clear-Disk'
    'Get-Disk'
    'Initialize-Disk'
    'Set-Disk'
    'Update-Disk'
)
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName FriendlyName -CommandName @(
    'Clear-Disk'
    'Get-Disk'
    'Initialize-Disk'
    'Update-Disk'
)
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName Number -CommandName @(
    'Clear-Disk'
    'Get-Disk'
    'Initialize-Disk'
    'Set-Disk'
    'Update-Disk'
)
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName DiskNumber -CommandName @(
    'Add-PartitionAccessPath'
    'Disable-StorageHighAvailability'
    'Enable-StorageHighAvailability'
    'Get-Partition'
    'Get-PartitionSupportedSize'
    'New-Partition'
    'New-Volume'
    'Remove-Partition'
    'Remove-PartitionAccessPath'
    'Resize-Partition'
    'Set-Partition'
)