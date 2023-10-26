using module .\Classes\CompletionHelper.psm1

$ScriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'

    foreach ($Package in [CompletionHelper]::GetCachedResults('Get-AppxPackage | Sort-Object -Property Name', $false))
    {
        if ($null -eq $Package)
        {
            continue
        }

        $MatchText = if ($parameterName -eq "Package")
        {
            $Package.PackageFullName
        }
        else
        {
            $Package.Name
        }

        if ($MatchText -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($MatchText, $Package.Name)
        }
    }
}
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName Name    -CommandName Get-AppxPackage
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName Package -CommandName Get-AppxPackageManifest,Move-AppxPackage,Remove-AppxPackage,Reset-AppxPackage