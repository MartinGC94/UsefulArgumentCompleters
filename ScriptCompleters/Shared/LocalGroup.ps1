using module .\Classes\CompletionHelper.psm1

$ScriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'
    foreach ($Group in Get-LocalGroup)
    {
        $MatchText = if ($parameterName -eq "Name")
        {
            $Group.Name
        }
        else
        {
            $Group.SID.Value
        }

        if ($MatchText -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($MatchText, "$($Group.Description)")
        }
    }
}
Register-ArgumentCompleter -CommandName Get-LocalGroup,Remove-LocalGroup,Rename-LocalGroup,Set-LocalGroup,Add-LocalGroupMember,Get-LocalGroupMember,Remove-LocalGroupMember -ParameterName Name -ScriptBlock $ScriptBlock
Register-ArgumentCompleter -CommandName Get-LocalGroup,Remove-LocalGroup,Rename-LocalGroup,Set-LocalGroup,Add-LocalGroupMember,Get-LocalGroupMember,Remove-LocalGroupMember -ParameterName SID -ScriptBlock $ScriptBlock
Register-ArgumentCompleter -CommandName Add-LocalGroupMember -ParameterName Member -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'
    $GroupsAndUsers = @(
        Get-LocalGroup -Name $WildcardInput -ErrorAction Ignore
        Get-LocalUser -Name $WildcardInput -ErrorAction Ignore
    )
    foreach ($Item in $GroupsAndUsers)
    {
        [CompletionHelper]::NewParamCompletionResult($Item.Name, $Item.ObjectClass)
    }
}
Register-ArgumentCompleter -CommandName Get-LocalGroupMember,Remove-LocalGroupMember -ParameterName Member -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $GroupMembers = if ($null -ne $fakeBoundParameters['Name'])
    {
        Get-LocalGroupMember -Name $fakeBoundParameters['Name'] -ErrorAction Ignore
    }
    elseif ($null -ne $fakeBoundParameters['SID'])
    {
        Get-LocalGroupMember -SID $fakeBoundParameters['SID'] -ErrorAction Ignore
    }

    if ($null -eq $GroupMembers)
    {
        return
    }

    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'
    foreach ($Member in $GroupMembers)
    {
        if ($Member.Name -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($Member.Name, $Member.ObjectClass)
        }
    }
}