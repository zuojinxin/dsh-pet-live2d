# 自维护分支说明（随分支保存）

本仓库是你的 fork：`zuojinxin/dsh-pet-live2d`（fork 自 `A8Chann/dsh-pet-live2d`）。
我们的优化都在分支 **`local/pet-mods`** 上。

## 分支 / 远端
- `upstream` = 作者仓库（只读，只用来同步）
- `origin`   = 你的 fork
- `upstream/main`：作者主线（不要在上面提交）
- `local/pet-mods`：**我们的全部优化**（叠在 upstream/main 上）

## 关键事实
- 作者仓库是 monorepo：插件在 `dsh-live2d-pet/`。
- `dsh-live2d-pet/src/` 只有 `vendor-entry.ts`；**主代码就是 `dsh-live2d-pet/lib/*.js`（手写 JS，无构建覆盖）**，直接改 `lib/` 即最终生效。
- 我们的改动只涉及：`dsh-live2d-pet/lib/client.js`、`dsh-live2d-pet/lib/index.js`。
- 表情/动作/装饰等内容在 `dsh-live2d-pet/pets/`、`model-packs/`，与我们的文件不重叠 → 同步时自动进来。

## 同步作者更新（每次作者发版后）
在**仓库根目录**执行：
```powershell
pwsh -File .\local-maintenance\sync-upstream.ps1
```
流程：`git fetch upstream --tags` → `git checkout local/pet-mods` → `git rebase upstream/main`
→ `node --check` 两个文件 → `git push --force-with-lease origin local/pet-mods`。
- 冲突：解决后 `git add <file>` + `git rebase --continue`。
- 作者已实现同一功能：`git rebase -i upstream/main` 删掉对应提交，只留他没覆盖的差异。

## 每次同步前"探雷"
```powershell
git log --oneline upstream/main -- dsh-live2d-pet/lib/client.js dsh-live2d-pet/lib/index.js
git diff upstream/main..local/pet-mods -- dsh-live2d-pet/lib
```
再读 `dsh-live2d-pet/CHANGELOG.md`，搜关键词：`相位 / 提醒 / 失败 / 中断 / 子代理 / 动作 / 翻转 / 定位 / 缩放`。

## 生成补丁（可移植/备份）
```powershell
git format-patch upstream/main..local/pet-mods -o patches
```

## 安装自维护版（monorepo 子包不能直接 github: 安装）
- 打包 tgz（推荐）：`cd dsh-live2d-pet ; pnpm pack` → `dsh plugin --profile web add <tgz 路径>`
- 或覆盖运行副本：`pwsh -File .\local-maintenance\apply-to-profile.ps1`

## 推送
```powershell
git push --force-with-lease origin local/pet-mods
```
