# Test script for Wittch.PSModule.WaspAssetCloud module

# Import the module
$ModulePath = "$PSScriptRoot\..\Wittch.PSModule.WaspAssetCloud.psd1"
Import-Module $ModulePath -Force

# Set Base URL for Wasp AssetCloud
Set-WaspConfig -BaseUrl "https://www.waspassetcloud.com/Help/Api"

# Perform a simple asset lookup using an asset tag
$tag = "12345"

Write-Host "Searching for asset tag: $tag" -ForegroundColor Cyan

$result = Invoke-WaspAssetInfoSearch -SearchPattern $tag
$result | Format-Table AssetTag, SerialNumber, Manufacturer, Model, AssetType, AssetStatus -AutoSize

#Invoke-WaspAssetInfoSearch -SearchPattern $tag -Raw

Invoke-WaspAdvancedAssetInfoSearch -SearchPattern $tag -Raw
