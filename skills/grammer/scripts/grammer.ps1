# grammer.ps1 – run Harper + write-good on a file, or check/update bundled resources.
# Usage: powershell -File grammer.ps1 -Path <file> | -Check | -Update
param([string]$Path, [switch]$Check, [switch]$Update)
$ErrorActionPreference = 'Stop'
$root   = Split-Path $PSScriptRoot -Parent
$vendor = Join-Path $root 'vendor'
$mfile  = Join-Path $vendor 'MANIFEST.json'
$bin    = Join-Path $env:USERPROFILE '.local\bin'
# Pick up tools installed after this shell started.
$env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User') + ";$bin"

$harperFiles = 'dictionary.dict','annotations.json','irregular_nouns.json','irregular_verbs.json','proper_noun_rules.json','default_config.json'
$wgPkgs      = 'weasel-words','passive-voice','no-cliches','too-wordy','adverb-where','e-prime'

if ($Check -or $Update) {
  $have = if (Test-Path $mfile) { (Get-Content $mfile -Raw | ConvertFrom-Json).versions } else { $null }
  $latest = [ordered]@{ harper = (Invoke-RestMethod https://api.github.com/repos/Automattic/harper/releases/latest).tag_name }
  foreach ($p in @('write-good') + $wgPkgs) { $latest[$p] = (Invoke-RestMethod "https://registry.npmjs.org/$p/latest").version }
  $stale = @($latest.Keys | Where-Object { -not $have -or $have.$_ -ne $latest[$_] })
  if (-not $stale) { 'Up to date.'; exit 0 }
  foreach ($k in $stale) { "STALE: $k  have=$(if ($have) { $have.$k } else { 'none' })  latest=$($latest[$k])" }
  if ($Check) { exit 1 }

  # Harper: data files + licence at the release tag, and the matching CLI binary.
  $tag = $latest.harper
  $hv = Join-Path $vendor 'harper'; New-Item -ItemType Directory -Force $hv | Out-Null
  foreach ($f in $harperFiles) { Invoke-WebRequest "https://raw.githubusercontent.com/Automattic/harper/$tag/harper-core/$f" -OutFile (Join-Path $hv $f) }
  Invoke-WebRequest "https://raw.githubusercontent.com/Automattic/harper/$tag/LICENSE" -OutFile (Join-Path $hv 'LICENSE')
  $zip = Join-Path $env:TEMP 'harper-cli.zip'
  Invoke-WebRequest "https://github.com/Automattic/harper/releases/download/$tag/harper-cli-x86_64-pc-windows-msvc.zip" -OutFile $zip
  New-Item -ItemType Directory -Force $bin | Out-Null
  Expand-Archive $zip -DestinationPath $bin -Force; Remove-Item $zip

  # write-good: reinstall latest from npm, then copy it and its word-list packages into vendor/.
  npm install -g write-good@latest --silent | Out-Null
  $wgSrc = Join-Path (npm root -g) 'write-good'
  $wv = Join-Path $vendor 'write-good'
  if (Test-Path $wv) { Remove-Item $wv -Recurse -Force }
  New-Item -ItemType Directory -Force $wv | Out-Null
  Copy-Item (Join-Path $wgSrc 'lib'), (Join-Path $wgSrc 'LICENSE'), (Join-Path $wgSrc 'package.json') $wv -Recurse
  foreach ($p in $wgPkgs) {
    $src = @((Join-Path $wgSrc "node_modules\$p"), (Join-Path (npm root -g) $p)) | Where-Object { Test-Path $_ } | Select-Object -First 1
    Copy-Item $src (Join-Path $wv $p) -Recurse
  }
  # passive-voice and weasel-words ship no LICENSE file; record each package's declared licence.
  $licences = [ordered]@{ harper = 'Apache-2.0' }
  foreach ($p in @('write-good') + $wgPkgs) {
    $pj = if ($p -eq 'write-good') { Join-Path $wv 'package.json' } else { Join-Path $wv "$p\package.json" }
    $licences[$p] = (Get-Content $pj -Raw | ConvertFrom-Json).license
  }
  # Keep only word lists, check logic and licences; the fallback reads nothing else.
  Get-ChildItem $wv -Recurse -Force |
    Where-Object { $_.Name -in '.github','spec','test','.eslintrc','.travis.yml','README.md','package.json','matcher.js','annotate.js' } |
    Remove-Item -Recurse -Force

  # Manifest: versions, commit and a SHA-256 for every vendored file.
  $commit = (Invoke-RestMethod "https://api.github.com/repos/Automattic/harper/commits/$tag").sha
  $files = Get-ChildItem $vendor -Recurse -File | Where-Object Name -ne 'MANIFEST.json' | ForEach-Object {
    [ordered]@{ path = $_.FullName.Substring($vendor.Length + 1) -replace '\\','/'; sha256 = (Get-FileHash $_.FullName).Hash.ToLower() }
  }
  [ordered]@{
    fetched  = (Get-Date -Format 'yyyy-MM-dd')
    versions = $latest
    licences = $licences
    harper   = "https://github.com/Automattic/harper/tree/$commit"
    files    = @($files)
  } | ConvertTo-Json -Depth 5 | Set-Content $mfile -Encoding utf8
  "Updated: $($stale -join ', ')"
  exit 0
}

if (-not $Path -or -not (Test-Path $Path)) { throw "Usage: grammer.ps1 -Path <file> | -Check | -Update" }
$userDict = Join-Path $root 'user-dict.txt'
# harper-cli writes status notes to stderr; under Stop, PowerShell 5.1 would abort on them.
$ErrorActionPreference = 'Continue'

'=== HARPER ==='
if (Get-Command harper-cli -ErrorAction SilentlyContinue) {
  # Exit code 1 just means lints were found.
  harper-cli lint -d british --format compact --no-color --quiet -u $userDict $Path 2>$null
} else { 'MISSING: harper-cli' }

'=== WRITE-GOOD ==='
if (Get-Command write-good -ErrorAction SilentlyContinue) {
  write-good --parse $Path
} else { 'MISSING: write-good' }
exit 0
