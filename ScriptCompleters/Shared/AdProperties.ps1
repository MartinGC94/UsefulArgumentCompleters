﻿using module .\Classes\CompletionHelper.psm1
using namespace System

Register-ArgumentCompleter -CommandName Get-ADUser,Get-ADComputer,Get-ADGroup,Get-ADOrganizationalUnit,Get-ADServiceAccount,Get-ADReplicationSite -ParameterName Properties -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $Values = @{
        'Get-ADUser' = @(
            'AccountExpirationDate'
            'accountExpires'
            'AccountLockoutTime'
            'AccountNotDelegated'
            'adminCount'
            'AllowReversiblePasswordEncryption'
            'AuthenticationPolicy'
            'AuthenticationPolicySilo'
            'BadLogonCount'
            'badPasswordTime'
            'badPwdCount'
            'c'
            'CannotChangePassword'
            'CanonicalName'
            'Certificates'
            'City'
            'CN'
            'co'
            'codePage'
            'Company'
            'CompoundIdentitySupported'
            'Country'
            'countryCode'
            'Created'
            'createTimeStamp'
            'Deleted'
            'Department'
            'Description'
            'DisplayName'
            'DistinguishedName'
            'Division'
            'DoesNotRequirePreAuth'
            'dSCorePropagationData'
            'EmailAddress'
            'EmployeeID'
            'EmployeeNumber'
            'Enabled'
            'Fax'
            'garbageCollPeriod'
            'GivenName'
            'HomeDirectory'
            'HomedirRequired'
            'HomeDrive'
            'HomePage'
            'HomePhone'
            'Initials'
            'instanceType'
            'internetEncoding'
            'isDeleted'
            'KerberosEncryptionType'
            'l'
            'LastBadPasswordAttempt'
            'LastKnownParent'
            'lastLogoff'
            'lastLogon'
            'LastLogonDate'
            'lastLogonTimestamp'
            'legacyExchangeDN'
            'LockedOut'
            'lockoutTime'
            'logonCount'
            'LogonWorkstations'
            'mail'
            'mailNickname'
            'Manager'
            'MemberOf'
            'MNSLogonAccount'
            'mobile'
            'MobilePhone'
            'Modified'
            'modifyTimeStamp'
            'mS-DS-ConsistencyGuid'
            'msDS-ExternalDirectoryObjectId'
            'msDS-KeyCredentialLink'
            'msDS-User-Account-Control-Computed'
            'msExchAddressBookFlags'
            'msExchArchiveQuota'
            'msExchArchiveWarnQuota'
            'msExchBypassAudit'
            'msExchCalendarLoggingQuota'
            'msExchDumpsterQuota'
            'msExchDumpsterWarningQuota'
            'msExchGroupSecurityFlags'
            'msExchMailboxAuditEnable'
            'msExchMailboxAuditLogAgeLimit'
            'msExchMailboxFolderSet'
            'msExchMDBRulesQuota'
            'msExchModerationFlags'
            'msExchPoliciesIncluded'
            'msExchProvisioningFlags'
            'msExchRecipientDisplayType'
            'msExchRecipientSoftDeletedStatus'
            'msExchRecipientTypeDetails'
            'msExchRemoteRecipientType'
            'msExchSafeSendersHash'
            'msExchTransportRecipientSettingsFlags'
            'msExchUMDtmfMap'
            'msExchUMEnabledFlags2'
            'msExchUserAccountControl'
            'msExchVersion'
            'msRTCSIP-DeploymentLocator'
            'msRTCSIP-FederationEnabled'
            'msRTCSIP-InternetAccessEnabled'
            'msRTCSIP-Line'
            'msRTCSIP-OptionFlags'
            'msRTCSIP-PrimaryUserAddress'
            'msRTCSIP-UserEnabled'
            'msTSExpireDate'
            'msTSLicenseVersion'
            'msTSLicenseVersion2'
            'msTSLicenseVersion3'
            'msTSManagingLS'
            'Name'
            'nTSecurityDescriptor'
            'ObjectCategory'
            'ObjectClass'
            'ObjectGUID'
            'objectSid'
            'Office'
            'OfficePhone'
            'Organization'
            'OtherName'
            'PasswordExpired'
            'PasswordLastSet'
            'PasswordNeverExpires'
            'PasswordNotRequired'
            'physicalDeliveryOfficeName'
            'POBox'
            'PostalCode'
            'PrimaryGroup'
            'primaryGroupID'
            'PrincipalsAllowedToDelegateToAccount'
            'ProfilePath'
            'ProtectedFromAccidentalDeletion'
            'protocolSettings'
            'proxyAddresses'
            'pwdLastSet'
            'SamAccountName'
            'sAMAccountType'
            'ScriptPath'
            'sDRightsEffective'
            'ServicePrincipalNames'
            'showInAddressBook'
            'SID'
            'SIDHistory'
            'SmartcardLogonRequired'
            'sn'
            'State'
            'StreetAddress'
            'Surname'
            'targetAddress'
            'telephoneNumber'
            'Title'
            'TrustedForDelegation'
            'TrustedToAuthForDelegation'
            'UseDESKeyOnly'
            'userAccountControl'
            'userCertificate'
            'UserPrincipalName'
            'uSNChanged'
            'uSNCreated'
            'whenChanged'
            'whenCreated'
        )
        'Get-ADComputer' = @(
            'AccountExpirationDate'
            'accountExpires'
            'AccountLockoutTime'
            'AccountNotDelegated'
            'AllowReversiblePasswordEncryption'
            'AuthenticationPolicy'
            'AuthenticationPolicySilo'
            'BadLogonCount'
            'badPasswordTime'
            'badPwdCount'
            'CannotChangePassword'
            'CanonicalName'
            'Certificates'
            'CN'
            'codePage'
            'CompoundIdentitySupported'
            'countryCode'
            'Created'
            'createTimeStamp'
            'Deleted'
            'Description'
            'DisplayName'
            'DistinguishedName'
            'DNSHostName'
            'DoesNotRequirePreAuth'
            'dSCorePropagationData'
            'Enabled'
            'HomedirRequired'
            'HomePage'
            'instanceType'
            'IPv4Address'
            'IPv6Address'
            'isCriticalSystemObject'
            'isDeleted'
            'KerberosEncryptionType'
            'LastBadPasswordAttempt'
            'LastKnownParent'
            'lastLogoff'
            'lastLogon'
            'LastLogonDate'
            'lastLogonTimestamp'
            'localPolicyFlags'
            'Location'
            'LockedOut'
            'logonCount'
            'ManagedBy'
            'MemberOf'
            'MNSLogonAccount'
            'Modified'
            'modifyTimeStamp'
            'ms-Mcs-AdmPwdExpirationTime'
            'msDS-SupportedEncryptionTypes'
            'msDS-User-Account-Control-Computed'
            'Name'
            'nTSecurityDescriptor'
            'ObjectCategory'
            'ObjectClass'
            'ObjectGUID'
            'objectSid'
            'OperatingSystem'
            'OperatingSystemHotfix'
            'OperatingSystemServicePack'
            'OperatingSystemVersion'
            'PasswordExpired'
            'PasswordLastSet'
            'PasswordNeverExpires'
            'PasswordNotRequired'
            'PrimaryGroup'
            'primaryGroupID'
            'PrincipalsAllowedToDelegateToAccount'
            'ProtectedFromAccidentalDeletion'
            'PSShowComputerName'
            'pwdLastSet'
            'SamAccountName'
            'sAMAccountType'
            'sDRightsEffective'
            'ServiceAccount'
            'servicePrincipalName'
            'ServicePrincipalNames'
            'SID'
            'SIDHistory'
            'TrustedForDelegation'
            'TrustedToAuthForDelegation'
            'UseDESKeyOnly'
            'userAccountControl'
            'userCertificate'
            'UserPrincipalName'
            'uSNChanged'
            'uSNCreated'
            'whenChanged'
            'whenCreated'
        )
        'Get-ADGroup' = @(
            'adminCount'
            'CanonicalName'
            'CN'
            'Created'
            'createTimeStamp'
            'Deleted'
            'Description'
            'DisplayName'
            'DistinguishedName'
            'dSCorePropagationData'
            'GroupCategory'
            'GroupScope'
            'groupType'
            'HomePage'
            'instanceType'
            'isCriticalSystemObject'
            'isDeleted'
            'LastKnownParent'
            'ManagedBy'
            'member'
            'MemberOf'
            'Members'
            'Modified'
            'modifyTimeStamp'
            'Name'
            'nTSecurityDescriptor'
            'ObjectCategory'
            'ObjectClass'
            'ObjectGUID'
            'objectSid'
            'ProtectedFromAccidentalDeletion'
            'SamAccountName'
            'sAMAccountType'
            'sDRightsEffective'
            'SID'
            'SIDHistory'
            'systemFlags'
            'uSNChanged'
            'uSNCreated'
            'whenChanged'
            'whenCreated'
        )
        'Get-ADOrganizationalUnit' = @(
            'CanonicalName'
            'City'
            'CN'
            'Country'
            'Created'
            'createTimeStamp'
            'Deleted'
            'Description'
            'DisplayName'
            'DistinguishedName'
            'dSCorePropagationData'
            'instanceType'
            'isDeleted'
            'LastKnownParent'
            'LinkedGroupPolicyObjects'
            'ManagedBy'
            'Modified'
            'modifyTimeStamp'
            'Name'
            'nTSecurityDescriptor'
            'ObjectCategory'
            'ObjectClass'
            'ObjectGUID'
            'ou'
            'PostalCode'
            'ProtectedFromAccidentalDeletion'
            'sDRightsEffective'
            'State'
            'StreetAddress'
            'uSNChanged'
            'uSNCreated'
            'whenChanged'
            'whenCreated'
        )
        'Get-ADServiceAccount' = @(
            'AccountExpirationDate'
            'accountExpires'
            'AccountLockoutTime'
            'AccountNotDelegated'
            'AllowReversiblePasswordEncryption'
            'AuthenticationPolicy'
            'AuthenticationPolicySilo'
            'BadLogonCount'
            'badPasswordTime'
            'badPwdCount'
            'CannotChangePassword'
            'CanonicalName'
            'Certificates'
            'CN'
            'codePage'
            'CompoundIdentitySupported'
            'countryCode'
            'Created'
            'createTimeStamp'
            'Deleted'
            'Description'
            'DisplayName'
            'DistinguishedName'
            'DNSHostName'
            'DoesNotRequirePreAuth'
            'dSCorePropagationData'
            'Enabled'
            'HomedirRequired'
            'HomePage'
            'HostComputers'
            'instanceType'
            'isCriticalSystemObject'
            'isDeleted'
            'KerberosEncryptionType'
            'LastBadPasswordAttempt'
            'LastKnownParent'
            'lastLogoff'
            'lastLogon'
            'LastLogonDate'
            'lastLogonTimestamp'
            'localPolicyFlags'
            'LockedOut'
            'logonCount'
            'ManagedPasswordIntervalInDays'
            'MemberOf'
            'MNSLogonAccount'
            'Modified'
            'modifyTimeStamp'
            'msDS-GroupMSAMembership'
            'msDS-ManagedPasswordId'
            'msDS-ManagedPasswordInterval'
            'msDS-ManagedPasswordPreviousId'
            'msDS-SupportedEncryptionTypes'
            'msDS-User-Account-Control-Computed'
            'Name'
            'nTSecurityDescriptor'
            'ObjectCategory'
            'ObjectClass'
            'ObjectGUID'
            'objectSid'
            'PasswordExpired'
            'PasswordLastSet'
            'PasswordNeverExpires'
            'PasswordNotRequired'
            'PrimaryGroup'
            'primaryGroupID'
            'PrincipalsAllowedToDelegateToAccount'
            'PrincipalsAllowedToRetrieveManagedPassword'
            'ProtectedFromAccidentalDeletion'
            'pwdLastSet'
            'SamAccountName'
            'sAMAccountType'
            'sDRightsEffective'
            'ServicePrincipalNames'
            'SID'
            'SIDHistory'
            'TrustedForDelegation'
            'TrustedToAuthForDelegation'
            'UseDESKeyOnly'
            'userAccountControl'
            'userCertificate'
            'UserPrincipalName'
            'uSNChanged'
            'uSNCreated'
            'whenChanged'
            'whenCreated'
        )
        'Get-ADReplicationSite' = @(
            'AutomaticInterSiteTopologyGenerationEnabled'
            'AutomaticTopologyGenerationEnabled'
            'CanonicalName'
            'CN'
            'Created'
            'createTimeStamp'
            'Deleted'
            'Description'
            'DisplayName'
            'DistinguishedName'
            'dSCorePropagationData'
            'instanceType'
            'InterSiteTopologyGenerator'
            'isDeleted'
            'LastKnownParent'
            'ManagedBy'
            'Modified'
            'modifyTimeStamp'
            'msExchServerSiteBL'
            'Name'
            'nTSecurityDescriptor'
            'ObjectCategory'
            'ObjectClass'
            'ObjectGUID'
            'ProtectedFromAccidentalDeletion'
            'RedundantServerTopologyEnabled'
            'ReplicationSchedule'
            'ScheduleHashingEnabled'
            'sDRightsEffective'
            'showInAdvancedViewOnly'
            'Subnets'
            'systemFlags'
            'TopologyCleanupEnabled'
            'TopologyDetectStaleEnabled'
            'TopologyMinimumHopsEnabled'
            'UniversalGroupCachingEnabled'
            'UniversalGroupCachingRefreshSite'
            'uSNChanged'
            'uSNCreated'
            'whenChanged'
            'whenCreated'
            'WindowsServer2000BridgeheadSelectionMethodEnabled'
            'WindowsServer2000KCCISTGSelectionBehaviorEnabled'
            'WindowsServer2003KCCBehaviorEnabled'
            'WindowsServer2003KCCIgnoreScheduleEnabled'
            'WindowsServer2003KCCSiteLinkBridgingEnabled'
        )
    }
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)
    foreach ($Item in $Values[$commandName])
    {
        if ($Item.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionHelper]::NewParamCompletionResult($Item)
        }
    }
}