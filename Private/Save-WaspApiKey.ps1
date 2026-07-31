function Save-WaspApiKey {
    param(
        [Parameter(Mandatory)]
        [string]$ApiKey
    )

    # Sanitize key of whitespace and quotes
    $apiKeyClean = $ApiKey.Trim() `
        -replace '^\s*["'']', '' `
        -replace '["'']\s*$', ''

    $userFolder = Get-WaspUserFolder
    $keyFile = Join-Path $userFolder 'ApiKey.secure'

    $secureString = ConvertTo-SecureString -String $apiKeyClean -AsPlainText -Force
    $encrypted = ConvertFrom-SecureString $secureString

    Set-Content -Path $keyFile -Value $encrypted -Encoding UTF8
}
