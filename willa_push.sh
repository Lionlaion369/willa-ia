#!/bin/bash
set -e

echo "=== WILLA PUSH + BUILD AUTOMÁTICO ==="

# 1. Carrega variáveis do .env
if [ -f "backend/.env" ]; then
  export $(grep -v '^#' backend/.env | xargs)
else
  echo "❌ Arquivo .env não encontrado."
  exit 1
fi

# 2. Configura remoto GitHub com token
if git remote | grep -q origin; then
  git remote set-url origin https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/willa-5b1ba.git
else
  git remote add origin https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/willa-5b1ba.git
fi

# 3. Commit + Push
BRANCH=$(git rev-parse --abbrev-ref HEAD)
git add .
git commit -m "Auto: Push Willa build" || echo "ℹ️ Nenhuma mudança nova"
git push -u origin "$BRANCH"

echo "✅ Push enviado (branch $BRANCH)"

# 4. Dispara build Codemagic
if [ -n "$CODEMAGIC_TOKEN" ]; then
  echo "🚀 Disparando build no Codemagic..."
  APP_ID=$(curl -s -H "x-auth-token: $CODEMAGIC_TOKEN" https://api.codemagic.io/apps | jq -r '.[0].appId')
  if [ -n "$APP_ID" ] && [ "$APP_ID" != "null" ]; then
    BUILD_ID=$(curl -s -X POST \
      -H "Content-Type: application/json" \
      -H "x-auth-token: $CODEMAGIC_TOKEN" \
      -d "{\"appId\":\"$APP_ID\",\"branch\":\"$BRANCH\"}" \
      https://api.codemagic.io/builds | jq -r '.buildId')
    echo "✅ Build disparado:"
    echo "🔗 https://codemagic.io/app/$APP_ID/build/$BUILD_ID"
  else
    echo "❌ ERRO: não consegui pegar o APP_ID"
  fi
else
  echo "❌ ERRO: CODEMAGIC_TOKEN não configurado"
fi

echo "=== FINALIZADO ==="
