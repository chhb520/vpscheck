## 这是一个VPS的巡查脚本
==============================
VPS 全面巡检报告
生成时间: 2025-08-15 08:16:45
==============================

[系统版本]
系统名称: Debian GNU/Linux
版本号: 11 (bullseye)

[系统信息]
系统运行时间: 5 天, 3 小时, 48 分钟
负载平均值: 0.33, 0.17, 0.12
内存使用情况 (MB):
               total        used        free      shared  buff/cache   available
Mem:             122          39          14           0          67          82
Swap:              0           0           0

[磁盘使用情况]
Filesystem      Size  Used Avail Use% Mounted on
/dev/loop3       13G  3.0G  8.8G  26% /
none            492K  4.0K  488K   1% /dev
udev            462M     0  462M   0% /dev/tty
tmpfs           100K     0  100K   0% /dev/lxd
tmpfs           100K     0  100K   0% /dev/.lxd-mounts
tmpfs           481M     0  481M   0% /dev/shm
tmpfs           193M  164K  193M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs            13M     0   13M   0% /run/user/0

[VPS IP地址]
内网 IPv4地址: 172.00.0.00
公网 IPv4地址: 107.000.06.000
IPv6地址: 2996:4790:190:8399:c91:3c07:c9ae:e2fa

[CPU 占用前 10 进程]
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         147  0.1 11.3 1243960 14212 ?       Ssl  Aug10  13:36 /opt/nezha/agent/nezha-agent -c /opt/nezha/agent/config.yml
root           1  0.0  4.5 166804  5708 ?        Ss   Aug10   0:14 /sbin/init
root         128  0.0  4.4  32004  5608 ?        Ss   Aug10   0:06 /lib/systemd/systemd-journald
root         137  0.0  0.0  20608    32 ?        Ss   Aug10   0:01 /lib/systemd/systemd-udevd
systemd+     140  0.0  1.0  16048  1368 ?        Ss   Aug10   0:04 /lib/systemd/systemd-networkd
message+     145  0.0  0.7   8232   908 ?        Ss   Aug10   0:01 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
root         148  0.0  2.2  14000  2784 ?        Ss   Aug10   0:02 /lib/systemd/systemd-logind
systemd+     157  0.0  0.2  24848   296 ?        Ss   Aug10   0:30 /lib/systemd/systemd-resolved
root         159  0.0  1.6 233896  2108 ?        Ssl  Aug10   0:00 /usr/libexec/polkitd --no-debug
nobody       166  0.0  3.0 1256756 3820 ?        Ssl  Aug10   0:35 /usr/local/bin/xray run -config /usr/local/etc/xray/config.json

[内存占用前 10 进程]
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         147  0.1 11.3 1243960 14212 ?       Ssl  Aug10  13:36 /opt/nezha/agent/nezha-agent -c /opt/nezha/agent/config.yml
root      136380  0.0  7.3  15024  9156 ?        Ss   08:16   0:00 sshd: root@pts/1,pts/2
root      136383  0.0  6.2  15052  7860 ?        Ss   08:16   0:00 /lib/systemd/systemd --user
root           1  0.0  4.5 166804  5708 ?        Ss   Aug10   0:14 /sbin/init
root         128  0.0  4.4  32004  5608 ?        Ss   Aug10   0:06 /lib/systemd/systemd-journald
root      136396  0.0  3.4   5880  4352 ?        Ss   08:16   0:00 /usr/lib/openssh/sftp-server
root      136393  0.0  3.1   7160  3944 pts/1    Ss   08:16   0:00 -bash
nobody       166  0.0  3.0 1256756 3820 ?        Ssl  Aug10   0:35 /usr/local/bin/xray run -config /usr/local/etc/xray/config.json
root       67017  0.0  3.0 712320  3772 ?        Sl   Aug13   0:44 wireguard-go warp
root      136397  0.0  3.0   7160  3768 pts/2    Ss+  08:16   0:00 -bash

[正在运行的 systemd 服务]
console-getty.service loaded active running Console
danted.service loaded active running SOCKS
dbus.service loaded active running D-Bus
nezha-agent.service loaded active running 哪吒监控
polkit.service loaded active running Authorization
ssh.service loaded active running OpenBSD
systemd-journald.service loaded active running Journal
systemd-logind.service loaded active running User
systemd-networkd.service loaded active running Network
systemd-resolved.service loaded active running Network
systemd-udevd.service loaded active running Rule-based
user@0.service loaded active running User
xray.service loaded active running Xray

[当前监听端口]
Netid State  Recv-Q Send-Q      Local Address:Port  Peer Address:PortProcess                                   
udp   UNCONN 0      0           127.0.0.53%lo:53         0.0.0.0:*    users:(("systemd-resolve",pid=157,fd=17))
udp   UNCONN 0      0      10.206.22.109%eth0:68         0.0.0.0:*    users:(("systemd-network",pid=140,fd=17))
udp   UNCONN 0      0                 0.0.0.0:40073      0.0.0.0:*    users:(("wireguard-go",pid=67017,fd=4))  
udp   UNCONN 0      0                 0.0.0.0:5355       0.0.0.0:*    users:(("systemd-resolve",pid=157,fd=11))
udp   UNCONN 0      0                    [::]:40073         [::]:*    users:(("wireguard-go",pid=67017,fd=15)) 
udp   UNCONN 0      0                    [::]:5355          [::]:*    users:(("systemd-resolve",pid=157,fd=13))
tcp   LISTEN 0      4096        127.0.0.53%lo:53         0.0.0.0:*    users:(("systemd-resolve",pid=157,fd=18))
tcp   LISTEN 0      4096              0.0.0.0:5355       0.0.0.0:*    users:(("systemd-resolve",pid=157,fd=12))
tcp   LISTEN 0      128               0.0.0.0:22         0.0.0.0:*    users:(("sshd",pid=170,fd=3))            
tcp   LISTEN 0      511               0.0.0.0:1080       0.0.0.0:*    users:(("danted",pid=173,fd=8))          
tcp   LISTEN 0      128                     *:443              *:*    users:(("xray",pid=166,fd=3))            
tcp   LISTEN 0      4096                 [::]:5355          [::]:*    users:(("systemd-resolve",pid=157,fd=14))
tcp   LISTEN 0      128                  [::]:22            [::]:*    users:(("sshd",pid=170,fd=4))            
tcp   LISTEN 0      511                  [::]:1080          [::]:*    users:(("danted",pid=173,fd=9))          

[Docker 容器状态]
Docker 未安装或未运行

[网络流量统计]
总流量: 0.37 GB
入站流量: 0.20 GB
出站流量: 0.18 GB

巡检完成 ✅ 日志已保存到 /var/log/vps_check_20250815.log
