#!/bin/bash
# Send an image as a Telegram document (no compression).
#
# Usage: send_telegram.sh <image_path> [caption] [chat_id]
#
# Token resolution order:
#   1. TELEGRAM_BOT_TOKEN env var
#   2. ~/.hermes/.env  (Hermes Agent users — TELEGRAM_BOT_TOKEN=...)
#   3. ~/.openclaw/openclaw.json  (OpenClaw users — channels.telegram.botToken)
#
# Chat ID resolution order:
#   1. TELEGRAM_CHAT_ID env var
#   2. 3rd positional argument
#   3. ~/.hermes/.env  (TELEGRAM_HOME_CHANNEL=...)

IMAGE_PATH="$1"
CAPTION="${2:-}"
CHAT_ID="${TELEGRAM_CHAT_ID:-$3}"

if [ -z "$IMAGE_PATH" ]; then
  echo "Usage: send_telegram.sh <image_path> [caption] [chat_id]"
  exit 1
fi

# Resolve bot token
if [ -z "$TELEGRAM_BOT_TOKEN" ] && [ -f "$HOME/.hermes/.env" ]; then
  TELEGRAM_BOT_TOKEN=$(grep -E '^TELEGRAM_BOT_TOKEN=' "$HOME/.hermes/.env" | head -1 | cut -d= -f2-)
fi

if [ -z "$TELEGRAM_BOT_TOKEN" ] && [ -f "$HOME/.openclaw/openclaw.json" ]; then
  TELEGRAM_BOT_TOKEN=$(python3 -c "
import json, os
cfg = json.load(open(os.path.expanduser('~/.openclaw/openclaw.json')))
print(cfg['channels']['telegram']['botToken'])
" 2>/dev/null)
fi

if [ -z "$TELEGRAM_BOT_TOKEN" ]; then
  echo "Error: TELEGRAM_BOT_TOKEN not set. Looked in env, ~/.hermes/.env, ~/.openclaw/openclaw.json"
  exit 1
fi

# Resolve chat id — for Hermes users, fall back to TELEGRAM_HOME_CHANNEL
if [ -z "$CHAT_ID" ] && [ -f "$HOME/.hermes/.env" ]; then
  CHAT_ID=$(grep -E '^TELEGRAM_HOME_CHANNEL=' "$HOME/.hermes/.env" | head -1 | cut -d= -f2-)
fi

if [ -z "$CHAT_ID" ]; then
  echo "Error: Set TELEGRAM_CHAT_ID, pass chat_id as 3rd arg, or define TELEGRAM_HOME_CHANNEL in ~/.hermes/.env"
  exit 1
fi

RESPONSE=$(curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendDocument" \
  -F chat_id="${CHAT_ID}" \
  -F document=@"${IMAGE_PATH}" \
  -F caption="${CAPTION}")

OK=$(echo "$RESPONSE" | python3 -c "import sys,json; print(json.load(sys.stdin).get('ok',''))" 2>/dev/null)

if [ "$OK" = "True" ]; then
  echo "✅ Sent to chat ${CHAT_ID}"
else
  echo "❌ Failed: $RESPONSE"
  exit 1
fi
