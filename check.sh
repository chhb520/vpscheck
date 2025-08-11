#!/bin/bash

RED='\033[1;31m'    # 红色加粗
GREEN='\033[32m'
BLUE='\033[34m'
YELLOW='\033[33m'
RESET='\033[0m'

echo -e "${RED}==============================${RESET}"
echo -e "${RED}VPS 全面巡检报告${RESET}"
echo -e "${RED}==============================${RESET}"

# 系统版本
echo -e "${RED}[系统版本]${RESET}"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "系统名称: $NAME"
    echo "版本号: $VERSION"
else
    echo -e "${YELLOW}无法检测系统版本信息${RESET}"
fi
echo

# 系统信息
echo -e "${RED}[系统信息]${RESET}"
echo "系统运行时间: $(uptime -p)"
echo "负载平均值: $(uptime | awk -F'load average:' '{print $2}' | sed 's/^ //')"
echo "内存使用情况 (MB):"
free -m
echo

# 磁盘使用情况
echo -e "${RED}[磁盘使用情况]${RESET}"
df -h
echo

# CPU 占用前 10 进程
echo -e "${RED}[CPU 占用前 10 进程]${RESET}"
ps aux --sort=-%cpu | head -n 11
echo

# 内存占用前 10 进程
echo -e "${RED}[内存占用前 10 进程]${RESET}"
ps aux --sort=-%mem | head -n 11
echo

# 正在运行的 systemd 服务
echo -e "${RED}[正在运行的 systemd 服务]${RESET}"
systemctl list-units --type=service --state=running | head -n 20
echo

# 当前监听端口
echo -e "${RED}[当前监听端口]${RESET}"
ss -tunlp
echo

# Docker 容器状态
echo -e "${RED}[Docker 容器状态]${RESET}"
if command -v docker >/dev/null 2>&1; then
    docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"
else
    echo -e "${YELLOW}Docker 未安装或未运行${RESET}"
fi

echo
echo -e "${GREEN}巡检完成 ✅ 日志保存到 /var/log/vps_check_$(date +%Y%m%d).log${RESET}"
