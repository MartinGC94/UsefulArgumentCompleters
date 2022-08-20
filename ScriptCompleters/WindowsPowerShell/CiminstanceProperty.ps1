using module .\Classes\CompletionHelper.psm1

Register-ArgumentCompleter -CommandName Get-CimInstance -ParameterName Property -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    if (!$fakeBoundParameters['ClassName'])
    {
        return
    }

    $GetCimClassParams = @{ClassName = $fakeBoundParameters['ClassName']}
    if ($fakeBoundParameters['Namespace'])
    {
        $GetCimClassParams.Add('Namespace',$fakeBoundParameters['Namespace'])
    }
    $FoundClass = Get-CimClass @GetCimClassParams -ErrorAction Ignore

    if (!$FoundClass)
    {
        return
    }

    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)
    foreach ($Item in $FoundClass.CimClassProperties)
    {
        if ($Item.Name.StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionHelper]::NewParamCompletionResult($Item.Name, "$($Item.Name) [$($Item.CimType)]")
        }
    }
}