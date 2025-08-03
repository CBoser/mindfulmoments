#!/bin/bash
set -e
if [ -z "$1" ]; then
  echo "Usage: ./deploy.sh git@github.com:yourusername/mindfulmoments.git"
  exit 1
fi

git init
git add .
if git rev-parse --verify main >/dev/null 2>&1; then
  git checkout main
else
  git checkout -b main
fi
git commit -m "Initial commit"
git remote add origin "$1" || true
git push -u origin main
