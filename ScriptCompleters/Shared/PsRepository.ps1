using module .\Classes\CompletionHelper.psm1

$ScriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)

    foreach ($Repository in Get-PSRepository -Name "$TrimmedWord*")
    {
        [CompletionHelper]::NewParamCompletionResult($Repository.Name, $Repository.SourceLocation)
    }
}
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName Name -CommandName Get-PSRepository,Set-PSRepository,Unregister-PSRepository
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName Repository -CommandName @(
    'Find-Command'
    'Find-DscResource'
    'Find-Module'
    'Find-RoleCapability'
    'Find-Script'
    'Install-Module'
    'Install-Script'
    'Publish-Module'
    'Publish-Script'
    'Save-Module'
    'Save-Script'
)