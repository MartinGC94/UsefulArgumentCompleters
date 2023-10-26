using module .\Classes\CompletionHelper.psm1

Register-ArgumentCompleter -CommandName New-ItemProperty -ParameterName PropertyType -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    
    $ResolveArgument = if ($null -ne $fakeBoundParameters['Path'])
    {
        @{LiteralPath = $fakeBoundParameters['Path']}
    }
    elseif ($null -ne $fakeBoundParameters['LiteralPath'])
    {
        @{LiteralPath = $fakeBoundParameters['LiteralPath']}
    }
    else
    {
        @{Path = '.\'}
    }
    
    $Values = switch ((Resolve-Path @ResolveArgument | Select-Object -First 1).Provider.Name)
    {
        'Registry'
        {
            @(
                @{Name = "String";      ToolTip = "A normal string."}
                @{Name = "ExpandString";ToolTip = "A string that contains unexpanded references to environment variables that are expanded when the value is retrieved."}
                @{Name = "Binary";      ToolTip = "Binary data in any form."}
                @{Name = "DWord";       ToolTip = "A 32-bit binary number."}
                @{Name = "MultiString"; ToolTip = "An array of strings."}
                @{Name = "Qword";       ToolTip = "A 64-bit binary number"}
                @{Name = "Unknown";     ToolTip = "An unsupported registry data type"}
            )
            break
        }
        Default
        {
            return
        }
    }

    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'
    foreach ($Item in $Values)
    {
        if ($Item['Name'] -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($Item['Name'], $Item['ToolTip'])
        }
    }
}