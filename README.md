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

2023.10.22 beta1 Argo + Sing-box for vps


## 项目特点:

* 在 VPS 中部署 Sing-box，采用的方案为 Argo + Sing-box + WebSocket (+ TLS)；
* Argo 回落分流处理了 Sing-box 原生不带该功能的尴尬，同时支持主流的 3 种 WS 主流协议: vless /  vmess / trojan + WSS (ws + tls)；
* 正常用 CF 是访问机房回源，Argo 则是每次创建两个反向链接到两个就近机房，然后回源是通过源服务器就近机房回源，其中用户访问机房到源服务器连接的就近机房之间是CF自己的黑盒线路；
* 使用 CloudFlare 的 Argo 隧道，使用TLS加密通信，可以将应用程序流量安全地传输到Cloudflare网络，提高了应用程序的安全性和可靠性。此外，Argo Tunnel也可以防止IP泄露和DDoS攻击等网络威胁；
* Argo 是内网穿透的隧道，既 Sing-box 的 inbound 不对外暴露端口增加安全性，也不用做伪装网浪费资源，还支持 Cloudflare 的全部端口，不会死守443被封，同时服务端输出 Argo Ws 数据流，大大简化数据处理流程，提高响应，tls 由 cf 提供，避免多重 tls；
* Argo 支持通过 Token 或者 cloudflared Cli 方式申请的固定域名，直接优选 + 隧道，不需要申请域名证书；
* 内置 warp 链式代理解锁 chatGPT；
* 节点信息以 Nekobox / V2rayN / Clash / 小火箭 链接方式输出；
* 极速安装，即可交互式安装，也可像 docker compose 一样的非交互式安装，提前把所有的参数放到一个配置文件，全程不到5秒。


## sba for VPS 运行脚本:

```
bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/sba/main/sba.sh)
```

  | Option 参数 | Remark 备注 | 
  | -----------| ------ |
  | -c         | Chinese 中文 |
  | -e         | English 英文 | 
  | -f         | Variable file，refer to REPO file "config" 参数文件，可参数项目的文件 config | 
  | -u         | Uninstall 卸载 |
  | -n         | Export Nodes list 显示节点信息 |
  | -v         | Sync Argo Sing-box to the newest 同步 Argo Sing-box 到最新版本 |


## Argo Json 的获取

用户可以通过 Cloudflare Json 生成网轻松获取: https://fscarmen.cloudflare.now.cc

<img width="784" alt="image" src="https://github.com/fscarmen/sba/assets/62703343/fb7c6e90-fb3e-4e77-bcd4-407e4660a33c">

如想手动，可以参考，以 Debian 为例，需要用到的命令，[Deron Cheng - CloudFlare Argo Tunnel 试用](https://zhengweidong.com/try-cloudflare-argo-tunnel)


## Argo Token 的获取

详细教程: [群晖套件：Cloudflare Tunnel 内网穿透中文教程 支持DSM6、7](https://imnks.com/5984.html)

<img width="1368" alt="image" src="https://github.com/fscarmen/sba/assets/62703343/5e00f0a7-325e-4ce0-9a68-d48f2a96da59">

<img width="1477" alt="image" src="https://github.com/fscarmen/sba/assets/62703343/484f5e6a-1942-42b1-94dc-2ad0f9271836">

<img width="1680" alt="image" src="https://github.com/fscarmen/sba/assets/62703343/0a2ae792-b420-4fa0-950c-15a7a9920643">


## 主体目录文件及说明

```
/etc/sba                                     # 项目主体目录
├── cloudflared                              # Argo tunnel 主程序
|-- tunnel.json                              # Argo tunnel Json 信息文件
|-- tunnel.yml                               # Argo tunnel 配置文件
|-- sing-box-conf                            # sing-box server 配置文件目录
|   |-- inbound.json                         # vless / vmess / trojan + WSS 入站配置文件
|   `-- outbound.json                        # 出站和路由配置文件，chatGPT 使用 warp ipv6 链式代理出站
|   |-- 02_route.json                        # 路由配置文件，chatGPT 使用 warp ipv6 链式代理出站
|-- geosite.db                               # 用于基于域名或网站分类来进行访问控制、内容过滤或安全策略
|-- geoip.db                                 # 用于根据 IP 地址来进行地理位置策略或访问控制
|-- language                                 # 存放脚本语言文件，E 为英文，C 为中文
|-- list                                     # 节点信息列表
|-- logs
|   `-- box.log                              # sing-box 运行日志文件
`-- sing-box                                 # sing-box 主程序
```


## 免责声明:
* 本程序仅供学习了解, 非盈利目的，请于下载后 24 小时内删除, 不得用作任何商业用途, 文字、数据及图片均有所属版权, 如转载须注明来源。
* 使用本程序必循遵守部署免责声明。使用本程序必循遵守部署服务器所在地、所在国家和用户所在国家的法律法规, 程序作者不对使用者任何不当行为负责。