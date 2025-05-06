#!/bin/bash

# Настройки
REPO_URL="https://github.com/raeeduard/shvirtd-example-python.git"
TARGET_DIR="/opt/your_project"

# Установка зависимостей
sudo apt update
sudo apt install -y git

# Клонирование репозитория
if [ ! -d "$TARGET_DIR" ]; then
  sudo mkdir -p "$TARGET_DIR"
  sudo chown -R $USER:$USER "$TARGET_DIR"
  git clone "$REPO_URL" "$TARGET_DIR"
else
  echo "Директория $TARGET_DIR уже существует. Обновляю репозиторий..."
  cd "$TARGET_DIR" && git pull
fi

# Запуск проекта через Docker Compose
cd "$TARGET_DIR"
if [ -f "compose.yaml" ]; then
  docker compose up -d --build
  echo "Проект запущен в фоновом режиме."
else
  echo "Ошибка: compose.yaml не найден в $TARGET_DIR!"
  exit 1
fi
