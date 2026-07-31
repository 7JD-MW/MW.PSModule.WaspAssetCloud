<#
    .SYNOPSIS
        WASP API PowerShell Module
    .DESCRIPTION
        Module Loader: Imports Public/Private functions & ensures API key prompt
    .NOTES
        Version:  1.0.0
        Author:  Wittch
        Creation Date:  07-31-2026
        Last Update:  07-31-2026
    .EXAMPLE
        # See /Tests/Wittch.PSModule.SearchTest.ps1 for example usage
#>

<#
██╗    ██╗██╗████████╗████████╗ ██████╗██╗  ██╗
██║    ██║██║╚══██╔══╝╚══██╔══╝██╔════╝██║  ██║
██║ █╗ ██║██║   ██║      ██║   ██║     ███████║
██║███╗██║██║   ██║      ██║   ██║     ██╔══██║
╚███╔███╔╝██║   ██║      ██║   ╚██████╗██║  ██║
 ╚══╝╚══╝ ╚═╝   ╚═╝      ╚═╝    ╚═════╝╚═╝  ╚═╝
#>

# Import Private Functions
Get-ChildItem -Path (Join-Path $PSScriptRoot 'Private') -Filter *.ps1 |
    ForEach-Object { . $_.FullName }

# Import Public Functions
Get-ChildItem -Path (Join-Path $PSScriptRoot 'Public') -Filter *.ps1 |
    ForEach-Object { . $_.FullName }

# Auto-prompt for API key on first load
try {
    $null = Get-WaspApiKey   # Will prompt the user only if missing
} catch {
    Write-Warning "API key missing. You will be prompted when the first API call is made."
}
