#Requires -Version 5.1
<#
.SYNOPSIS
  Installs this opencode config onto a target system.
.DESCRIPTION
  Windows equivalent of install.sh. This repo is the source of truth; run this
  after cloning on a new machine. Copies config/ into the user profile's
  .config/opencode/ and commands/ into .config/opencode/commands/, overwriting
  files with the same names.
.PARAMETER DryRun
  Print what would be copied without touching the filesystem.
.EXAMPLE
  .\install.ps1
.EXAMPLE
  .\install.ps1 -DryRun
#>
[CmdletBinding()]
param(
    # The `dry-run` alias keeps the bash-style `--dry-run` invocation working.
    [Alias('dry-run')]
    [switch]$DryRun
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# --- paths -------------------------------------------------------------------

# `${HOME}` in the bash installer; `[Environment]` is only a fallback.
$HomeDir = $HOME
if ([string]::IsNullOrEmpty($HomeDir)) {
    $HomeDir = [Environment]::GetFolderPath([Environment+SpecialFolder]::UserProfile)
}

$Dest = Join-Path $HomeDir '.config/opencode'
$Src = (Resolve-Path -LiteralPath $PSScriptRoot).Path

# --- helpers -----------------------------------------------------------------

function Write-Action {
    param(
        [Parameter(Mandatory)][string]$Command,
        [Parameter()][string[]]$Arguments = @()
    )

    $quoted = @($Arguments | ForEach-Object { "'$($_.Replace("'", "''"))'" })
    Write-Host "[dry-run] $Command $($quoted -join ' ')"
}

function Install-DirectoryContent {
    param(
        [Parameter(Mandatory)][string]$Source,
        [Parameter(Mandatory)][string]$Destination
    )

    if (-not (Test-Path -LiteralPath $Source -PathType Container)) {
        throw "Source directory not found: $Source"
    }

    if ($DryRun) {
        Write-Action -Command 'mkdir' -Arguments @('-p', $Destination)
    }
    else {
        New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    }

    $items = @(Get-ChildItem -LiteralPath $Source -Force)
    if ($items.Count -eq 0) {
        Write-Warning "Nothing to copy from $Source"
        return
    }

    foreach ($item in $items) {
        $target = Join-Path $Destination $item.Name

        if ($DryRun) {
            Write-Action -Command 'copy' -Arguments @($item.FullName, $Destination)
            continue
        }

        Copy-Item -LiteralPath $item.FullName -Destination $target -Recurse -Force
        Write-Verbose "copied $($item.Name)"
    }
}

# --- install -----------------------------------------------------------------

Install-DirectoryContent -Source (Join-Path $Src 'config') -Destination $Dest
Install-DirectoryContent -Source (Join-Path $Src 'commands') -Destination (Join-Path $Dest 'commands')

# Copy subfolder configs (e.g. opencode-quota/)
$quotaSource = Join-Path $Src 'config/opencode-quota'
if (Test-Path -LiteralPath $quotaSource -PathType Container) {
    Install-DirectoryContent -Source $quotaSource -Destination (Join-Path $Dest 'opencode-quota')
}

# --- report ------------------------------------------------------------------

if ($DryRun) {
    Write-Host "Dry run complete - no files were changed. Would install to $Dest"
}
else {
    Write-Host "Installed opencode config to $Dest"
}