Param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("install", "publish")]
    [string]$Action
)

# Stop on first error
$ErrorActionPreference = "Stop"

function Install-Aspire {
    Write-Host "Installing Aspire..."
    $installScriptPath = "$env:TEMP\aspire-install.ps1"

    Invoke-WebRequest -Uri "https://aspire.dev/install.sh" -OutFile $installScriptPath
    bash $installScriptPath  # Still runs in bash because Aspire uses a .sh installer
}

function Publish-Aspire {
    Write-Host "Publishing Aspire project..."

    $cmd = "aspire publish"

    if ($env:PROJECT) {
        $cmd += " --project `"$($env:PROJECT)`""
    }

    if ($env:OUTPUT) {
        $cmd += " --output-path `"$($env:OUTPUT)`""
    }

    if ($env:DEBUG -eq "true" -or $env:DEBUG -eq "True") {
        $cmd += " --debug"
    }

    if ($env:BUILD_CONFIGURATION) {
        $cmd += " /p:configuration=$($env:BUILD_CONFIGURATION)"
    }

    Write-Host "`nRunning command: $cmd`n"
    Invoke-Expression $cmd
}

switch ($Action) {
    "install" { Install-Aspire }
    "publish" { Publish-Aspire }
    default {
        Write-Error "Unknown action: $Action. Use 'install' or 'publish'."
        exit 1
    }
}
