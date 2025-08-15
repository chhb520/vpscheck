# VPS 全面巡检报告

这是一个 VPS 的巡查脚本输出示例：

```text
============================== VPS 全面巡检报告 生成时间: 2025-08-15 08:16:45
[系统版本] 系统名称: Debian GNU/Linux 版本号: 11 (bullseye)

[系统信息] 系统运行时间: 5 天, 3 小时, 48 分钟 负载平均值: 0.33, 0.17, 0.12 内存使用情况 (MB): total used free shared buff/cache available Mem: 122 39 14 0 67 82 Swap: 0 0 0

[磁盘使用情况] Filesystem Size Used Avail Use% Mounted on /dev/loop3 13G 3.0G 8.8G 26% / ...
...
[网络流量统计] 总流量: 0.37 GB 入站流量: 0.20 GB 出站流量: 0.18 GB

巡检完成 ✅ 日志已保存到 /var/log/vps_check_20250815.log
