function Invoke-WaspAssetInfoSearch {
    param(
        [Parameter(Mandatory)]
        [string]$SearchPattern,
        [switch]$ThrowOnError,
        [switch]$Raw
    )

    $body = @{ SearchPattern = $SearchPattern }

    $response = Invoke-WaspApi `
        -Endpoint 'public-api/assets/assetinfosearch' `
        -Body $body `
        -ThrowOnError:$ThrowOnError

    # Show raw output and exit early
    if ($Raw) {
        return $response
    }

    # If API returned a structured error object
    if ($response.Success -eq $false) {
        return $response
    }

    # Format normal structured output
    return Format-WaspAssetInfo -Response $response
}
