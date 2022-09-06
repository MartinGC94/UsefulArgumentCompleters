using module .\Classes\CompletionHelper.psm1
using namespace System
using namespace System.Management.Automation

$ScriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)

    foreach ($Culture in [CompletionHelper]::GetCachedResults('[cultureinfo]::GetCultures([System.Globalization.CultureTypes]::AllCultures)', $false))
    {
        if ($null -eq $Culture)
        {
            continue
        }

        if ($Culture.Name -eq [string]::Empty -and $Culture.DisplayName.StartsWith($TrimmedWord))
        {
            if ($commandName -in 'Get-InstalledLanguage','Install-Language','Set-SystemPreferredUILanguage','Uninstall-Language')
            {
                continue
            }
            [CompletionResult]::new(
                "''",
                $Culture.DisplayName,
                [CompletionResultType]::ParameterValue,
                $Culture.DisplayName
            )
            continue
        }

        if ($Culture.Name.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionHelper]::NewParamCompletionResult($Culture.Name, $Culture.DisplayName)
        }
    }
}
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName UICulture    -CommandName Update-Help,Save-Help,New-PSSessionOption
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName Culture      -CommandName New-PSSessionOption
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName Language     -CommandName Set-WinUILanguageOverride,Get-InstalledLanguage,Install-Language,Set-SystemPreferredUILanguage,Uninstall-Language
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName SystemLocale -CommandName Set-WinSystemLocale
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -ParameterName CultureInfo  -CommandName Set-Culture