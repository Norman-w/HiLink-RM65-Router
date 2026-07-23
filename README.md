# HiLink RM68 — 家用 WiFi 行为管理路由研究

基于海凌科 **HLK-RM68**（IPQ5018 + QCA8337 + QCN6102，Wi‑Fi 6 AX3000）的自研路由可行性评估。

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

官方下载页：https://h.hlktech.com/Mobile/download/FDetail/348.html

| 文件 | 说明 |
|------|------|
| `docs/HLK-RM68-规格书-V1.02.pdf` | 产品规格书 |
| `docs/HLK-RM68-结构件规格书.zip` | BTB / 屏蔽罩 / 散热片 |
| `docs/HLK-AX3000-KIT-V1.0.zip` | 开发套件原理图与 PCB |
| `docs/extracted/` | 已解压与文本提取 |

## 推荐架构（行为管理）

```
光猫 → Mac mini / N100（策略网关）→ 交换机 → AP（商业 AP 或 RM68 AP 模式）
```

轻量一体方案：光猫 → RM68（OpenWrt + DNS/防火墙级管控）。
