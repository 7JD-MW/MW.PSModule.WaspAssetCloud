function Set-WaspConfig {
    param(
        [Parameter(Mandatory)]
        [string]$BaseUrl
    )

    Write-WaspConfig -BaseUrl $BaseUrl
    Write-Host "Wasp BaseUrl saved." -ForegroundColor Green
}
