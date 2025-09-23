# Willa IA – Super Assistente Pessoal

Este repositório contém o código do projeto **willa-5b1ba**, uma IA Geral integrada com:
- Flutter (app Android/iOS)
- Node.js (backend proxy)
- Firebase (auth, storage, realtime)
- OpenAI GPT (Willa Suprema)
- Codemagic (CI/CD para APK)

## Estrutura
- `app/` → aplicativo Flutter
- `server/` → backend Node.js
- `infra/` → CI/CD e deploy
- `scripts/` → automações (Termux, setup)

## Rodando localmente
1. Configure o arquivo `.env` com suas chaves.
2. Suba o backend:  
   ```bash
   cd server && npm install && npm start
