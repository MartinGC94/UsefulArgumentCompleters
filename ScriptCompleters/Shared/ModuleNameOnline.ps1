using module .\Classes\CompletionHelper.psm1

Register-ArgumentCompleter -CommandName Find-Module,Install-Module,Save-Module -ParameterName Name -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)
    foreach ($Module in [CompletionHelper]::GetCachedResults("Import-Csv -Delimiter ',' -LiteralPath '$PSScriptRoot\PSGallery.csv'", $false))
    {
        if ($null -eq $Module)
        {
            continue
        }
        if ($Module.Name.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionHelper]::NewParamCompletionResult($Module.Name, "CompanyName: $($Module.CompanyName)")
        }
    }
}