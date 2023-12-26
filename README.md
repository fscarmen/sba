# 【SB-A】 = Argo + Sing-box

* * *

# 目录

- [更新信息](README.md#更新信息)
- [项目特点](README.md#项目特点)
- [sba for VPS 运行脚本](README.md#sba-for-vps-运行脚本)
- [Argo Json 的获取](README.md#argo-json-的获取)
- [Argo Token 的获取](README.md#argo-token-的获取)
- [主体目录文件及说明](README.md#主体目录文件及说明)
- [免责声明](README.md#免责声明)

* * *
## 更新信息
2023.12.25 v1.0.3 1. Support Sing-box 1.8.0 latest Rule Set and Experimental; 2. api.openai.com routes to WARP IPv4, other openai websites routes to WARP IPv6; 3. Change some CDN; 1. 支持 Sing-box 1.8.0 最新的 Rule Set 和 Experimental; 2. api.openai.com 分流到 WARP IPv4，其他 openai 网站分流到 WARP IPv6; 3. 更换一些优选域名

2023.11.17 v1.0.2 1. Support TCP brutal and add the official install script. Reinstall is required; 2. Use beta verion instead of alpha; 3. Fix a bug in json or token Argo tunnel outputing nodes list; 1. 支持 TCP brutal，并提供官方安装脚本，需要重新安装; 2. 由于 Sing-box 更新极快，将使用 beta 版本替代 alpha; 3. 修复固定域名时输出节点信息有误的bug

2023.11.15 v1.0.1 1. Support TCP brutal. Reinstall is required; 2. Use alpha verion instead of latest; 3. Change the default CDN to [ cn.azhz.eu.org ]; 1. 支持 TCP brutal，需要重新安装; 2. 由于 Sing-box 更新极快，将使用 alpha 版本替代 latest; 3. 默认优选改为 [ cn.azhz.eu.org ]

2023.10.30 v1.0 Reality xtls-rprx-vision / vless + WSS + Argo / vmess + WSS + Argo / trojan + WSS + Argo, 4 in 1 scripts, 4 合 1 脚本;

<details>
    <summary>历史更新 history（点击即可展开或收起）</summary>
<br>

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
* 节点信息输出方式 V2rayN / Clash Meta / 小火箭 / Nekobox / Sing-box；
* 极速安装，即可交互式安装，也可像 docker compose 一样的非交互式安装，提前把所有的参数放到一个配置文件，全程不到5秒。


## sba for VPS 运行脚本:

```
bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/sba/main/sba.sh)
```

  | Option 参数 | Remark 备注 | 
  | -----------| ------ |
  | -c         | Chinese 中文 |
  | -e         | English 英文 |
  | -a         | Argo on-off Argo 开关 |
  | -s         | Sing-box on-off Xray 开关 |
  | -f         | Variable file，refer to REPO file "config" 参数文件，可参数项目的文件 config | 
  | -u         | Uninstall 卸载 |
  | -n         | Export Nodes list 显示节点信息 |
  | -b         | Upgrade kernel, turn on BBR, change Linux system 升级内核、安装BBR、DD脚本 |
  | -v         | Sync Argo Sing-box to the newest 同步 Argo Sing-box 到最新版本 |


## Argo Json 的获取

用户可以通过 Cloudflare Json 生成网轻松获取: https://fscarmen.cloudflare.now.cc

<img width="784" alt="image" src="https://github.com/fscarmen/sba/assets/62703343/fb7c6e90-fb3e-4e77-bcd4-407e4660a33c">

如想手动，可以参考，以 Debian 为例，需要用到的命令，[Deron Cheng - CloudFlare Argo Tunnel 试用](https://zhengweidong.com/try-cloudflare-argo-tunnel)


## Argo Token 的获取

详细教程: [群晖套件：Cloudflare Tunnel 内网穿透中文教程 支持DSM6、7](https://imnks.com/5984.html)

<img width="1368" alt="image" src="https://github.com/fscarmen/sba/assets/62703343/5e00f0a7-325e-4ce0-9a68-d48f2a96da59">

<img width="1644" alt="image" src="https://github.com/fscarmen/sba/assets/62703343/ccbb66f0-7310-46a1-8ccc-2289ae6568f6">


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
├── cloudflared                              # Argo tunnel 主程序
|-- tunnel.json                              # Argo tunnel Json 信息文件
|-- tunnel.yml                               # Argo tunnel 配置文件
|-- cache.db                                 # sing-box缓存文件
|-- geosite.db                               # 用于基于域名或网站分类来进行访问控制、内容过滤或安全策略
|-- geoip.db                                 # 用于根据 IP 地址来进行地理位置策略或访问控制
|-- language                                 # 存放脚本语言文件，E 为英文，C 为中文
|-- nginx.conf                               # Nginx 配置文件
|-- list                                     # 节点信息列表
|-- sing-box                                 # sing-box 主程序
`-- sb.sh                                    # 快捷方式脚本文件
```


## 免责声明:
* 本程序仅供学习了解, 非盈利目的，请于下载后 24 小时内删除, 不得用作任何商业用途, 文字、数据及图片均有所属版权, 如转载须注明来源。
* 使用本程序必循遵守部署免责声明。使用本程序必循遵守部署服务器所在地、所在国家和用户所在国家的法律法规, 程序作者不对使用者任何不当行为负责。