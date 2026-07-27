# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

param(
    [Parameter(Mandatory = $true)]
    [string]$SchemeName
)

$ErrorActionPreference = "Stop"

$ColorSchemes = @{
    "Tokyo Night" = [ordered]@{
        name                = "Tokyo Night"
        background          = "#1A1B26"
        foreground          = "#C0CAF5"
        black               = "#414868"
        red                 = "#F7768E"
        green               = "#9ECE6A"
        yellow              = "#E0AF68"
        blue                = "#7AA2F7"
        purple              = "#BB9AF7"
        cyan                = "#7DCFFF"
        white               = "#A9B1D6"
        brightBlack         = "#414868"
        brightRed           = "#F7768E"
        brightGreen         = "#9ECE6A"
        brightYellow        = "#E0AF68"
        brightBlue          = "#7AA2F7"
        brightPurple        = "#BB9AF7"
        brightCyan          = "#7DCFFF"
        brightWhite         = "#C0CAF5"
        cursorColor         = "#C0CAF5"
        selectionBackground = "#33467C"
    }
}

function Set-WindowsTerminalColorScheme {
    param([string]$Name)

    $candidates = @(
        (Join-Path $env:LOCALAPPDATA "Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"),
        (Join-Path $env:LOCALAPPDATA "Microsoft\Windows Terminal\settings.json")
    )

    $settingsPath = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1

    if (-not $settingsPath) {
        return
    }

    if (-not $ColorSchemes.ContainsKey($Name)) {
        throw "Unknown color scheme: $Name"
    }

    Copy-Item -Path $settingsPath -Destination "$settingsPath.dw-bak" -Force

    $settings = Get-Content -Path $settingsPath -Raw | ConvertFrom-Json

    $schemes = @($settings.schemes | Where-Object { $_.name -ne $Name })
    $schemes += [PSCustomObject]$ColorSchemes[$Name]
    $settings.schemes = $schemes

    foreach ($p in $settings.profiles.list) {
        if ($p.PSObject.Properties.Match("colorScheme").Count -gt 0) {
            $p.PSObject.Properties.Remove("colorScheme")
        }
    }

    if (-not $settings.profiles.defaults) {
        $settings.profiles | Add-Member -MemberType NoteProperty -Name "defaults" -Value ([PSCustomObject]@{}) -Force
    }

    $settings.profiles.defaults | Add-Member -MemberType NoteProperty -Name "colorScheme" -Value $Name -Force

    $settings | ConvertTo-Json -Depth 32 | Set-Content -Path $settingsPath -Encoding utf8
}

Set-WindowsTerminalColorScheme -Name $SchemeName
