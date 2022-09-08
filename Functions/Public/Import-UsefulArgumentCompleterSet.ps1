<#
.SYNOPSIS
    Imports optional argument completers.
    This is intended to handle argument completers that may conflict with other commands such as Hyper-V VS PowerCLI commands.

.PARAMETER OptionalCompleter
    Name of completer to load.
#>
function Import-UsefulArgumentCompleterSet
{
    Param
    (
        [Parameter(Mandatory)]
        [Alias("Completer")]
        [ValidateSet("Hyperv")]
        [string[]]
        $OptionalCompleter
    )
    End
    {
        switch ($OptionalCompleter)
        {
            'HyperV'
            {
                & $Script:HypervCompleters
                break
            }
        }
    }
}