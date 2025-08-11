#!/bin/bash

RED='\033[1;31m'       # 红色加粗
BOLD='\033[1m'         # 粗体
RESET='\033[0m'

timestamp=$(date +"%Y-%m-%d %H:%M:%S")

echo -e "${RED}${BOLD}==============================${RESET}"
echo -e "${RED}${BOLD}VPS 全面巡检报告${RESET}"
echo -e "${RED}${BOLD}生成时间: $timestamp${RESET}"
echo -e "${RED}${BOLD}==============================${RESET}"
echo

# 系统版本信息
echo -e "${RED}${BOLD}[系统版本]${RESET}"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    echo "系统名称: $NAME"
    echo "版本号: $VERSION"
else
    echo "无法获取系统版本信息"
fi
echo

# 系统信息
echo -e "${RED}${BOLD}[系统信息]${RESET}"
echo "系统运行时间: $(uptime -p)"
echo "负载平均值: $(uptime | awk -F 'load average:' '{print $2}' | xargs)"
echo -e "内存使用情况 (MB):"
free -m
echo

# 磁盘使用情况
echo -e "${RED}${BOLD}[磁盘使用情况]${RESET}"
df -h
echo

# VPS IPv4和IPv6地址
echo -e "${RED}${BOLD}[VPS IP地址]${RESET}"
ipv4=$(ip -4 addr show scope global | grep inet | awk '{print $2}' | cut -d/ -f1 | head -n1)
ipv6=$(ip -6 addr show scope global | grep inet6 | awk '{print $2}' | cut -d/ -f1 | head -n1)
echo "IPv4地址: ${ipv4:-无}"
echo "IPv6地址: ${ipv6:-无}"
echo

# CPU占用前10进程
echo -e "${RED}${BOLD}[CPU 占用前 10 进程]${RESET}"
ps aux --sort=-%cpu | head -n 11
echo

# 内存占用前10进程
echo -e "${RED}${BOLD}[内存占用前 10 进程]${RESET}"
ps aux --sort=-%mem | head -n 11
echo

# systemd服务
echo -e "${RED}${BOLD}[正在运行的 systemd 服务]${RESET}"
systemctl list-units --type=service --state=running --no-pager --no-legend | awk '{print $1, $2, $3, $4, $5}'
echo

# 当前监听端口
echo -e "${RED}${BOLD}[当前监听端口]${RESET}"
ss -tunlp
echo

# Docker 容器状态
echo -e "${RED}${BOLD}[Docker 容器状态]${RESET}"
if command -v docker &>/dev/null; then
    docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Command}}\t{{.CreatedAt}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"
else
    echo "Docker 未安装或未运行"
fi
echo

# 网络流量统计
echo -e "${RED}${BOLD}[网络流量统计]${RESET}"

rx_total=0
tx_total=0
while read -r line; do
    iface=$(echo "$line" | awk -F':' '{print $1}' | tr -d ' ')
    # 排除回环和虚拟网卡
    if [[ "$iface" == "lo" ]] || [[ "$iface" == docker* ]] || [[ "$iface" == veth* ]] || [[ "$iface" == br* ]]; then
        continue
    fi
    rx_bytes=$(echo "$line" | awk '{print $2}')
    tx_bytes=$(echo "$line" | awk '{print $10}')
    rx_total=$((rx_total + rx_bytes))
    tx_total=$((tx_total + tx_bytes))
done < <(tail -n +3 /proc/net/dev)

rx_gb=$(awk "BEGIN {printf \"%.2f\", $rx_total/1024/1024/1024}")
tx_gb=$(awk "BEGIN {printf \"%.2f\", $tx_total/1024/1024/1024}")
total_gb=$(awk "BEGIN {printf \"%.2f\", ($rx_total+$tx_total)/1024/1024/1024}")

echo "总流量: ${total_gb} GB"
echo "入站流量: ${rx_gb} GB"
echo "出站流量: ${tx_gb} GB"
echo

echo -e "${RED}${BOLD}巡检完成 ✅ 日志保存到 /var/log/vps_check_$(date +%Y%m%d).log${RESET}"
