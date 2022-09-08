#Requires -Version 5.1
using namespace System
using namespace System.Text
using namespace System.Collections.Generic
using namespace System.Management.Automation.Language

[CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
param
(
    [Parameter(Mandatory)]
    [Alias("ModuleVersion")]
    [version]$Version,

    [Parameter()]
    [string]
    $Destination = "$PSScriptRoot\Releases",

    [Parameter()]
    [switch]
    $UpdatePSGalleryData
)
$ModuleName="UsefulArgumentCompleters"

if ($UpdatePSGalleryData)
{
    Find-Module | Select-Object -Property @(
        "Name"
        @{Name = "CompanyName"; Expression = {$_.CompanyName -join ','}}
    ) | Sort-Object -Property Name | Export-Csv -Delimiter ',' -Path "$PSScriptRoot\PSGallery.csv" -NoTypeInformation -Force
}

#region Create destination folder and make sure it is empty
$DestinationDirectory = Join-Path -Path $Destination -ChildPath "$ModuleName\$Version"
$null = New-Item -Path $DestinationDirectory -ItemType Directory -Force

$ItemsToRemove = Get-ChildItem -LiteralPath $DestinationDirectory -Force
if ($ItemsToRemove)
{
    if ($PSCmdlet.ShouldProcess($DestinationDirectory, "Deleting $($ItemsToRemove.Count) item(s)"))
    {
        Remove-Item -LiteralPath $ItemsToRemove.FullName -Recurse -Force
    }
    else
    {
        exit
    }
}
#endregion

#region Compile and add all content to destination folder
$UniqueUsingStatements = [HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
$PublicFunctionNames = [HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
$DefaultBuilder = [StringBuilder]::new()
$NewLine = [Environment]::NewLine
$WindowsPowerShellBuilder = [StringBuilder]::new("if (`$PSEdition -eq 'Desktop')$NewLine{$NewLine")
$PowerShellBuilder = [StringBuilder]::new("if (`$PSEdition -eq 'Core')$NewLine{$NewLine")
$HypervBuilder = [StringBuilder]::new("`$Script:HypervCompleters = {$NewLine")

$FilePaths = @(
    "$PSScriptRoot\Classes"
    "$PSScriptRoot\ScriptCompleters"
    "$PSScriptRoot\Functions"
)
foreach ($File in Get-ChildItem -LiteralPath $FilePaths -Filter *.ps*1 -File -Recurse)
{
    $ScriptTokens = $null
    $BaseAst = [Parser]::ParseFile($File.FullName, [ref]$ScriptTokens, [ref]$null)
    foreach ($UsingStatement in $BaseAst.UsingStatements)
    {
        if ($UsingStatement.UsingStatementKind -eq [UsingStatementKind]::Namespace -and $null -eq $UsingStatement.Alias)
        {
            $null = $UniqueUsingStatements.Add("using namespace $($UsingStatement.Name.Value)")
        }
    }
    switch ($File.Directory.Name)
    {
        'PowerShell'
        {
            $null = $PowerShellBuilder.AppendLine($BaseAst.EndBlock.Extent.Text)
            break
        }
        'WindowsPowerShell'
        {
            $null = $WindowsPowerShellBuilder.AppendLine($BaseAst.EndBlock.Extent.Text)
            break
        }
        'HyperV'
        {
            $null = $HypervBuilder.AppendLine($BaseAst.EndBlock.Extent.Text)
            break
        }
        'Public'
        {
            if ($BaseAst.EndBlock.Extent.StartOffset -gt 0)
            {
                $TokenBeforeAst = $ScriptTokens | Where-Object -FilterScript {$_.Extent.EndOffset -lt $BaseAst.EndBlock.Extent.StartOffset -and $_.Kind -ne [TokenKind]::NewLine} | Select-Object -Last 1
                if ($TokenBeforeAst.Kind -eq [TokenKind]::Comment)
                {
                    $null = $DefaultBuilder.AppendLine($TokenBeforeAst.Text)
                }
            }
            $null = $DefaultBuilder.AppendLine($BaseAst.EndBlock.Extent.Text)
            $null = $PublicFunctionNames.Add($File.BaseName)
        }
        Default
        {
            $null = $DefaultBuilder.AppendLine($BaseAst.EndBlock.Extent.Text)
        }
    }
}
$null = $WindowsPowerShellBuilder.AppendLine('}')
$null = $PowerShellBuilder.AppendLine('}')
$null = $HypervBuilder.AppendLine('}')
$NewModuleFile = New-Item -Path "$DestinationDirectory\$ModuleName.psm1" -ItemType File -Force

$UniqueUsingStatements | Sort-Object | Add-Content -LiteralPath $NewModuleFile.FullName
Add-Content -Value $DefaultBuilder.ToString() -LiteralPath $NewModuleFile.FullName
Add-Content -Value $WindowsPowerShellBuilder.ToString() -LiteralPath $NewModuleFile.FullName
Add-Content -Value $PowerShellBuilder.ToString() -LiteralPath $NewModuleFile.FullName
Add-Content -Value $HypervBuilder.ToString() -LiteralPath $NewModuleFile.FullName

& "$PSScriptRoot\ExportCompletersList.ps1" -Path $NewModuleFile.FullName -ExportPath "$PSScriptRoot\ArgumentCompleters.csv"
Copy-Item -LiteralPath "$PSScriptRoot\ArgumentCompleters.csv" -Destination $DestinationDirectory
Copy-Item -LiteralPath "$PSScriptRoot\ModuleManifest.psd1" -Destination "$DestinationDirectory\$ModuleName.psd1"
Copy-Item -LiteralPath "$PSScriptRoot\PSGallery.csv" -Destination $DestinationDirectory
#endregion

#region update module manifest
$FileList = (Get-ChildItem -LiteralPath $DestinationDirectory -File -Recurse | ForEach-Object -Process {
    "'$($_.FullName.Replace("$DestinationDirectory\", ''))'"
}) -join ','
$PublicFunctionNames = ($PublicFunctionNames | ForEach-Object -Process {
    "'$_'"
}) -join ','
$ReleaseNotes = Get-Content -LiteralPath "$PSScriptRoot\Release notes.txt" -Raw

((Get-Content -LiteralPath "$PSScriptRoot\ModuleManifest.psd1" -Raw) -replace '{(?=[^\d])','{{' -replace '(?<!\d)}','}}') -f @(
    "'$Version'"
    $PublicFunctionNames
    $FileList
    $ReleaseNotes
) | Set-Content -LiteralPath "$DestinationDirectory\$ModuleName.psd1" -Force
#endregion