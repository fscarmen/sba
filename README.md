# 【SB-A】 = Argo + Sing-box

* * *

# 目录

- [更新信息](README.md#更新信息)
- [项目特点](README.md#项目特点)
- [交互式运行脚本](README.md#交互式运行脚本)
- [无交互极速安装](README.md#无交互极速安装)
- [Argo Json 的获取](README.md#argo-json-的获取)
- [Argo Token 的获取](README.md#argo-token-的获取)
- [主体目录文件及说明](README.md#主体目录文件及说明)
- [免责声明](README.md#免责声明)

* * *
## 更新信息
2025.12.09 v1.1.6 Quick Install Mode: Added a one-click installation feature that auto-fills all parameters, simplifying the deployment process. Chinese users can use -l or -L; English users can use -k or -K. Case-insensitive support makes operations more flexible; 极速安装模式：新增一键安装功能，所有参数自动填充，简化部署流程。中文用户使用 -l 或 -L，英文用户使用 -k 或 -K，大小写均支持，操作更灵活

2025.11.10 v1.1.5 Replace multiplex with xtls-rprx-vision flow control in reality configuration; 在 reality 配置中将多路复用 multiplex 替换为 xtls-rprx-vision 流控

2025.04.26 v1.1.4 1. Added the ability to change CDNs online using [sb -d]; 2. Use OpenRC on Alpine to replace systemctl (Python3-compatible version); 3. Handle CentOS firewall port management; 4. Change GitHub proxy; 5. Optimize code; 1. 新增使用 [sb -d] 在线更换 CDN 功能; 2. 在 Alpine 系统中使用 OpenRC 取代兼容 Python3 的 systemctl 实现; 3. 处理 CentOS 防火墙端口管理; 4. 更换 GitHub 代理; 5. 优化代码

<details>
    <summary>历史更新 history（点击即可展开或收起）</summary>
<br>

>2025.03.25 v1.1.3 Compatible with Sing-box 1.12.0-alpha.18+; 适配 Sing-box 1.12.0-alpha.18+
>
>2025.01.28 v1.1.2 1. Add server-side time synchronization configuration; 2. Replace some CDNs; 1. 添加服务端时间同步配置; 2. 替换某些 CDN
>
>2024.12.20 v1.1.1 Refactored the chatGPT detection method based on lmc999's detection and unlocking script; 根据 lmc999 的检测解锁脚本，重构了检测 chatGPT 方法
>
>2024.5.21 v1.1.0 Compatible with Sing-box 1.11.0-beta.9+. Due to significant differences in the configuration files, it is not possible to upgrade from the old version. You can only reinstall the script; 适配 Sing-box 1.11.0-beta.9+，由于配置文件有很大差异，不能从旧版本升级，只能重装脚本
>
>2024.5.21 v1.0.10 1. Add Github CDN; 2. Remove subscription template 2; 1. 添加 Github 加速 CDN; 2. 去掉订阅模板2
>
>2024.3.26 v1.0.9 Thanks to UUb for the official change of the compilation, dependencies jq, qrencode from apt installation to download the binary files, reduce the installation time of about 15 seconds, the implementation of the project's positioning of lightweight, as far as possible to install the least system dependencies; 感谢 UUb 兄弟的官改编译，依赖 jq, qrencode 从 apt 安装改为下载二进制文件，缩减安装时间约15秒，贯彻项目轻量化的定位，尽最大可能安装最少的系统依赖
>
>2024.3.24 v1.0.8 1. In the Sing-box client, add the brutal field in the TCP protocol to make it effective; 2. Compatible with CentOS 7,8,9; 3. Remove default Github CDN; 4; Dependency jq changed from apt install to official download binary; 1. 在 Sing-box 客户端，TCP 协议协议里加上 brutal 字段以生效; 2. 适配 CentOS 7,8,9; 3. 去掉默认的 Github 加速网; 4. 依赖 jq 从 apt 安装改为官方下载二进制
>
>2024.3.15 v1.0.7 Use native IP if it supports unlocking chatGPT, otherwise use warp chained proxy unlocking; 如自身支持解锁 chatGPT，则使用原生 IP，否则使用 warp
>
>2024.3.10 v1.0.6 1. To protect node data security, use fake information to fetch subscribe api; 2. Adaptive the above clients. https://\<argo tunnel url\>/\<uuid\>/\<auto | auto2\>; 1. 为保护节点数据安全，在 api 转订阅时，使用虚假信息; 2. 自适应以上的客户端，https://\<argo tunnel url\>/\<uuid\>/\<auto | auto2\>
>
>2024.3.2 v1.0.5 1. Support V2rayN / Nekobox / Clash / sing-box / Shadowrocket subscribe. https://\<argo tunnel url\>/\<uuid\>/\<base64 | clash | sing-box-pc | sing-box-phone | proxies | qr\>. Index of all subscribes: https://\<argo tunnel url\>/\<uuid\>/  ; Reinstall is required; 2. Adaptive the above clients. https://\<argo tunnel url\>/\<uuid\>/<auto | auto2\> ; 1. 增加 V2rayN / Nekobox / Clash / sing-box / Shadowrocket 订阅，https://\<argo tunnel url\>/\<uuid\>/\<base64 | clash | sing-box-pc | sing-box-phone | proxies | qr\>， 所有订阅的索引: https://\<argo tunnel url\>/\<uuid\>/，需要重新安装; 2. 自适应以上的客户端，https://\<argo tunnel url\>/\<uuid\>/\<auto | auto2\>
>
>2024.2.6 v1.0.4 Argo run protocol uses default instead of http2. The default value is auto, what will automatically configure the quic protocol. If cloudflared is unable to establish UDP connections, it will fallback to using the http2 protocol; Argo 运行的协议使用默认值，而不是 http2。默认值为 auto，将自动配置 quic 协议。如果 cloudflared 无法建立 UDP 连接，它将回落到使用 http2 协议。
>
>2023.12.25 v1.0.3 1. Support Sing-box 1.8.0 latest Rule Set and Experimental; 2. api.openai.com routes to WARP IPv4, other openai websites routes to WARP IPv6; 3. Change some CDN; 1. 支持 Sing-box 1.8.0 最新的 Rule Set 和 Experimental; 2. api.openai.com 分流到 WARP IPv4，其他 openai 网站分流到 WARP IPv6; 3. 更换一些优选域名
>
>2023.11.17 v1.0.2 1. Support TCP brutal and add the official install script. Reinstall is required; 2. Use beta verion instead of alpha; 3. Fix a bug in json or token Argo tunnel outputing nodes list; 1. 支持 TCP brutal，并提供官方安装脚本，需要重新安装; 2. 由于 Sing-box 更新极快，将使用 beta 版本替代 alpha; 3. 修复固定域名时输出节点信息有误的bug
>
>2023.11.15 v1.0.1 1. Support TCP brutal. Reinstall is required; 2. Use alpha verion instead of latest; 3. Change the default CDN to [ cn.azhz.eu.org ]; 1. 支持 TCP brutal，需要重新安装; 2. 由于 Sing-box 更新极快，将使用 alpha 版本替代 latest; 3. 默认优选改为 [ cn.azhz.eu.org ]
>
>2023.10.30 v1.0 Reality xtls-rprx-vision / vless + WSS + Argo / vmess + WSS + Argo / trojan + WSS + Argo, 4 in 1 scripts, 4 合 1 脚本;
>
>2023.10.30 beta4 1. After installing, add [sb] shortcut; 1. 安装后，增加 [sb]] 的快捷运行方式
>
>2023.10.24 beta3 1. The Argo tunnel does not go through Reality's port 443 and goes directly to Nginx's port 3310, reducing latency; 2. Nginx reverses the API url for the temporary tunnel domain, which is now [ https://< ip >/argo ]; 1. Argo 隧道不过 Reality 的 443 端口，直接到达 Nginx 的 3310 端口，减少延时; 2. Nginx 反代查临时隧道域名 API url，现在是 [ https://< ip >/argo ]
>
>2023.10.23 beta2 1. Add reality; 2. Support temporary tunnels; 3. Support changing tunnel type; 4. Fallback from Argo tunnel to Nginx; 1. 增加 reality; 2. 支持临时隧道; 3. 支持改变隧道类型; 4. 回落从 Argo tunnel 改到 Nginx
>
>2023.10.22 beta1 Argo + Sing-box for vps
</details>

## 项目特点:

* 在 VPS 中部署 Sing-box，采用的方案为 Argo + Sing-box + WebSocket (+ TLS)；
* Nginx 回落分流处理了 Sing-box 原生不带该功能的尴尬，同时支持 Reality 直连及主流的 3 种 WS 主流协议: reality / vless /  vmess / trojan + WSS (ws + tls)；
* 正常用 CF 是访问机房回源，Argo 则是每次创建两个反向链接到两个就近机房，然后回源是通过源服务器就近机房回源，其中用户访问机房到源服务器连接的就近机房之间是CF自己的黑盒线路；
* 支持多路复用，减少 TCP 的握手延迟；
* Argo 是内网穿透的隧道，既 Sing-box 的 inbound 不对外暴露端口增加安全性，也不用做伪装网浪费资源，还支持 Cloudflare 的全部端口，不会死守443被封，同时服务端输出 Argo Ws 数据流，大大简化数据处理流程，提高响应，tls 由 cf 提供，避免多重 tls；
* Argo 支持通过 Token 或者 cloudflared Cli 方式申请的固定域名，直接优选 + 隧道，不需要申请域名证书；
* 内置 warp 链式代理解锁 chatGPT；
* 节点信息输出到 V2rayN / Clash Meta / 小火箭 / Nekobox / Sing-box (SFI, SFA, SFM)，订阅自动适配客户端，一个订阅 url 走天下；
* 极速安装，即可交互式安装，也可像 docker compose 一样的非交互式安装，提前把所有的参数放到一个配置文件，全程不到5秒。


## 交互式运行脚本:

```
bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/sba/main/sba.sh)
```

  | Option 参数 | Remark 备注 | 
  | -----------| ------ |
  | -c         | Chinese 中文 |
  | -e         | English 英文 |
  | -l         |	Quick deploy (Chinese version) 使用中文快速安装 |
  | -k         |	Quick deploy (English version) 使用英文快速安装 |
  | -a         | Argo on-off Argo 开关 |
  | -s         | Sing-box on-off Sing-box 开关 |
  | -f         | Variable file，refer to REPO file "config" 参数文件，可参照项目的文件 config |
  | -t         | Change the Argo Tunnel 更换 Argo 隧道 |
  | -d         | Change the CDN 更换优选域名 |
  | -u         | Uninstall 卸载 |
  | -n         | Export Nodes list 显示节点信息 |
  | -b         | Upgrade kernel, turn on BBR, change Linux system 升级内核、安装BBR、DD脚本 |
  | -v         | Sync Argo Sing-box to the newest 同步 Argo Sing-box 到最新版本 |

## 无交互极速安装:

### 中文
```
bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/sba/main/sba.sh) -l
```

### 英文
```
bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/sba/main/sba.sh) -k
```

## Argo Json 的获取

用户可以通过 Cloudflare Json 生成网轻松获取: https://fscarmen.cloudflare.now.cc

<img width="784" alt="image" src="https://github.com/fscarmen/sba/assets/62703343/fb7c6e90-fb3e-4e77-bcd4-407e4660a33c">

如想手动，可以参考，以 Debian 为例，需要用到的命令，[Deron Cheng - CloudFlare Argo Tunnel 试用](https://zhengweidong.com/try-cloudflare-argo-tunnel)


## Argo Token 的获取

详细教程: [群晖套件：Cloudflare Tunnel 内网穿透中文教程 支持DSM6、7](https://imnks.com/5984.html)

<img width="2836" height="1050" alt="image" src="https://github.com/user-attachments/assets/f427a7f8-1642-4076-91db-bdb827ca644f" />

<img width="2724" height="1318" alt="image" src="https://github.com/user-attachments/assets/0c5e1394-777e-4453-b9b7-c122cdcda086" />

<img width="1392" height="648" alt="image" src="https://github.com/user-attachments/assets/b9fdc0c9-189e-49e2-a624-5a7dfbcd83ac" />

## 主体目录文件及说明

```
/etc/sba                                     # 项目主体目录
|-- cert                                     # 存放证书文件目录
|   |-- cert.pem                             # SSL/TLS 安全证书文件
|   `-- private.key                          # SSL/TLS 证书的私钥信息
|-- logs
|   `-- box.log                              # sing-box 运行日志文件
|-- sing-box-conf                            # sing-box server 配置文件目录
|   |-- inbound.json                         # vless / vmess / trojan + WSS 入站配置文件
|   `-- outbound.json                        # 出站和路由配置文件，chatGPT 使用 warp ipv6 链式代理出站
|-- subscribe                                # 订阅文件目录
|   |-- qr                                   # Nekoray / V2rayN 订阅二维码
|   |-- base64                               # Nekoray / V2rayN 订阅文件
|   |-- clash                                # Clash 订阅文件
|   |-- clash                                # Clash 订阅文件2
|   |-- proxies                              # Clash proxy provider 订阅文件
|   |-- shadowrocket                         # Shadowrocket 订阅文件
|   |-- sing-box-pc                          # SFM 订阅文件
|   |-- sing-box-phone                       # SFI / SFA 订阅文件
|   `-- sing-box2                            # SFI / SFA / SFM 订阅文件2
|-- cloudflared                              # Argo tunnel 主程序
|-- tunnel.json                              # Argo tunnel Json 信息文件
|-- tunnel.yml                               # Argo tunnel 配置文件
|-- cache.db                                 # sing-box缓存文件
|-- language                                 # 存放脚本语言文件，E 为英文，C 为中文
|-- nginx.conf                               # Nginx 配置文件
|-- list                                     # 节点信息列表
|-- sing-box                                 # sing-box 主程序
|-- sb.sh                                    # 快捷方式脚本文件
|-- jq                                       # 命令行 JSON 处理器
`-- qrencode                                 # QR 码编码二进制文件
```


## 免责声明:
* 本程序仅供学习了解, 非盈利目的，请于下载后 24 小时内删除, 不得用作任何商业用途, 文字、数据及图片均有所属版权, 如转载须注明来源。
* 使用本程序必循遵守部署免责声明。使用本程序必循遵守部署服务器所在地、所在国家和用户所在国家的法律法规, 程序作者不对使用者任何不当行为负责。