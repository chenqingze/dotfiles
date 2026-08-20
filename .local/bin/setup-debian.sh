#!/usr/bin/env bash

echo "📦 检测到 Debian/Ubuntu，安装基础工具..."

sudo apt update && sudo apt install -y vim git rsync curl

