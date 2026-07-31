function Invoke-WaspAdvancedAssetInfoSearch {
    param(
        [Parameter(Mandatory)]
        [string]$SearchPattern,
        [switch]$ThrowOnError,
        [switch]$Raw
    )

  $body = @{
      _sortCriteria = @()            # empty array
      TotalCountFromPriorFetch = 0   # starting from scratch
      AdditionalSkipCount = 0
      PageSize = 100                 # adjust if needed
      PageNumber = 1
      Filter = @{
          field   = "AssetTag"
          operator = "Equals"
          value   = $SearchPattern
          logic   = $null
          filters = @()
      }
      ClientUtcOffset = $null
      FilterBehavior = 0             # default
      IgnoreAttachments = $true
      IgnoreGeoLocation = $true
      WorkingSiteIdCsvList = ""      # optional
  }

    $response = Invoke-WaspApi `
        -Endpoint 'public-api/assets/assetadvancedinfosearch' `
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
