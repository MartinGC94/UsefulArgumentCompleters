using namespace System
using namespace System.Management.Automation
using namespace System.Management.Automation.Language
using namespace System.Collections.Generic

class CompletionHelper
{
    # Chars that PowerShell treats as quote chars
    hidden static [char[]] $QuoteChars = [char[]]@(
        [char]"'"
        [char]'"'
        [char]0x2018 # left single quotation mark
        [char]0x2019 # right single quotation mark
        [char]0x201a # single low-9 quotation mark
        [char]0x201b # single high-reversed-9 quotation mark
        [char]0x201c # left double quotation mark
        [char]0x201d # right double quotation mark
        [char]0x201E # low double left quote used in german.
    )

    # Chars that cannot be used at the start of a barequote string
    hidden static [char[]] $BadStartChars = [char[]]@(
        [char]'<'
        [char]'>'
        [char]'#'
        [char]'&'
        [char]'-'
        [char]0x2013 # EnDash
        [char]0x2014 # EmDash
        [char]0x2015 # HorizontalBar
    )

    # Chars that cause issues when used anywhere in a barequote string
    hidden static [char[]] $BadChars = [char[]]@(
        [char]'$'
        [char]'`' # Backtick
        [char]' ' # Space
        [char]'"'
        [char]','
        [char]';'
        [char]'('
        [char]')'
        [char]'{'
        [char]'}'
        [CompletionHelper]::QuoteChars
    )

    # Cache for saving expensive or static object collections used for completions
    hidden static [Dictionary[string,Object[]]] $ObjectCache = ([Dictionary[string,Object[]]]::new([System.StringComparer]::OrdinalIgnoreCase))

    static [string] AddQuotesIfNeeded([string] $CompletionText)
    {
        $Result = if ($CompletionText.Contains("'"))
        {
            "'$($CompletionText.Replace("'","''"))'"
        }
        elseif ($CompletionText.IndexOfAny([CompletionHelper]::BadStartChars) -eq 0 -or $CompletionText.IndexOfAny([CompletionHelper]::BadChars) -ne -1)
        {
            "'$CompletionText'"
        }
        else
        {
            $CompletionText
        }
         return $Result
    }

    static [string] TrimQuotes([string] $Text)
    {
        return $Text.Trim([CompletionHelper]::QuoteChars)
    }

    static [CompletionResult] NewParamCompletionResult([string] $Text)
    {
        return [CompletionResult]::new(
            [CompletionHelper]::AddQuotesIfNeeded($Text),
            $Text,
            [CompletionResultType]::ParameterValue,
            $Text
        )
    }

    static [CompletionResult] NewParamCompletionResult([string] $Text, [string]$ToolTip)
    {
        return [CompletionResult]::new(
            [CompletionHelper]::AddQuotesIfNeeded($Text),
            $Text,
            [CompletionResultType]::ParameterValue,
            $ToolTip
        )
    }

    # Validates that the string is a valid PowerShell command with no nested expressions
    hidden static [bool] CommandIsSafe([string] $Command)
    {
        $ParsedTokens = $null
        $Errors = $null
        $null = [Parser]::ParseInput($Command, [ref]$ParsedTokens, [ref]$Errors)
        if ($Errors.Count -gt 0)
        {
            return $false
        }
        foreach ($Token in $ParsedTokens)
        {
            if
            (
                $Token -isnot [StringLiteralToken] -and
                $Token -isnot [ParameterToken] -and
                $Token.Kind -ne [TokenKind]::EndOfInput -and
                $Token.Kind -ne [TokenKind]::Identifier
            )
            {
                return $false
            }
        }
        return $true
    }

    static [Object[]] GetCachedResults([string] $Command, [bool] $ValidateInput)
    {
        $Result = $null
        if ([CompletionHelper]::ObjectCache.TryGetValue($Command, [ref] $Result))
        {
            return $Result
        }
        $Result = if (!$ValidateInput -or [CompletionHelper]::CommandIsSafe($Command))
        {
            try
            {
                Invoke-Expression -Command $Command
            }
            catch
            {
                return $null
            }
        }
        else
        {
            return $null
        } 
        [CompletionHelper]::ObjectCache.Add($Command, $Result)
        return $Result
    }
}