function Invoke-WaspApi {
    param(
        [Parameter(Mandatory)]
        [string]$Endpoint,

        [ValidateSet('GET','POST')]
        [string]$Method = 'POST',

        [object]$Body = $null,

        [switch]$ThrowOnError
    )

    # Load Base URL from config
    $config = Read-WaspConfig
    if (-not $config) {
        throw "Configuration missing. Run Set-WaspConfig first."
    }

    # Load per-user encrypted API key
    $apiKey = Get-WaspApiKey

    # Build request URL
    $uri = "$($config.BaseUrl)/$Endpoint"

    # Build headers
    $headers = @{
        "Authorization" = "Bearer $apiKey"
        "Content-Type"  = "application/json"
    }

    # Serialize body if present
    if ($Body) {
        $Body = $Body | ConvertTo-Json -Depth 10
    }

    try {
        # Perform API call
        $response = Invoke-RestMethod -Uri $uri -Method $Method -Headers $headers -Body $Body

        # WASP-level result wrapper errors
        if ($response.HasError -eq $true) {
            return Handle-WaspApiError -ResponseObject $response -Throw:$ThrowOnError
        }

        return $response
    }
    catch {
        return Handle-WaspApiError -Exception $_.Exception -Throw:$ThrowOnError
    }
}
