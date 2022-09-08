using namespace System.Management.Automation.Language
param
(
    [Parameter(Mandatory)]
    [string]
    $Path,

    [Parameter(Mandatory)]
    [string]
    $ExportPath
)

function GetAstValue ([Ast]$ValueAst, [Ast]$BaseAst)
{
    if ($ValueAst -is [CommandExpressionAst])
    {
        $ValueAst = $ValueAst.Expression
    }

    if ($ValueAst -is [StringConstantExpressionAst])
    {
        $ValueAst.Value
    }
    elseif ($ValueAst -is [ArrayLiteralAst])
    {
        $ValueAst.Elements.Value
    }
    elseif ($ValueAst -is [ArrayExpressionAst])
    {
        $ValueAst.SubExpression.Statements.PipelineElements.Expression.Value
    }
    elseif ($ValueAst -is [VariableExpressionAst])
    {
        $LastVarAssignment = $BaseAst.FindAll({
            param($Ast)
            $Ast.Extent.EndOffset -lt $ValueAst.Extent.StartOffset -and
            $Ast -is [AssignmentStatementAst] -and
            $Ast.Left -is [VariableExpressionAst] -and
            $Ast.Left.UserPath -eq $ValueAst.UserPath
        }, $true) | Select-Object -Last 1
        GetAstValue -ValueAst $LastVarAssignment.Right.Expression -BaseAst $BaseAst
    }
}

$BaseAst = [Parser]::ParseFile((Resolve-Path -Path $Path).ProviderPath,[ref] $null, [ref] $null)
$ArgumentCompleters = $BaseAst.FindAll({
    param($Ast)
    $Ast -is [CommandAst] -and
    $Ast.GetCommandName() -eq "Register-ArgumentCompleter"
}, $true)

$Result = foreach ($Completer in $ArgumentCompleters)
{
    $CommandName = ""
    $ParameterName = ""
    for ($i = 0; $i -lt $Completer.CommandElements.Count; $i++)
    {
        $Ast = $Completer.CommandElements[$i]
        if ($Ast -is [CommandParameterAst] -and $Ast.ParameterName -in ("CommandName","ParameterName"))
        {
            $ParamValue = if ($null -eq $Ast.Argument)
            {
                $Completer.CommandElements[$i + 1]
            }
            else
            {
                $Ast.Argument
            }
        
            $Value = GetAstValue -ValueAst $ParamValue -BaseAst $BaseAst
            if ($Ast.ParameterName -eq "CommandName")
            {
                $CommandName = $Value
            }
            else
            {
                $ParameterName = $Value
            }
        }
    }

    foreach ($Name in $CommandName)
    {
        [pscustomobject]@{
            CommandName   = $Name
            ParameterName = $ParameterName
        }
    }
}
$Result | Sort-Object -Property CommandName | Export-Csv -Path $ExportPath -Force -NoTypeInformation -Delimiter ','