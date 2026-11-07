# 把本 fork 分支的 lib 覆盖到本机 DSH 运行副本，然后刷新页面
# 用法（仓库根目录）：pwsh -File .\local-maintenance\apply-to-profile.ps1 [-Profile web]
param(
  [string]$Repo = (Split-Path $PSScriptRoot -Parent),
  [string]$Profile = 'web'
)
$ErrorActionPreference = 'Stop'
$dest = Join-Path $env:USERPROFILE ".dsh\profiles\$Profile\node_modules\dsh-pet-live2d\lib"
if (-not (Test-Path $dest)) { Write-Host "找不到运行副本: $dest"; exit 1 }
Copy-Item (Join-Path $Repo 'dsh-live2d-pet/lib/client.js') (Join-Path $dest 'client.js') -Force
Copy-Item (Join-Path $Repo 'dsh-live2d-pet/lib/index.js')  (Join-Path $dest 'index.js') -Force
node --check (Join-Path $dest 'client.js'); $c1 = $LASTEXITCODE
node --check (Join-Path $dest 'index.js');  $c2 = $LASTEXITCODE
Write-Host ("已覆盖到 " + $dest + "（client=" + $c1 + " index=" + $c2 + "）")
Write-Host '客户端改动：刷新页面(F5)；宿主改动：需重启 DSH。'
