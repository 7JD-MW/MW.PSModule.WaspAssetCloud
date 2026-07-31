function Format-WaspAssetInfo {
    param(
        [Parameter(Mandatory)]
        $Response
    )

    if ($Response -is [System.Collections.IEnumerable] -and -not $Response.PSObject.Properties["Data"]) {
        $dataList = $Response
    }
    else {
        $dataList = $Response.Data
    }

    if (-not $dataList) {
        return $null
    }

    $formatted = foreach ($item in $dataList) {

        # Convert CustomFields into a key/value hashtable
        $customFieldHash = @{}
        if ($item.CustomFields) {
            foreach ($cf in $item.CustomFields) {
                $customFieldHash[$cf.DcfLabel] = $cf.DcfTextValue
            }
        }

        [pscustomobject]@{
            AssetTag            = $item.AssetTag
            AssetDescription    = $item.AssetDescription
            SerialNumber        = $item.AssetSerialNumber
            Manufacturer        = $item.ManufacturerName
            Model               = $item.AssetModelName
            AssetType           = $item.AssetTypeNumber
            Condition           = $item.ConditionDescription
            HasAttachment       = $item.HasAttachment
            AssetStatus         = ($customFieldHash["Asset Status"])
            CustomFields        = $customFieldHash
            Raw                 = $item
        }
    }

    return $formatted
}
