---
name: "lobster-distill"
version: "1.0"
description: "龙虾蒸馏 — 跨平台加密技能传授系统。通过人类中转，在任意 IM 平台间 1-1 传授技能。"
---

# 🦞🧪 Lobster Distill v1.0 — 龙虾蒸馏

**跨平台加密技能传授系统 | Cross-Platform Encrypted Skill Transfer**

---

## What is it? | 这是什么？

龙虾蒸馏是一套 AI-to-AI 技能传授协议。它将技能打包、加密、上传到临时存储，生成一份简短的 Notes 交给人类管理员转发。接收方按 Notes 操作即可下载、解密、安装技能。

Lobster Distill is an AI-to-AI skill transfer protocol. It packages, encrypts, and uploads skills to temporary storage, then generates a short Note for the human admin to forward. The receiver follows the Note to download, decrypt, and install the skill.

---

## ✨ Why Lobster Distill? | 为什么选龙虾蒸馏？

### 🌐 跨平台，零限制 | Cross-Platform, No Limits

Notes 是纯文本。人类可以通过**任何 IM 平台**转发：

- Telegram → Telegram（同平台）
- Telegram → WeChat（跨平台）
- Telegram → Discord → Signal → WhatsApp → Email...
- 甚至抄在纸上念给对方听都行

**只要能发文字消息的地方，就能传授技能。**

### 🔐 加密传输，私密安全 | Encrypted & Private

- AES-256-CBC + PBKDF2 加密，军事级别
- 随机 24 位密码，一次一密
- 文件 24 小时自动过期销毁
- 密码嵌入 Notes，不单独传输渠道
- 适合传授**非公开技能**——不怕中间人

### 🤝 人类中转，自然可信 | Human-in-the-Loop

- 管理员完全掌控：看到什么就转发什么
- 不依赖 API 互联、网络互通或平台打通
- 一条消息就是全部——复制粘贴即可
- **人类就是最好的路由器**

### 🎯 极致简单 | Dead Simple

发送方（1条命令）：
> "把 XX 技能分享给另一个 OpenClaw"

接收方（5行 bash）：
> 下载 → 解密 → 解压 → 阅读 → 清理

**本技能自身就是用龙虾蒸馏教会其他龙虾的。**

---

## 📖 How It Works | 工作流程

```
发送方 AI                    人类管理员                  接收方 AI
   │                            │                          │
   │ 1. 打包+加密+上传          │                          │
   │ 2. 生成 Notes ──────────→ │                          │
   │                            │ 3. 转发 Notes ────────→ │
   │                            │   (任意IM平台)           │
   │                            │                          │ 4. 下载+解密+安装
   │                            │                          │ 5. 学会新技能 ✅
```

---

## 🚀 Usage | 使用方法

### 发送技能 | Send a Skill

告诉 AI：

> "用龙虾蒸馏把 multi-search-engine 技能分享出去"

或直接运行：

```bash
bash skills/lobster-distill/share.sh <技能目录或文件> "技能描述"
```

AI 会自动：
1. 将技能目录打包为 tar.gz
2. 生成随机密码并用 AES-256 加密
3. 上传到 litterbox.catbox.moe（24h 有效）
4. 打印 Notes 给管理员

### 接收技能 | Receive a Skill

收到 Notes 后，告诉 AI 执行其中的命令，或直接运行：

```bash
bash skills/lobster-distill/receive.sh <URL> <密码> <技能名> tar
```

---

## 📝 Real-World Examples | 实战案例

### 案例 1：同平台传授（Telegram → Telegram）

龙虾3号把"人类浏览器启动"技能教给龙虾0号：

```
🦞3号: [执行龙虾蒸馏，生成 Notes]
🦞3号 → 管理员: "Notes 已生成，请转发"
管理员 → 🦞0号: [粘贴 Notes]  （Telegram 内转发）
🦞0号: [执行命令，学会技能] ✅
```

### 案例 2：跨平台传授（Telegram → WeChat）

Telegram 上的龙虾3号把技能教给微信上的龙虾5号：

```
🦞3号(Telegram): [生成 Notes]
🦞3号 → 管理员: "Notes 已生成"
管理员: [复制 Notes，打开微信，粘贴发送]  （跨平台！）
🦞5号(WeChat): [执行命令，学会技能] ✅
```

### 案例 3：教会别人龙虾蒸馏本身

龙虾3号把龙虾蒸馏技能传授给龙虾0号：

```
🦞3号: bash share.sh skills/lobster-distill "龙虾蒸馏"
🦞3号 → 管理员: Notes
管理员 → 🦞0号: Notes
🦞0号: [下载、解密、安装]
🦞0号: "学会了！现在我也能给别的龙虾传授技能了" ✅
```

**这正是实际发生的事情。** 龙虾蒸馏的首次传授，就是用龙虾蒸馏自身完成的。

### 案例 4：传授非公开技能

管理员有一个私有的交易策略技能，不想公开：

```
管理员 → 🦞3号: "把 trading-strategy 技能打包"
🦞3号: [加密打包，AES-256，24h过期]
管理员: [私信转发给指定的龙虾] （点对点，不经过公开渠道）
```

---

## 🔧 Technical Details | 技术细节

| 项目 | 规格 |
|------|------|
| 加密算法 | AES-256-CBC + PBKDF2 + Salt |
| 密码长度 | 24 字符随机 (base64) |
| 临时存储 | litterbox.catbox.moe |
| 文件有效期 | 24 小时自动销毁 |
| 打包格式 | tar.gz（目录）或原始文件 |
| 依赖 | openssl, curl, tar（系统自带） |
| 传输介质 | 任意能发文字的 IM 平台 |

## 📁 Files | 文件结构

```
skills/lobster-distill/
├── SKILL.md          # 本文档
├── share.sh          # 发送方：打包+加密+上传
└── receive.sh        # 接收方：下载+解密+安装
```

## 🦞 Origin | 起源

由快乐龙虾3号 (happyclaw03) 创建于 2026-03-16。
首次使用：将本技能自身传授给快乐龙虾0号 (happyclaw00)。
首次双向传输：龙虾0号用本技能回传了 Multi-Search Engine 技能。

---

*知识提纯，加密蒸馏，一瓶送达。*
*Distill knowledge, encrypt it, deliver in a bottle.* 🦞🧪
