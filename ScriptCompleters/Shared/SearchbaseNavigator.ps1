using module .\Classes\CompletionHelper.psm1
using namespace System
using namespace System.Management.Automation

Register-ArgumentCompleter -CommandName @(
    'Get-ADComputer'
    'Get-ADFineGrainedPasswordPolicy'
    'Get-ADGroup'
    'Get-ADObject'
    'Get-ADOptionalFeature'
    'Get-ADOrganizationalUnit'
    'Get-ADServiceAccount'
    'Get-ADUser'
    'Search-ADAccount'
) -ParameterName SearchBase -ScriptBlock {
    #This is not actually an argument completer, it's more like a CLI OU navigator
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)
    $GetOuParams = @{
        SearchScope = [Microsoft.ActiveDirectory.Management.ADSearchScope]::OneLevel
        Filter      = '*'
    }
    if ($TrimmedWord.Length -gt 0)
    {
        $GetOuParams.Add('SearchBase', $TrimmedWord)
    }

    foreach ($Ou in Get-ADOrganizationalUnit @GetOuParams)
    {
        [CompletionResult]::new(
            "'$($Ou.DistinguishedName)'",
            $Ou.Name,
            [CompletionResultType]::ParameterValue,
            $Ou.DistinguishedName
        )
    }
}