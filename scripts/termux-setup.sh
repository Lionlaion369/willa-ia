#!/bin/bash
# usage: ./termux-setup.sh your_github_username willa-ia "repo_private_or_public"
USER=$1
REPO=$2
VIS=$3

git init
git branch -M main
git remote add origin git@github.com:$USER/$REPO.git

# Create basic README
cat > README.md <<EOF
# Willa - Super Assistente
Repositório inicial gerado automaticamente.
EOF

git add .
git commit -m "chore: initial scaffold for willa ia"
git push -u origin main
