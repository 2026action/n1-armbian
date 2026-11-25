# 斐讯 N1 (Phicomm N1 / s905d) 极简 Armbian 固件云端构建

基于 GitHub Actions 的斐讯 N1（Amlogic S905D）极简 Armbian 固件云端编译项目。
本地**不需要任何编译环境**，进入 Actions 页面点击按钮即可在 3~5 分钟内云端出包。

---

## 固件特性

- **极致纯净**：基于官方 Armbian Minimal 精简系统，剔除一切无用工具链与臃肿套件。
- **WiFi / 蓝牙开箱即用**：完整包含斐讯 N1 的博通 BCM43455 无线网卡固件和 DTB 驱动支持。
- **开机即连**：内置 `NetworkManager`、`nmcli`、`nmtui` 与 `wpa_supplicant`。
- **空间充裕**：系统分区仅占用约 2GB，为 N1 自带的 8GB eMMC 腾出 5GB+ 存储空间，方便部署 Docker 及常用轻量服务。
- **ophub 稳定内核**：支持 6.12.y（默认）、6.6.y、6.1.y、5.15.y、5.10.y。

---

## 如何编译

1. 点击仓库上方的 [Actions](https://github.com/2026action/n1-armbian/actions)。
2. 在左侧选择 **`Build N1 Armbian (s905d)`**。
3. 点击右侧的 **`Run workflow`** 下拉按钮：
   - **kernel**：选择内核版本（推荐默认的 `6.12.y` 或 `6.1.y`）
   - **root_mb**：根分区大小（MiB，默认 `2048`）
   - **upload_release**：是否同时发布到 GitHub Releases（默认 `true`）
4. 点击绿色 **`Run workflow`** 开始编译。大约 3~5 分钟后，固件会自动发布在 [Releases](https://github.com/2026action/n1-armbian/releases) 中。

---

## 刷机与使用说明

### 1. 制作启动 U 盘
1. 在 Releases 中下载编译好的 `.img.xz` 文件并解压出 `.img` 镜像。
2. 使用 [Rufus](https://rufus.ie/) 或 [balenaEtcher](https://etcher.balena.io/) 将 `.img` 镜像写入 U 盘（建议使用 USB 2.0 接口的 U 盘）。

### 2. 启动与初始登录
1. 将 U 盘插入 N1 靠近 HDMI 口的 USB 接口，通电开机。
2. 初始登录凭证：
   - 用户名：`root`
   - 默认密码：`1234`
3. 首次登录会提示修改 root 密码并创建一个普通用户（可按 `Ctrl + C` 跳过创建普通用户）。

### 3. 连接 WiFi

可以使用以下任意一种方式连接无线网络：

- **方法 1：图形字符界面（推荐）**
  ```bash
  nmtui
  ```
  选择 **`Activate a connection`** -> 找到你的 WiFi 名称并回车 -> 输入无线密码即可连接。

- **方法 2：命令行连接**
  ```bash
  nmcli device wifi list
  nmcli device wifi connect "你的WiFi名称" password "你的WiFi密码"
  ```

### 4. 固化写入 N1 内置 eMMC（可选）
如果您希望彻底脱离 U 盘运行：
```bash
armbian-install
```
按提示选择对应机型（s905d / N1），等待写入完成即可拔掉 U 盘重启。

---

## 感谢
- [ophub/amlogic-s9xxx-armbian](https://github.com/ophub/amlogic-s9xxx-armbian)
- [Armbian](https://www.armbian.com/)
