#!/bin/bash

# 定义颜色变量
RED='\033[1;31m'    # 红色加粗
BOLD='\033[1m'      # 粗体
RESET='\033[0m'     # 重置

# 获取当前时间戳
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

# 定义日志文件路径
log_file="/var/log/vps_check_$(date +%Y%m%d).log"

# 函数：输出到终端和日志文件
log_and_echo() {
    echo -e "$@" | tee -a "$log_file"
}

# 清空或创建日志文件
> "$log_file"

# 输出报告头部
log_and_echo "${RED}${BOLD}==============================${RESET}"
log_and_echo "${RED}${BOLD}VPS 全面巡检报告${RESET}"
log_and_echo "${RED}${BOLD}生成时间: $timestamp${RESET}"
log_and_echo "${RED}${BOLD}==============================${RESET}"
log_and_echo ""

# 系统版本信息
log_and_echo "${RED}${BOLD}[系统版本]${RESET}"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    log_and_echo "系统名称: ${NAME:-未知}"
    log_and_echo "版本号: ${VERSION:-未知}"
else
    log_and_echo "无法获取系统版本信息"
fi
log_and_echo ""

# 系统信息
log_and_echo "${RED}${BOLD}[系统信息]${RESET}"
log_and_echo "系统运行时间: $(uptime -p)"
log_and_echo "负载平均值: $(uptime | awk -F 'load average:' '{print $2}' | xargs)"
log_and_echo -e "内存使用情况 (MB):"
free -m | tee -a "$log_file"
log_and_echo ""

# 磁盘使用情况
log_and_echo "${RED}${BOLD}[磁盘使用情况]${RESET}"
df -h | tee -a "$log_file"
log_and_echo ""

# VPS IPv4和IPv6地址
log_and_echo "${RED}${BOLD}[VPS IP地址]${RESET}"
ipv4=$(ip -4 addr show scope global | grep inet | awk '{print $2}' | cut -d/ -f1 | head -n1)
ipv6=$(ip -6 addr show scope global | grep inet6 | awk '{print $2}' | cut -d/ -f1 | head -n1)
log_and_echo "IPv4地址: ${ipv4:-无}"
log_and_echo "IPv6地址: ${ipv6:-无}"
log_and_echo ""

# CPU占用前10进程
log_and_echo "${RED}${BOLD}[CPU 占用前 10 进程]${RESET}"
ps aux --sort=-%cpu | head -n 11 | tee -a "$log_file"
log_and_echo ""

# 内存占用前10进程
log_and_echo "${RED}${BOLD}[内存占用前 10 进程]${RESET}"
ps aux --sort=-%mem | head -n 11 | tee -a "$log_file"
log_and_echo ""

# systemd服务
log_and_echo "${RED}${BOLD}[正在运行的 systemd 服务]${RESET}"
if command -v systemctl &>/dev/null; then
    systemctl list-units --type=service --state=running --no-pager --no-legend | awk '{print $1, $2, $3, $4, $5}' | tee -a "$log_file"
else
    log_and_echo "systemctl 未安装或不可用"
fi
log_and_echo ""

# 当前监听端口
log_and_echo "${RED}${BOLD}[当前监听端口]${RESET}"
ss -tunlp | tee -a "$log_file"
log_and_echo ""

# Docker 容器状态
log_and_echo "${RED}${BOLD}[Docker 容器状态]${RESET}"
if command -v docker &>/dev/null; then
    docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Command}}\t{{.CreatedAt}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}" | tee -a "$log_file"
else
    log_and_echo "Docker 未安装或未运行"
fi
log_and_echo ""

# 网络流量统计
log_and_echo "${RED}${BOLD}[网络流量统计]${RESET}"
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
log_and_echo "总流量: ${total_gb} GB"
log_and_echo "入站流量: ${rx_gb} GB"
log_and_echo "出站流量: ${tx_gb} GB"
log_and_echo ""

# 巡检完成
log_and_echo "${RED}${BOLD}巡检完成 ✅ 日志已保存到 $log_file${RESET}"
