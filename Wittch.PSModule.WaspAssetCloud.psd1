@{
    RootModule        = 'Wittch.PSModule.WaspAssetCloud.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'c9e4b898-3fd2-4f9a-bbd8-78c2840bd2db'
    Author            = 'Wittch'
    Description       = 'A PowerShell module for interacting with Wasp AssetCloud APIs.'
    PowerShellVersion = '5.1'

    FunctionsToExport = @(
        'Set-WaspConfig',
        'Invoke-WaspAssetInfoSearch',
        'Invoke-WaspAdvancedAssetInfoSearch'
    )

    PrivateData = @{
        PSData = @{
            Tags = @('WaspAssetCloud','Wittch','API','Wasp')
        }
    }
}
