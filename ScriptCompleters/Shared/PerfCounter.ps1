using module .\Classes\CompletionHelper.psm1

$ScriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'
    foreach ($Counter in [CompletionHelper]::GetCachedResults("Get-Counter -ListSet * | Sort-Object -Property CounterSetName", $false))
    {
        if ($null -eq $Counter)
        {
            continue
        }
        if ($parameterName -eq "ListSet")
        {
            if ($Counter.CounterSetName -like $WildcardInput)
            {
                [CompletionHelper]::NewParamCompletionResult($Counter.CounterSetName)
            }
        }
        else
        {
            foreach ($Path in $Counter.Paths)
            {
                if ($Path -like $WildcardInput)
                {
                    [CompletionHelper]::NewParamCompletionResult($Path)
                }
            }
        }        
    }
}
Register-ArgumentCompleter -CommandName Get-Counter -ParameterName ListSet -ScriptBlock $ScriptBlock
Register-ArgumentCompleter -CommandName Get-Counter -ParameterName Counter -ScriptBlock $ScriptBlock