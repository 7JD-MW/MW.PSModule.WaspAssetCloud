function Get-WaspUserFolder {
    $user = $env:USERNAME
    $configRoot = Join-Path $PSScriptRoot '../Config'
    $userFolder = Join-Path $configRoot $user

    if (-not (Test-Path $userFolder)) {
        New-Item -ItemType Directory -Path $userFolder | Out-Null
    }

    return $userFolder
}
