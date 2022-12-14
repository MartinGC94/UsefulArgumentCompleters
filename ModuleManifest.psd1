@{
    RootModule             = "UsefulArgumentCompleters.psm1"
    ModuleVersion          = {0}
    CompatiblePSEditions   = @("Core", "Desktop")
    GUID                   = '689ec054-2cc8-4cf3-9a12-38fed35b659f'
    Author                 = 'MartinGC94'
    CompanyName            = 'Unknown'
    Copyright              = '(c) 2022 MartinGC94. All rights reserved.'
    Description            = 'Module with lots of argument completers for popular commands.'
    PowerShellVersion      = '5.1'
    FormatsToProcess       = @()
    FunctionsToExport      = @({1})
    CmdletsToExport        = @()
    VariablesToExport      = @()
    AliasesToExport        = @()
    DscResourcesToExport   = @()
    FileList               = @({2})
    PrivateData            = @{
        PSData = @{
             Tags         = @("Argument", "Completer", "Completion", "TabCompletion")
             ProjectUri   = 'https://github.com/MartinGC94/UsefulArgumentCompleters'
             ReleaseNotes = @'
{3}
'@
        }
    }
}