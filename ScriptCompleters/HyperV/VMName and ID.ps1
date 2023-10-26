using module .\Classes\CompletionHelper.psm1
using namespace System.Management.Automation

$ScriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'
    
    $FoundVMs = if ($parameterName -eq "VMName" -or $parameterName -eq "Name")
    {
        Hyper-V\Get-VM -Name $WildcardInput -ErrorAction Ignore
    }
    elseif ($parameterName -eq 'VMId' -or $parameterName -eq 'Id')
    {
        Hyper-V\Get-VM -ErrorAction Ignore | Where-Object -FilterScript {$_.Id.Guid -like $WildcardInput}
    }
    else
    {
        return
    }

    foreach ($VM in $FoundVMs)
    {
        $MatchText = if ($parameterName -eq "Name" -or $parameterName -eq "VMName")
        {
            $VM.Name
        }
        else
        {
            "{$($VM.Id.Guid)}"
        }

        if ($MatchText -like $WildcardInput)
        {
            [CompletionResult]::new(
                [CompletionHelper]::AddQuotesIfNeeded($MatchText),
                $VM.Name,
                [CompletionResultType]::ParameterValue,
                $VM.Name
            )
        }
    }
}
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName VMName -CommandName @(
    'Add-VMAssignableDevice'
    'Add-VMDvdDrive'
    'Add-VMFibreChannelHba'
    'Add-VMGpuPartitionAdapter'
    'Add-VMHardDiskDrive'
    'Add-VMKeyStorageDrive'
    'Add-VMNetworkAdapter'
    'Add-VMNetworkAdapterAcl'
    'Add-VMNetworkAdapterExtendedAcl'
    'Add-VMNetworkAdapterRoutingDomainMapping'
    'Add-VMPmemController'
    'Add-VMRemoteFx3dVideoAdapter'
    'Add-VMScsiController'
    'Add-VMSwitchExtensionPortFeature'
    'Complete-VMFailover'
    'Connect-VMNetworkAdapter'
    'Disable-VMConsoleSupport'
    'Disable-VMIntegrationService'
    'Disable-VMResourceMetering'
    'Disable-VMTPM'
    'Disconnect-VMNetworkAdapter'
    'Enable-VMConsoleSupport'
    'Enable-VMIntegrationService'
    'Enable-VMReplication'
    'Enable-VMResourceMetering'
    'Enable-VMTPM'
    'Enter-PSSession'
    'Export-VMSnapshot'
    'Get-PSSession'
    'Get-VMAssignableDevice'
    'Get-VMBios'
    'Get-VMComPort'
    'Get-VMConnectAccess'
    'Get-VMDvdDrive'
    'Get-VMFibreChannelHba'
    'Get-VMFirmware'
    'Get-VMFloppyDiskDrive'
    'Get-VMGpuPartitionAdapter'
    'Get-VMHardDiskDrive'
    'Get-VMIdeController'
    'Get-VMIntegrationService'
    'Get-VMKeyProtector'
    'Get-VMKeyStorageDrive'
    'Get-VMMemory'
    'Get-VMNetworkAdapter'
    'Get-VMNetworkAdapterAcl'
    'Get-VMNetworkAdapterExtendedAcl'
    'Get-VMNetworkAdapterFailoverConfiguration'
    'Get-VMNetworkAdapterIsolation'
    'Get-VMNetworkAdapterRdma'
    'Get-VMNetworkAdapterRoutingDomainMapping'
    'Get-VMNetworkAdapterTeamMapping'
    'Get-VMNetworkAdapterVlan'
    'Get-VMPmemController'
    'Get-VMProcessor'
    'Get-VMRemoteFx3dVideoAdapter'
    'Get-VMReplication'
    'Get-VMScsiController'
    'Get-VMSecurity'
    'Get-VMSnapshot'
    'Get-VMStorageSettings'
    'Get-VMSwitchExtensionPortData'
    'Get-VMSwitchExtensionPortFeature'
    'Get-VMVideo'
    'Grant-VMConnectAccess'
    'Import-VMInitialReplication'
    'Invoke-Command'
    'Measure-VMReplication'
    'New-PSSession'
    'Remove-PSSession'
    'Remove-VMAssignableDevice'
    'Remove-VMDvdDrive'
    'Remove-VMFibreChannelHba'
    'Remove-VMGpuPartitionAdapter'
    'Remove-VMHardDiskDrive'
    'Remove-VMKeyStorageDrive'
    'Remove-VMNetworkAdapter'
    'Remove-VMNetworkAdapterAcl'
    'Remove-VMNetworkAdapterExtendedAcl'
    'Remove-VMNetworkAdapterRoutingDomainMapping'
    'Remove-VMNetworkAdapterTeamMapping'
    'Remove-VMPmemController'
    'Remove-VMRemoteFx3dVideoAdapter'
    'Remove-VMReplication'
    'Remove-VMSavedState'
    'Remove-VMScsiController'
    'Remove-VMSnapshot'
    'Remove-VMSwitchExtensionPortFeature'
    'Rename-VMNetworkAdapter'
    'Rename-VMSnapshot'
    'Reset-VMReplicationStatistics'
    'Reset-VMResourceMetering'
    'Restore-VMSnapshot'
    'Resume-VMReplication'
    'Revoke-VMConnectAccess'
    'Set-VMBios'
    'Set-VMComPort'
    'Set-VMDvdDrive'
    'Set-VMFibreChannelHba'
    'Set-VMFirmware'
    'Set-VMFloppyDiskDrive'
    'Set-VMGpuPartitionAdapter'
    'Set-VMHardDiskDrive'
    'Set-VMKeyProtector'
    'Set-VMKeyStorageDrive'
    'Set-VMMemory'
    'Set-VMNetworkAdapter'
    'Set-VMNetworkAdapterFailoverConfiguration'
    'Set-VMNetworkAdapterIsolation'
    'Set-VMNetworkAdapterRdma'
    'Set-VMNetworkAdapterRoutingDomainMapping'
    'Set-VMNetworkAdapterTeamMapping'
    'Set-VMNetworkAdapterVlan'
    'Set-VMProcessor'
    'Set-VMRemoteFx3dVideoAdapter'
    'Set-VMReplication'
    'Set-VMSecurity'
    'Set-VMSecurityPolicy'
    'Set-VMStorageSettings'
    'Set-VMSwitchExtensionPortFeature'
    'Set-VMVideo'
    'Start-VMFailover'
    'Start-VMInitialReplication'
    'Stop-VMFailover'
    'Stop-VMInitialReplication'
    'Stop-VMReplication'
    'Suspend-VMReplication'
    'Test-VMNetworkAdapter'
)
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName Name -CommandName @(
    'Checkpoint-VM'
    'Copy-VMFile'
    'Debug-VM'
    'Export-VM'
    'Get-VM'
    'Measure-VM'
    'Move-VMStorage'
    'New-VM'
    'Remove-VM'
    'Rename-VM'
    'Restart-VM'
    'Resume-VM'
    'Save-VM'
    'Set-VM'
    'Start-VM'
    'Stop-VM'
    'Suspend-VM'
    'Update-VMVersion'
    'Wait-VM'
)
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName VMId -CommandName @(
    'Enter-PSSession'
    'Get-PSSession'
    'Get-VHD'
    'Get-VMConnectAccess'
    'Grant-VMConnectAccess'
    'Invoke-Command'
    'New-PSSession'
    'Remove-PSSession'
    'Revoke-VMConnectAccess'
)
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName Id -CommandName Get-VM