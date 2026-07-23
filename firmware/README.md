# HLK-RM68 OpenWrt 固件说明

> 官方**没有**在下载中心直接挂 `.img`；固件在厂商 Gitee 指向的百度网盘 **SDK** 内，需编译生成，或向卖家索取现成 `nand-ipq5018-single.img`。

## 官方软件源

| 来源 | 链接 |
|------|------|
| Google Drive（资料 + 软件索引） | https://drive.google.com/drive/folders/1cPfJ_ET9kue43kTUIWVMKmQjL_faICfI |
| Gitee 刷机/编译说明 | https://gitee.com/shenyachuan/rm68 |
| **SDK 百度网盘（20250621）** | https://pan.baidu.com/s/10omz47I9bUNruT9euDZYHQ?pwd=a9pu （提取码 `a9pu`） |

百度网盘内实际文件（已核对）：

```text
20250621/rm68-master.tar.gz   ≈ 3.07 GB   （完整 QSDK，不是现成 .img）
```

目标刷机文件名（**需自行编译**后得到）：

```text
nand-ipq5018-single.img
```

路径（SDK 编译完成后）：`rm68-master/common/build/bin/nand-ipq5018-single.img`

**不要**刷其它机型的 IPQ5018 通用固件（分区/射频不同，易变砖）。  
网盘无现成可刷 `.img`；最快路径是：登录百度下载 SDK，或直接问店铺客服要 `nand-ipq5018-single.img`。

## 默认账号（厂商说明）

| 入口 | 地址/账号 | 密码 |
|------|-----------|------|
| Web | `http://192.168.1.1` | `admin` |
| SSH | `root` | `admin` |
| 串口 | 115200 8N1 | — |

（规格书曾写空密码；以 Gitee README 的 `admin` 为准，以实机为准。）

## 刷机方式 A：U-Boot + TFTP（推荐首次）

1. 电脑有线网卡静态 IP：`192.168.16.112`  
2. 网线接 RM68 底板 **WAN**  
3. TFTPd 根目录指向含 `nand-ipq5018-single.img` 的文件夹  
4. 串口上电，出现 `Hit any key to stop autoboot` 时按键进入 U-Boot  
5. 执行：

```sh
setenv ipaddr 192.168.16.123
setenv serverip 192.168.16.112
setenv bootargs console=ttyMSM0,115200n8
tftpboot nand-ipq5018-single.img
imgaddr=$fileaddr && source $imgaddr:script
```

图示见本目录 `gitee-rm68/image/`。

## 刷机方式 B：系统内 sysupgrade

设备已能 SSH 时：

```sh
# 本机
scp nand-ipq5018-single.img root@192.168.1.1:/tmp/

# 设备上
cd /tmp
sysupgrade nand-ipq5018-single.img
```

## 本仓库已缓存

- `HLK-RM68-drive/`：Drive 上的规格/结构件 + `software reference link.docx`  
- `gitee-rm68/`：官方刷机说明与截图  
- `RM68-SDK-README.md`：README 副本  

**预编译 `.img` 需你从百度网盘下载 SDK 后编译，或向海凌科/店铺客服要现成镜像。** 自动化环境无法绕过百度网盘登录验证码。
