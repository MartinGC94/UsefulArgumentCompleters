using module .\Classes\CompletionHelper.psm1

Register-ArgumentCompleter -CommandName New-Partition -ParameterName GptType -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    $Types = @(
        @{Name = "Recovery"; Guid="{de94bba4-06d1-4d40-a16a-bfd50179d6ac}"}
        @{Name = "EFI";      Guid="{c12a7328-f81f-11d2-ba4b-00a0c93ec93b}"}
        @{Name = "MSR";      Guid="{e3c9e316-0b5c-4db8-817d-f92df00215ae}"}
        @{Name = "Basic";    Guid="{ebd0a0a2-b9e5-4433-87c0-68b6b72699c7}"}
    )

    $TrimmedWord = [CompletionHelper]::TrimQuotes($wordToComplete)
    foreach ($Item in $Types)
    {
        if ($Item['Name'].StartsWith($TrimmedWord, [StringComparison]::OrdinalIgnoreCase))
        {
            [CompletionHelper]::NewParamCompletionResult($Item['Guid'], $Item['Name'])
        }
    }
}