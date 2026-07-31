function Write-WaspConfig {
    param(
        [string]$BaseUrl
    )

    $configFile = Join-Path $PSScriptRoot '../Config/settings.json'

    $config = @{
        BaseUrl = $BaseUrl
    }

    $config | ConvertTo-Json | Set-Content -Path $configFile
}
