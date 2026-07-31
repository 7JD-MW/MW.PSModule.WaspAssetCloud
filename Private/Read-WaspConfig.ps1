function Read-WaspConfig {
    $configFile = Join-Path $PSScriptRoot '../Config/settings.json'

    if (Test-Path $configFile) {
        return (Get-Content $configFile | ConvertFrom-Json)
    }

    return $null
}
