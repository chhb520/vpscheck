# VPS 全面巡检报告
## 一键脚本如下：  使用方法：复制脚本 到VPS 回车
```
bash <(curl -sSL https://raw.githubusercontent.com/chhb520/vpscheck/refs/heads/main/check.sh)
```


这是一个 VPS 的巡查脚本输出示例：

```text
============================== VPS 全面巡检报告 生成时间: 2025-08-15 08:16:45
[系统版本] 系统名称: Debian GNU/Linux 版本号: 11 (bullseye)

[系统信息] 系统运行时间: 5 天, 3 小时, 48 分钟 负载平均值: 0.33, 0.17, 0.12 内存使用情况 (MB): total used free shared buff/cache available 

[VPS IP地址]
内网 IPv4地址: 112.16.0.2
公网 IPv4地址: 134.58.216.23
IPv6地址: 2041:4120:303:3e8b::657a:9f7c

[磁盘使用情况]
Filesystem      Size  Used Avail Use% Mounted on
udev            204M     0  204M   0% /dev
tmpfs            46M  504K   46M   2% /run
/dev/sda1       2.9G  2.5G  267M  91% /

[内存占用前 10 进程]
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         193  0.0  9.4  74112 44080 ?        Ss   Aug11   0:32 /lib/syste
root         552  0.0  6.5 1752148 30496 ?       Ssl  Aug11   0:22 /usr/bin/
root         282  0.0  3.9 1243960 18560 ?       Ssl  Aug11   2:46 /opt/nezha
root         513  0.0  3.8 1654252 18040 ?       Ssl  Aug11   2:31 /usr/bin/
root           1  0.0  2.4 102400 11680 ?        Ss   Aug11   1:14 /sbin/init
root      509650  0.3  2.4  18448 11472 ?  

[磁盘使用情况] Filesystem Size Used Avail Use% Mounted on /dev/loop3 13G 3.0G 8.8G 26% /
...
[网络流量统计] 总流量: 0.37 GB 入站流量: 0.20 GB 出站流量: 0.18 GB

巡检完成 ✅ 日志已保存到 /var/log/vps_check_20250815.log
