# 昔涟（Cyrene）Live2D 桌宠 · 出处与授权

本目录 `pets/cyrene/` 是自维护分支额外加入的一只桌宠（非上游作者自带）。

## 出处 / Attribution
- **Live2D 模型作者**：B 站 UP 主 **是依七哒** — https://space.bilibili.com/457683484
- **模型来源**：随 [Cyrene-Agent](https://github.com/Playa/cyrene-agent) 及其 DSH 移植
  [under-the-ocean/dsh-plugin-cyrene](https://github.com/under-the-ocean/dsh-plugin-cyrene) 分发，
  本项目继承其模型授权（详见同目录 `MODEL_LICENSE.md`、`LICENSE-plugin.md`）。
- **角色 IP**：《崩坏：星穹铁道》昔涟（Cyrene），版权归 **HoYoverse / miHoYo**。

## 授权要点（完整见 `MODEL_LICENSE.md`）
- 模型作者授权：**使用 / 修改 / 再分发 / 衍生**（需署名原作者）。
- **禁止商业用途**；底层角色 IP 不得商用，公开再分发属粉丝同人范畴。
- 本仓库为**非商用**开源项目，按上述条款署名转载。

## 本目录里我们做了什么
- 把动作文件名规范化为 ASCII（`motions/action_0..3.motion3.json`、`Tick3_3.motion3.json`），
  因为插件资源路由只允许 `[A-Za-z0-9._-]`（中文/`#` 文件名会让宠物加载失败）。
- 编写 `pet.json`：7 个装扮槽位、相位动作映射、台词、摸头/摸尾/转圈反应、摸鱼槽位等。
- 表情 `.exp3.json` 与模型文件保持原作者原样（未改动美术）。

## 安装 / 使用
- 随插件安装时，宿主会把它装到 `%DSH_HOME%\pets\cyrene\`；
- 也可手动把本目录复制到 `%DSH_HOME%\pets\cyrene\`；
- 切换宠物：**右键桌宠 → 面板顶部下拉**（多于一只宠物时出现）。
