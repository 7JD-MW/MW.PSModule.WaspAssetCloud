function Handle-WaspApiError {
    param(
        [Parameter(Mandatory)]
        $Exception,

        [Parameter()]
        $ResponseObject,

        [switch]$Throw
    )

    # PowerShell-level HTTP or REST errors
    if ($Exception -is [System.Net.WebException]) {
        $status = $Exception.Response.StatusCode.value__
        $desc   = $Exception.Response.StatusDescription

        $msg = "HTTP Error $status : $desc"
        Write-Error $msg

        if ($Throw) { throw $msg }

        return @{
            Success    = $false
            StatusCode = $status
            Message    = $desc
            Exception  = $Exception
        }
    }

    # WASP API wrapper errors inside response object
    if ($ResponseObject -and $ResponseObject.HasError -eq $true) {
        $errors = $ResponseObject.Messages | Select-Object Message, HttpStatusCode, ResultCode

        Write-Error "Wasp API reported errors:"
        foreach ($e in $errors) {
            Write-Error "[$($e.HttpStatusCode)] $($e.Message)"
        }

        if ($Throw) {
            throw ($errors | Format-Table | Out-String)
        }

        return @{
            Success     = $false
            Errors      = $errors
            RawResponse = $ResponseObject
        }
    }

    # Unexpected exceptions (XML/HTML body errors, parsing errors)
    $msg = $Exception.Message
    Write-Error "Unexpected Wasp API error: $msg"

    if ($Throw) { throw $msg }

    return @{
        Success  = $false
        Message  = $msg
        Exception = $Exception
    }
  }
