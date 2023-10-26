using module .\Classes\CompletionHelper.psm1

$ScriptBlock = {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)
    $WildcardInput = [CompletionHelper]::TrimQuotes($wordToComplete) + '*'
    $Values = switch ($parameterName)
    {
        'LocalAddress'
        {
            Get-NetTCPConnection -LocalAddress $WildcardInput | Select-Object -ExpandProperty LocalAddress | Sort-Object -Unique
            break
        }
        'RemoteAddress'
        {
            Get-NetTCPConnection -RemoteAddress $WildcardInput | Select-Object -ExpandProperty RemoteAddress | Sort-Object -Unique
            break
        }
        'LocalPort'
        {
            Get-NetTCPConnection | Select-Object -ExpandProperty LocalPort | Sort-Object -Unique
            break
        }
        'RemotePort'
        {
            Get-NetTCPConnection | Select-Object -ExpandProperty RemotePort | Sort-Object -Unique
            break
        }
    }
    foreach ($Value in $Values)
    {
        if ($Value -like $WildcardInput)
        {
            [CompletionHelper]::NewParamCompletionResult($Value)
        }
    }
}
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -CommandName Get-NetTCPConnection -ParameterName LocalAddress
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -CommandName Get-NetTCPConnection -ParameterName RemoteAddress
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -CommandName Get-NetTCPConnection -ParameterName LocalPort
Register-ArgumentCompleter -ScriptBlock $ScriptBlock -CommandName Get-NetTCPConnection -ParameterName RemotePort