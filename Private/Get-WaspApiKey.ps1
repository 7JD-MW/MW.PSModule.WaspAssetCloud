function Get-WaspApiKey {
    $userFolder = Get-WaspUserFolder
    $keyFile = Join-Path $userFolder 'ApiKey.secure'

    if (-not (Test-Path $keyFile)) {
        Write-Host "No API key found for user $env:USERNAME." -ForegroundColor Yellow
        $apiKey = Read-Host "Enter your Wasp API key"

        Save-WaspApiKey -ApiKey $apiKey
        Write-Host "API key saved securely for user $env:USERNAME." -ForegroundColor Green
    }

    $encrypted = Get-Content $keyFile -Encoding UTF8
    $secureString = ConvertTo-SecureString $encrypted
    $plainText = [System.Net.NetworkCredential]::new("", $secureString).Password

    return $plainText
}
