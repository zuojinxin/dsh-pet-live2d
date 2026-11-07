# 同步作者更新到自维护分支：fetch upstream -> rebase -> 语法检查 -> 推 fork
# 用法（仓库根目录）：pwsh -File .\local-maintenance\sync-upstream.ps1
param(
  [string]$Repo = (Split-Path $PSScriptRoot -Parent)
)
$ErrorActionPreference = 'Stop'
if (-not (Test-Path (Join-Path $Repo '.git'))) { Write-Host "找不到仓库: $Repo"; exit 1 }
Push-Location $Repo
try {
  Write-Host '== fetch upstream =='
  git fetch upstream --tags
  Write-Host '== checkout local/pet-mods =='
  git checkout local/pet-mods
  Write-Host '== rebase onto upstream/main =='
  git rebase upstream/main
  if ($LASTEXITCODE -ne 0) {
    Write-Host ''
    Write-Host '!! rebase 有冲突：解决冲突文件后执行  git add <file> ; git rebase --continue'
    Write-Host '   若作者已实现同一功能，可用  git rebase -i upstream/main  删除对应提交。'
    exit 2
  }
  Write-Host '== node --check =='
  node --check 'dsh-live2d-pet/lib/client.js'; $c1 = $LASTEXITCODE
  node --check 'dsh-live2d-pet/lib/index.js';  $c2 = $LASTEXITCODE
  if ($c1 -ne 0 -or $c2 -ne 0) { Write-Host '语法检查失败，先修再推送'; exit 3 }
  Write-Host '== push to origin =='
  git push --force-with-lease origin local/pet-mods
  Write-Host '同步完成。'
} finally {
  Pop-Location
}
