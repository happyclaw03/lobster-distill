#!/bin/bash
# Skill Share - Pack, encrypt, upload
# Usage: bash share.sh <path> [description]
# <path> can be a file or directory

set -e

SRC="$1"
DESC="${2:-Skill package}"
TMPDIR=$(mktemp -d)

if [ -z "$SRC" ]; then
    echo "Usage: bash share.sh <file-or-dir> [description]"
    exit 1
fi

# Generate random password (24 chars, alphanumeric + symbols)
PASSWORD=$(openssl rand -base64 18)

# Determine name
BASENAME=$(basename "$SRC")

if [ -d "$SRC" ]; then
    # Directory: tar it up
    PACKED="$TMPDIR/${BASENAME}.tar.gz"
    tar czf "$PACKED" -C "$SRC" .
    FILETYPE="tar.gz"
    echo "[+] Packed directory: $SRC -> $PACKED"
else
    # Single file: copy as-is
    PACKED="$TMPDIR/$BASENAME"
    cp "$SRC" "$PACKED"
    FILETYPE="file"
    echo "[+] Using file: $SRC"
fi

# Encrypt with AES-256-CBC + PBKDF2
ENCRYPTED="$TMPDIR/${BASENAME}.enc"
openssl enc -aes-256-cbc -pbkdf2 -salt -in "$PACKED" -out "$ENCRYPTED" -k "$PASSWORD"
echo "[+] Encrypted with AES-256-CBC"

# Get file size
SIZE=$(du -h "$ENCRYPTED" | cut -f1)

# Upload to litterbox (24h)
echo "[+] Uploading to litterbox..."
URL=$(curl -s -F "reqtype=fileupload" -F "time=24h" -F "fileToUpload=@$ENCRYPTED" https://litterbox.catbox.moe/resources/internals/api.php)

if [ -z "$URL" ] || echo "$URL" | grep -qi "error"; then
    echo "[-] Upload failed: $URL"
    rm -rf "$TMPDIR"
    exit 1
fi

echo "[+] Uploaded: $URL"

# Clean up
rm -rf "$TMPDIR"

# Output Notes
echo ""
echo "========================================="
echo "  SKILL SHARE NOTES"
echo "========================================="
echo ""
echo "📦 Skill: $DESC"
echo "📁 Source: $BASENAME ($FILETYPE, $SIZE encrypted)"
echo "⏰ Expires: 24 hours from now"
echo ""
echo "--- 转发以下内容给对方 OpenClaw ---"
echo ""

if [ "$FILETYPE" = "tar.gz" ]; then
cat << NOTES
🦞 技能传授包

**技能:** $DESC
**文件:** ${BASENAME}.tar.gz (已加密)
**大小:** $SIZE

**下载与安装步骤：**

\`\`\`bash
# 1. 下载加密文件
curl -o /tmp/${BASENAME}.enc "$URL"

# 2. 解密
openssl enc -aes-256-cbc -d -pbkdf2 -in /tmp/${BASENAME}.enc -out /tmp/${BASENAME}.tar.gz -k "$PASSWORD"

# 3. 解压到技能目录
mkdir -p skills/${BASENAME}
tar xzf /tmp/${BASENAME}.tar.gz -C skills/ 

# 4. 阅读技能文档
cat skills/${BASENAME}/SKILL.md

# 5. 清理临时文件
rm -f /tmp/${BASENAME}.enc /tmp/${BASENAME}.tar.gz
\`\`\`

⏰ 链接24小时后过期，请尽快下载。
NOTES
else
cat << NOTES
🦞 技能传授包

**技能:** $DESC
**文件:** ${BASENAME} (已加密)
**大小:** $SIZE

**下载与安装步骤：**

\`\`\`bash
# 1. 下载加密文件
curl -o /tmp/${BASENAME}.enc "$URL"

# 2. 解密
openssl enc -aes-256-cbc -d -pbkdf2 -in /tmp/${BASENAME}.enc -out /tmp/${BASENAME} -k "$PASSWORD"

# 3. 阅读内容
cat /tmp/${BASENAME}

# 4. 清理
rm -f /tmp/${BASENAME}.enc
\`\`\`

⏰ 链接24小时后过期，请尽快下载。
NOTES
fi

echo ""
echo "--- 转发内容结束 ---"
echo ""
echo "🔑 Password: $PASSWORD"
echo "🔗 URL: $URL"
