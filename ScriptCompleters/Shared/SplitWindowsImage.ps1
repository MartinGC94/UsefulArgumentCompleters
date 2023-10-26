using module .\Classes\CompletionHelper.psm1
using namespace System.Management.Automation

Register-ArgumentCompleter -CommandName Split-WindowsImage -ParameterName FileSize -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    
    $SizeConfigs = @(
        @{Name = "Fat32"; Size="4096"}
    )

    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'
    foreach ($Item in $SizeConfigs)
    {
        if ($Item['Name'] -like $WildcardInput)
        {
            [CompletionResult]::new(
                $Item['Size'],
                $Item['Name'],
                [CompletionResultType]::ParameterValue,
                "$($Item['Size'])MB for $($Item['Name'])"
            )
        }
    }
}