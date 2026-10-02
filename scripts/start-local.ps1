$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

# Kept on a separate loopback port while the npm-installed Pi Web may still use 30141.
& (Join-Path $root "node_modules\.bin\next.cmd") start -H 127.0.0.1 -p 30142
