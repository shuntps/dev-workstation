# Copyright (C) 2026 Shunt
# SPDX-License-Identifier: GPL-3.0-or-later

param(
    [Parameter(Mandatory = $true)]
    [string]$FontName,

    [Parameter(Mandatory = $true)]
    [string]$FontUrl
)

$ErrorActionPreference = "Stop"

Add-Type -MemberDefinition @'
[DllImport("gdi32.dll")]
public static extern int AddFontResource(string lpszFilename);
'@ -Name Gdi32 -Namespace DevWorkstation

Add-Type -MemberDefinition @'
[DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
public static extern IntPtr SendMessageTimeout(IntPtr hWnd, uint Msg, UIntPtr wParam, IntPtr lParam, uint fuFlags, uint uTimeout, out UIntPtr lpdwResult);
'@ -Name User32 -Namespace DevWorkstation

function Publish-FontChange {
    $HWND_BROADCAST = [IntPtr]0xffff
    $WM_FONTCHANGE = 0x001D
    $result = [UIntPtr]::Zero
    [DevWorkstation.User32]::SendMessageTimeout($HWND_BROADCAST, $WM_FONTCHANGE, [UIntPtr]::Zero, [IntPtr]::Zero, 0, 1000, [ref]$result) | Out-Null
}

function Install-NerdFont {
    param([string]$Url)

    $tempDir = Join-Path $env:TEMP ([System.Guid]::NewGuid())
    New-Item -ItemType Directory -Path $tempDir | Out-Null

    try {
        $archivePath = Join-Path $tempDir "font.zip"
        Invoke-WebRequest -Uri $Url -OutFile $archivePath -UseBasicParsing

        $extractDir = Join-Path $tempDir "extracted"
        Expand-Archive -Path $archivePath -DestinationPath $extractDir -Force

        $fontsDir = Join-Path $env:LOCALAPPDATA "Microsoft\Windows\Fonts"
        New-Item -ItemType Directory -Path $fontsDir -Force | Out-Null

        $registryPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"

        Get-ChildItem -Path $extractDir -Filter "*.ttf" -Recurse | ForEach-Object {
            $sourceFile = $_
            $destPath = Join-Path $fontsDir $sourceFile.Name

            $alreadyInstalled = (Test-Path $destPath) -and
                ((Get-Item $destPath).Length -eq $sourceFile.Length)

            if (-not $alreadyInstalled) {
                try {
                    Copy-Item -Path $sourceFile.FullName -Destination $destPath -Force
                }
                catch {
                    Write-Warning "Skipping $($sourceFile.Name): $($_.Exception.Message)"
                    return
                }
            }

            $fontTitle = "$([System.IO.Path]::GetFileNameWithoutExtension($sourceFile.Name)) (TrueType)"
            New-ItemProperty -Path $registryPath -Name $fontTitle -Value $sourceFile.Name -PropertyType String -Force | Out-Null

            [DevWorkstation.Gdi32]::AddFontResource($destPath) | Out-Null
        }

        Publish-FontChange
    }
    finally {
        Remove-Item -Path $tempDir -Recurse -Force -ErrorAction SilentlyContinue
    }
}

function Set-WindowsTerminalFont {
    param([string]$Name)

    $candidates = @(
        (Join-Path $env:LOCALAPPDATA "Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"),
        (Join-Path $env:LOCALAPPDATA "Microsoft\Windows Terminal\settings.json")
    )

    $settingsPath = $candidates | Where-Object { Test-Path $_ } | Select-Object -First 1

    if (-not $settingsPath) {
        return
    }

    Copy-Item -Path $settingsPath -Destination "$settingsPath.dw-bak" -Force

    $settings = Get-Content -Path $settingsPath -Raw | ConvertFrom-Json

    if (-not $settings.profiles.defaults) {
        $settings.profiles | Add-Member -MemberType NoteProperty -Name "defaults" -Value ([PSCustomObject]@{}) -Force
    }

    if (-not $settings.profiles.defaults.font) {
        $settings.profiles.defaults | Add-Member -MemberType NoteProperty -Name "font" -Value ([PSCustomObject]@{}) -Force
    }

    $settings.profiles.defaults.font | Add-Member -MemberType NoteProperty -Name "face" -Value $Name -Force

    $settings | ConvertTo-Json -Depth 32 | Set-Content -Path $settingsPath -Encoding utf8
}

Install-NerdFont -Url $FontUrl
Set-WindowsTerminalFont -Name $FontName
