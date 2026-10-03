[CmdletBinding()]
param(
  [switch]$Build
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$next = Join-Path $root "node_modules\.bin\next.cmd"
$npm = Join-Path $root "node_modules\.bin\npm.cmd"

if (-not (Test-Path $next)) {
  throw "Dependencies are missing. Run 'npm ci' in $root first."
}

Set-Location $root

# Starting a second production server on the same port only produces an opaque
# Next.js error. Treat an existing listener as the already-running local fork.
$listener = Get-NetTCPConnection -LocalPort 30142 -State Listen -ErrorAction SilentlyContinue
if ($listener) {
  Write-Host "Pi Web RU Fork is already running at http://127.0.0.1:30142"
  exit 0
}

if ($Build -or -not (Test-Path (Join-Path $root ".next\BUILD_ID"))) {
  & $npm run build
  if ($LASTEXITCODE -ne 0) { throw "Pi Web production build failed." }
}

# Keep the fork separate from the npm-installed Pi Web (normally port 30141).
& $next start -H 127.0.0.1 -p 30142
