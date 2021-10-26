---
title: windows 开发环境配置指引
date: 2020-11-18 15:20:27
---
## 1. win10 系统的安装

> 扩展阅读 > [微软关于安装 Windows 的介绍](https://docs.microsoft.com/zh-cn/windows-hardware/manufacture/desktop/boot-and-install-windows)

### 1.1 Ventoy 启动U盘制作 > [github 项目地址](https://github.com/ventoy/Ventoy)

### 1.2 纯净版镜像下载 > [MSDN Itell You](https://msdn.itellyou.cn/)

### 1.3 区分 BIOS 启动模式 UEFI 或 Legacy

* UEFI 新式的用于替代 BIOS 的方案, 需要 GPT(GUID) 硬盘分区
* Legacy 传统的旧版 BIOS 模式, 需要 MBR 硬盘分区
* 如何打开设置，看主板制造商的设计(常见的有 Esc, Delete, F1, F2, F10, F11, F12)
* [参考文档](https://docs.microsoft.com/zh-cn/windows-hardware/manufacture/desktop/boot-to-uefi-mode-or-legacy-bios-mode)

### 1.4 硬盘分区样式 GPT(GUID) 和 MBR

* [参考文档](https://docs.microsoft.com/zh-cn/windows-server/storage/disk-management/initialize-new-disks)
* 装机时, 可按Shift + F10 打开cmd程序, 借由 diskpart 将 MBR 磁盘转换为 GPT 磁盘

```shell
diskpart
list disk
select disk <disknumber>
clean // 运行 clean 命令将删除磁盘上的所有分区或卷。
convert gpt // 将 MBR 分区样式转换为具有 GUID 分区表 (GPT) 分区样式
```

## 2. win10 系统的激活

### 2.1 两种激活方式 KMS 和 数字权利

* KMS 激活有效期 180 天, 到期需重新激活
* 数字权利激活, 有效期永久.

### 2.2 KMS激活

* 部署 KMS 服务 > [github项目参考](https://github.com/Wind4/vlmcsd/tree/gh-pages)
* 查阅待激活系统的 KMS key > [微软官方文档](https://docs.microsoft.com/en-us/windows-server/get-started/kmsclientkeys)
* 运行激活命令(需以管理员身份)

```shell
slmgr.vbs -ipk NRG8B-VKK3Q-CXVCJ-9G2XF-6Q84J
slmgr.vbs -skms kms.codiy.net
slmgr.vbs -ato
```

## 3. win10 基础设置

### 3.1 设置允许 Ipsec 协议 VPN 连接

* 打开注册表编辑器
* 找到注册表 HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PolicyAgent
* 添加新变量 AssumeUDPEncapsulationContextOnSendRule 类型 DWORD 值为 2
* 重启 windows

### 3.2 安装 .NET Framework > [参考文档](https://zhuanlan.zhihu.com/p/27871616)

* win10 默认已预装 .NET Framework 4.x 版本, 部分应用程序仍使用 3.x 版本
* 4.x 版本并未全部与 3.x 版本兼容, 因此最好将 3.5 版本也一起安装
* 3.5 版本安装方法参考 > [微软官方文档](https://docs.microsoft.com/zh-cn/dotnet/framework/install/dotnet-35-windows-10)

### 3.3 安装 PowerToys 设置键盘映射(建议从 github 下载安装)

### 3.4 安装 scoop (可选安装choco, winget)

* scoop 需开启代理，否则几乎用不了
* 管理员身份运行 PowerShell

```shell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex
scoop install git
```

### 3.5 安装 chrome 浏览器

```shell
scoop bucket add extras
scoop install googlechrome
```

### 3.6 安装 Cascadia Code PL 字体

* 方式1: 使用 scoop 安装

```shell
scoop search Cascadia
scoop bucket add 'nerd-fonts'
scoop install Cascadia-Code
```

* 方式2: github 下载 ttf 文件安装 > [gitbub 项目地址](https://github.com/microsoft/cascadia-code/releases)

### 3.7 开启 WSL2 并安装 Ubuntu 子系统 > [参考文档](https://docs.microsoft.com/zh-cn/windows/wsl/install-win10)

* 开启wsl并启用"虚拟机平台"功能

```shell
// 管理员身份运行 PowerShell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

* 重启 windows 系统后 下载并安装内核更新包 > [下载地址](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)
* 将 wsl2 设置为默认版本

```shell
// 管理员身份运行 PowerShell
wsl --set-default-version 2
```

* 从 Miscrosoft Store 安装 Linux 分发版

  `搜索并安装 Ubuntu, 安装完后启动并设置用户名密码`

* 为 wsl 设置默认分发版

```shell
// 管理员身份运行 PowerShell
wsl --set-version Ubuntu 2
```

### 3.8 安装vscode

```shell
scoop bucket add extras
scoop install vscode
```

### 3.9 安装 Windows Terminal (建议从 Microsoft Store 安装)

* PowerShell 终端的设置, 启用 oh-my-posh 并设置 Powerline > [官方文档](https://docs.microsoft.com/zh-cn/windows/terminal/tutorials/powerline-setup)

```shell
// 管理员身份运行 Windows Terminal
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
```

```text
// 在 notepad $PROFILE 打开的文本中粘贴以下文本
Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox
```

```json
// 编辑 Windows Terminal 的 settings.json 文件
// "defaults":
    {
        // Put settings here that you want to apply to all profiles.
        "colorScheme": "Solarized Dark",
        "acrylicOpacity": 0.7,
        "useAcrylic": true,
        "fontSize": 14,
        "fontFace": "Cascadia Code PL"
    }
```

## 4. Ubuntu 子系统配置 > [参见 linux 环境搭建](./linux-on-wsl.md)

## 5. 安装 Docker Desktop for Windows

* 在开启 wsl2 之后在安装 docker-desktop

## 6. 安装 gopass > [参考文档](https://github.com/gopasspw/gopass)

* 安装

```shell
scoop install gpg4win
scoop install gopass
```

* 导入 gpg 私钥
* 导入私密文档库(需先git clone 把服务器指纹写入know_hosts, gopass无法自动处理) `gopass clone git@github.com:codiy1992/secrets.git`
* [可选]下载 gopass gui客户端 > [版本列表](https://github.com/codecentric/gopass-ui/releases)
* 配合 chrome 插件使用(在gopass安装目录处执行) `./gopass-jsonapi configure`

## 7. 安装其他软件

* 下载解压缩软件 > [7-zip](https://www.7-zip.org/)
* 下载杀毒软件电脑管家 > [官网地址](https://guanjia.qq.com/)
* 下载RDM(从 Miscrosoft Store 下载)
* 下载navicat(在Onedrive)
* 开发工具: `scoop install postman`
* 聊天软件: wechat, wxwork, dingtalk, qq, `scoop install slack`, `scoop install telegram`
* 音乐客户端：网易云音乐
* 截屏贴图工具 [snipaste 官网](https://www.snipaste.com/)
* 效率工具 utools


## 8. 开启 hyper-v 功能

```shell
// 管理员身份执行
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
```

## 9. Office2019 专业增强版的安装与激活

* 下载 Office 部署工具(setup.exe) > [Office Deployment Tool](https://www.microsoft.com/en-us/download/details.aspx?id=49117)
* 创建并导出 Office 部署配置文件或使用下面的配置(仅安装 Word, Excel, PowerPoint) > [Office 自定义工具](https://config.office.com/deploymentsettings)

```xml
<Configuration ID="21f6a4d7-1d22-431d-b31c-024723327677">
  <Add OfficeClientEdition="64" Channel="PerpetualVL2019">
    <Product ID="ProPlus2019Volume" PIDKEY="NMMKJ-6RK4F-KMJVX-8D9MJ-6MWKP">
      <Language ID="MatchOS" />
      <ExcludeApp ID="Access" />
      <ExcludeApp ID="Groove" />
      <ExcludeApp ID="Lync" />
      <ExcludeApp ID="OneDrive" />
      <ExcludeApp ID="OneNote" />
      <ExcludeApp ID="Outlook" />
      <ExcludeApp ID="Publisher" />
    </Product>
  </Add>
  <Property Name="SharedComputerLicensing" Value="0" />
  <Property Name="PinIconsToTaskbar" Value="FALSE" />
  <Property Name="SCLCacheOverride" Value="0" />
  <Property Name="AUTOACTIVATE" Value="0" />
  <Property Name="FORCEAPPSHUTDOWN" Value="FALSE" />
  <Property Name="DeviceBasedLicensing" Value="0" />
  <Updates Enabled="FALSE" />
  <RemoveMSI />
  <Logging Level="Off" />
</Configuration>
```

* 安装 Office2019

```shell
// powershell执行
setup.exe /configure xxxxx.xml
```

* 激活 Office2019 > [产品 GVLK 对照表](https://github.com/Wind4/vlmcsd/tree/gh-pages)

```shell
cd 'C:\Program Files\Microsoft Office\Office16'
cscript ospp.vbs /inpkey:NMMKJ-6RK4F-KMJVX-8D9MJ-6MWKP
cscript ospp.vbs /sethst:kms.codiy.net
cscript ospp.vbs /act
```

## 10. 安装 vcxsrv 让 wsl ubuntu 系统内的应用窗口显示在 windows 中

* 安装 `scoop install vcxsrv`
* 设置 > 在 `控制面板\系统和安全\Windows Defender 防火墙\允许的应用` 勾选 所有 vcxsrv.exe 应用并允许其使用"专用"或"公用"网络
* 运行 xlaunch.exe 开启 xlaunch 服务进程以接收来自 ubuntu 子系统的应用显示
* 配置 xluanch 快捷方式 `C:\Users\codiy\scoop\apps\vcxsrv\current\xlaunch.exe -ArgumentList -run C:\Users\codiy\scoop\apps\vcxsrv\current\config.xlaunch`
* 配置开机启动, 将快捷方式复制一份到 `%programdata%\Microsoft\Windows\Start Menu\Programs\Startup`