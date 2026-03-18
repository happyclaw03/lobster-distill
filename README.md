# 🦞🧪 Lobster Distill

**Cross-platform encrypted skill transfer for OpenClaw agents.**

[English](README.md) | [中文](README_CN.md)

## Quick Start

**Send a skill:**
```bash
bash share.sh <skill-directory> "description"
```

**Receive a skill:**
```bash
bash receive.sh <url> <password> <name> tar
```

See [SKILL.md](SKILL.md) for full documentation.

## Features

- 🌐 **Cross-platform** — Works across any IM: Telegram, WeChat, Discord, Signal, Email...
- 🔐 **AES-256 encrypted** — One-time passwords, secure transfer
- ⏰ **24h auto-expire** — Files self-destruct after 24 hours
- 🤝 **Human-in-the-loop** — Admin controls everything via copy-paste
- 🎯 **Dead simple** — 1 command to send, 5 lines to receive
- 📦 **Zero dependencies** — Only uses openssl, curl, tar (system built-in)

## Why Lobster Distill?

| Feature | Lobster Distill 🦞 | Google A2A | ClawHub Publish |
|---|---|---|---|
| Cross-platform | ✅ Any IM | ❌ API only | ✅ Web |
| Human oversight | ✅ Required | ❌ AI-to-AI direct | ❌ Auto-install |
| Private skills | ✅ Point-to-point | ❌ Needs API | ❌ Public only |
| Encryption | ✅ AES-256 | Depends | ❌ Plain |
| Dependencies | None (system tools) | SDK + API | npm + network |

## How It Works

```
Sender AI          Human Admin         Receiver AI
   │                    │                    │
   │ 1. Pack+Encrypt    │                    │
   │ 2. Generate Notes →│                    │
   │                    │ 3. Forward Notes → │
   │                    │                    │ 4. Download+Decrypt+Install
   │                    │                    │ 5. New skill learned ✅
```

## Security

- **Human-in-the-loop**: Nothing transfers without a human explicitly forwarding the Notes
- **AES-256-CBC + PBKDF2**: Encryption with random one-time passwords
- **24h auto-delete**: Uploaded files self-destruct after 24 hours
- **No direct AI-to-AI connection**: Unlike API-based protocols, agents never connect directly
- **Temp file cleanup only**: Scripts only delete their own temp files in `/tmp/`

## Install via ClawHub

```bash
npx clawhub@latest install qiaoy01/lobster-distill
```

## License

MIT — See [LICENSE](LICENSE)

---

*Distill knowledge, encrypt it, deliver in a bottle.* 🦞🧪
