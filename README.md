# HiLink RM65 — 家用 WiFi 行为管理路由研究

基于海凌科 **HLK-RM65**（MT7981B + MT7976C + MT7531A，Wi‑Fi 6 AX3000 / 联发科方案）的自研路由可行性评估。  
（早期曾评估 RM68 高通方案，相关资料保留在 `docs/`、`firmware/` 供对照。）

## 结论摘要

| 问题 | 结论 |
|------|------|
| 能媲美家用 AX3000 WiFi 吗？ | **硬件档位可以**；天线/固件卸载/结构做好后接近同级成品 |
| 只适合研究吗？ | **否**；规格定位含家用路由/Mesh/网关 |
| 适合重度行为管理吗？ | **单独不够**（256MB + 双 A53）；策略建议上移 |
| Mac mini + AP 怎样？ | **算力与策略远强**；WiFi 靠专业 AP，勿用 Mac 内置无线当主 AP |

详见：

- [docs/评估报告-家用WiFi行为管理可行性.md](docs/评估报告-家用WiFi行为管理可行性.md)
- [docs/架构-MAC分流旁路分析.md](docs/架构-MAC分流旁路分析.md) — RM68 轻转发 + MacBook 旁路分析

## 资料

### HLK-RM65（主资料）

官方下载页：https://h.hlktech.com/Mobile/download/FDetail/257.html  
清单：`docs/download-manifest-rm65.json`

| 文件 | 说明 |
|------|------|
| `docs/HLK-RM65-规格书-V1.31.pdf` | 产品规格书 |
| `docs/HLK-RM65结构器件规格书.zip` | BTB / 产品图 / 表贴螺柱 |
| `docs/RM65封装尺寸.pdf` | 模组封装尺寸 |
| `docs/HLK-RM65尺寸图.png` | 尺寸图（含安装孔标注） |
| `docs/HLK-RM65-KIT-V1.0.zip` | 开发套件原理图与 PCB |
| `docs/HLK-RM65-KIT-V1.0-原理图.pdf` | KIT 原理图 PDF |
| `docs/HLK-RM65-KIT-Dimension.PcbDoc.zip` | KIT 尺寸标注 PCB（外壳开孔关键） |
| `docs/RM65编译资料.pdf` | 编译资料 |
| `docs/extracted/` | 已解压与文本提取 |

### HLK-RM68（对照保留）

官方下载页：https://h.hlktech.com/Mobile/download/FDetail/348.html

| 文件 | 说明 |
|------|------|
| `docs/HLK-RM68-规格书-V1.02.pdf` | 产品规格书 |
| `docs/HLK-RM68-结构件规格书.zip` | BTB / 屏蔽罩 / 散热片 |
| `docs/HLK-AX3000-KIT-V1.0.zip` | 开发套件原理图与 PCB |
| `firmware/README.md` | OpenWrt/SDK 下载与刷机说明 |

固件 SDK（百度）：https://pan.baidu.com/s/10omz47I9bUNruT9euDZYHQ?pwd=a9pu （`rm68-master.tar.gz` ≈3.07GB）

## 推荐架构（行为管理）

```
光猫 → Mac mini / N100（策略网关）→ 交换机 → AP（商业 AP 或 RM65 AP 模式）
```

轻量一体方案：光猫 → RM65（OpenWrt + DNS/防火墙级管控）。
