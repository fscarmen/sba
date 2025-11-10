#!/usr/bin/env bash

# 当前脚本版本号
VERSION='1.1.5 (2025.11.10)'

# 各变量默认值
GH_PROXY='https://hub.glowp.xyz/'
WS_PATH_DEFAULT='sba'
WORK_DIR='/etc/sba'
TEMP_DIR='/tmp/sba'
TLS_SERVER=addons.mozilla.org
CDN_DOMAIN=("skk.moe" "ip.sb" "time.is" "cfip.xxxxxxxx.tk" "bestcf.top" "cdn.2020111.xyz" "xn--b6gac.eu.org")
SUBSCRIBE_TEMPLATE="https://raw.githubusercontent.com/fscarmen/client_template/main"
METRICS_PORT='3014'
DEFAULT_NEWEST_VERSION='1.13.0-alpha.27'

export DEBIAN_FRONTEND=noninteractive

trap "rm -rf $TEMP_DIR; echo -e '\n' ;exit" INT QUIT TERM EXIT

mkdir -p $TEMP_DIR

E[0]="Language:\n 1. English (default) \n 2. 简体中文"
C[0]="${E[0]}"
E[1]="Replace multiplex with xtls-rprx-vision flow control in reality configuration."
C[1]="在 reality 配置中将多路复用 multiplex 替换为 xtls-rprx-vision 流控"
E[2]="Project to create Argo tunnels and Sing-box specifically for VPS, detailed:[https://github.com/fscarmen/sba]\n Features:\n\t • Allows the creation of Argo tunnels via Token, Json and ad hoc methods. User can easily obtain the json at https://fscarmen.cloudflare.now.cc .\n\t • Extremely fast installation method, saving users time.\n\t • Support system: Ubuntu, Debian, CentOS, Alpine and Arch Linux 3.\n\t • Support architecture: AMD,ARM and s390x\n"
C[2]="本项目专为 VPS 添加 Argo 隧道及 Sing-Box,详细说明: [https://github.com/fscarmen/sba]\n 脚本特点:\n\t • 允许通过 Token, Json 及 临时方式来创建 Argo 隧道,用户通过以下网站轻松获取 json: https://fscarmen.cloudflare.now.cc\n\t • 极速安装方式,大大节省用户时间\n\t • 智能判断操作系统: Ubuntu 、Debian 、CentOS 、Alpine 和 Arch Linux,请务必选择 LTS 系统\n\t • 支持硬件结构类型: AMD 和 ARM\n"
E[3]="Input errors up to 5 times.The script is aborted."
C[3]="输入错误达5次,脚本退出"
E[4]="UUID should be 36 characters, please re-enter \(\$[a-1] times remaining\)"
C[4]="UUID 应为36位字符,请重新输入 \(剩余\$[a-1]次\)"
E[5]="The script supports Debian, Ubuntu, CentOS, Alpine, Fedora or Arch systems only. Feedback: [https://github.com/fscarmen/sba/issues]"
C[5]="本脚本只支持 Debian、Ubuntu、CentOS、Alpine、Fedora 或 Arch 系统,问题反馈:[https://github.com/fscarmen/sba/issues]"
E[6]="Curren operating system is \$SYS.\\\n The system lower than \$SYSTEM \${MAJOR[int]} is not supported. Feedback: [https://github.com/fscarmen/sba/issues]"
C[6]="当前操作是 \$SYS\\\n 不支持 \$SYSTEM \${MAJOR[int]} 以下系统,问题反馈:[https://github.com/fscarmen/sba/issues]"
E[7]="Install dependence-list:"
C[7]="安装依赖列表:"
E[8]="All dependencies already exist and do not need to be installed additionally."
C[8]="所有依赖已存在，不需要额外安装"
E[9]="To upgrade, press [y]. No upgrade by default:"
C[9]="升级请按 [y]，默认不升级:"
E[10]="(2/7) Please input Argo Domain (Default is temporary domain if left blank):"
C[10]="(2/7) 请输入 Argo 域名 (如果没有，可以跳过以使用 Argo 临时域名):"
E[11]="Please input Argo Token or Json ( User can easily obtain the json at https://fscarmen.cloudflare.now.cc ):"
C[11]="请输入 Argo Token 或者 Json ( 用户通过以下网站轻松获取 json: https://fscarmen.cloudflare.now.cc ):"
E[12]="\(5/7\) Please input Sing-box UUID \(Default is \$UUID_DEFAULT\):"
C[12]="\(5/7\) 请输入 Sing-box UUID \(默认为 \$UUID_DEFAULT\):"
E[13]="\(6/7\) Please input Sing-box WS Path \(Default is \$WS_PATH_DEFAULT\):"
C[13]="\(6/7\) 请输入 Sing-box WS 路径 \(默认为 \$WS_PATH_DEFAULT\):"
E[14]="Sing-box WS Path only allow uppercase and lowercase letters and numeric characters, please re-enter \(\${a} times remaining\):"
C[14]="Sing-box WS 路径只允许英文大小写及数字字符，请重新输入 \(剩余\${a}次\):"
E[15]="sba script has not been installed yet."
C[15]="sba 脚本还没有安装"
E[16]="sba is completely uninstalled."
C[16]="sba 已彻底卸载"
E[17]="Version"
C[17]="脚本版本"
E[18]="New features"
C[18]="功能新增"
E[19]="System infomation"
C[19]="系统信息"
E[20]="Operating System"
C[20]="当前操作系统"
E[21]="Kernel"
C[21]="内核"
E[22]="Architecture"
C[22]="处理器架构"
E[23]="Virtualization"
C[23]="虚拟化"
E[24]="Choose:"
C[24]="请选择:"
E[25]="Curren architecture \$(uname -m) is not supported. Feedback: [https://github.com/fscarmen/sba/issues]"
C[25]="当前架构 \$(uname -m) 暂不支持,问题反馈:[https://github.com/fscarmen/sba/issues]"
E[26]="Not install"
C[26]="未安装"
E[27]="close"
C[27]="关闭"
E[28]="open"
C[28]="开启"
E[29]="View links (sb -n)"
C[29]="查看节点信息 (sb -n)"
E[30]="Change the Argo tunnel (sb -t)"
C[30]="更换 Argo 隧道 (sb -t)"
E[31]="Sync Argo and Sing-box to the latest version (sb -v)"
C[31]="同步 Argo 和 Sing-box 至最新版本 (sb -v)"
E[32]="Upgrade kernel, turn on BBR, change Linux system (sb -b)"
C[32]="升级内核、安装BBR、DD脚本 (sb -b)"
E[33]="Uninstall (sb -u)"
C[33]="卸载 (sb -u)"
E[34]="Install sba script (argo + sing-box)"
C[34]="安装 sba 脚本 (argo + sing-box)"
E[35]="Exit"
C[35]="退出"
E[36]="Please enter the correct number"
C[36]="请输入正确数字"
E[37]="successful"
C[37]="成功"
E[38]="failed"
C[38]="失败"
E[39]="sba is not installed."
C[39]="sba 未安装"
E[40]="Argo tunnel is: \$ARGO_TYPE\\\n The domain is: \$ARGO_DOMAIN"
C[40]="Argo 隧道类型为: \$ARGO_TYPE\\\n 域名是: \$ARGO_DOMAIN"
E[41]="Argo tunnel type:\n 1. Try\n 2. Token or Json"
C[41]="Argo 隧道类型:\n 1. Try\n 2. Token 或者 Json"
E[42]="\(4/7\) Please select or enter the preferred domain, the default is \${CDN_DOMAIN[0]}:"
C[42]="\(4/7\) 请选择或者填入优选域名，默认为 \${CDN_DOMAIN[0]}:"
E[43]="\$APP local verion: \$LOCAL\\\t The newest verion: \$ONLINE"
C[43]="\$APP 本地版本: \$LOCAL\\\t 最新版本: \$ONLINE"
E[44]="No upgrade required."
C[44]="不需要升级"
E[45]="Argo authentication message does not match the rules, neither Token nor Json, script exits. Feedback:[https://github.com/fscarmen/sba/issues]"
C[45]="Argo 认证信息不符合规则，既不是 Token，也是不是 Json，脚本退出，问题反馈:[https://github.com/fscarmen/sba/issues]"
E[46]="Connect"
C[46]="连接"
E[47]="The script must be run as root, you can enter sudo -i and then download and run again. Feedback:[https://github.com/fscarmen/sba/issues]"
C[47]="必须以root方式运行脚本，可以输入 sudo -i 后重新下载运行，问题反馈:[https://github.com/fscarmen/sba/issues]"
E[48]="Downloading the latest version \$APP failed, script exits. Feedback:[https://github.com/fscarmen/sba/issues]"
C[48]="下载最新版本 \$APP 失败，脚本退出，问题反馈:[https://github.com/fscarmen/sba/issues]"
E[49]="\(7/7\) Please enter the node name. \(Default is \${NODE_NAME_DEFAULT}\):"
C[49]="\(7/7\) 请输入节点名称 \(默认为 \${NODE_NAME_DEFAULT}\):"
E[50]="\${APP[@]} services are not enabled, node information cannot be output. Press [y] if you want to open."
C[50]="\${APP[@]} 服务未开启，不能输出节点信息。如需打开请按 [y]: "
E[51]="Install Sing-box multi-protocol scripts [https://github.com/fscarmen/sing-box]"
C[51]="安装 Sing-box 协议全家桶脚本 [https://github.com/fscarmen/sing-box]"
E[52]="Memory Usage"
C[52]="内存占用"
E[53]="The Sing-box service is detected to be installed, script exits. Feedback:[https://github.com/fscarmen/sba/issues]"
C[53]="检测到已安装 Sing-box 服务，脚本退出，问题反馈:[https://github.com/fscarmen/sba/issues]"
E[54]="Warp / warp-go was detected to be running. Please enter the correct server IP:"
C[54]="检测到 warp / warp-go 正在运行，请输入确认的服务器 IP:"
E[55]="The script runs today: \$TODAY. Total: \$TOTAL"
C[55]="脚本当天运行次数: \$TODAY，累计运行次数: \$TOTAL"
E[56]="\(3/7\) Please enter the Reality port \(Default is \${REALITY_PORT_DEFAULT}\):"
C[56]="\(3/7\) 请输入 Reality 的端口号 \(默认为 \${REALITY_PORT_DEFAULT}\):"
E[57]="\(1/7\) Please enter VPS IP \(Default is: \${SERVER_IP_DEFAULT}\):"
C[57]="\(1/7\) 请输入 VPS IP \(默认为: \${SERVER_IP_DEFAULT}\):"
E[58]="Install ArgoX scripts (argo + xray) [https://github.com/fscarmen/argox]"
C[58]="安装 ArgoX 脚本 (argo + xray) [https://github.com/fscarmen/argox]"
E[59]="To uninstall Nginx press [y], it is not uninstalled by default:"
C[59]="如要卸载 Nginx 请按 [y]，默认不卸载:"
E[60]="Quicktunnel domain can be obtained from: http://\${SERVER_IP_1}:\${METRICS_PORT}/quicktunnel"
C[60]="临时隧道域名可以从以下网站获取: http://\${SERVER_IP_1}:\${METRICS_PORT}/quicktunnel"
E[61]="For nodes using WebSocket, if the client core is sing-box, multiplexing can be enabled."
C[61]="使用 WebSocket 的节点，如客户端内核是 sing-box，可开启多路复用"
E[62]="Create shortcut [ sb ] successfully."
C[62]="创建快捷 [ sb ] 指令成功!"
E[63]="The full template can be found at:\n https://github.com/chika0801/sing-box-examples/tree/main/Tun"
C[63]="完整模板可参照:\n https://github.com/chika0801/sing-box-examples/tree/main/Tun"
E[64]="Install TCP brutal"
C[64]="安装 TCP brutal"
E[65]="No server ip, script exits. Feedback:[https://github.com/fscarmen/sba/issues]"
C[65]="没有 server ip，脚本退出，问题反馈:[https://github.com/fscarmen/sba/issues]"
E[66]="subscribe"
C[66]="订阅"
E[67]="Ports are in used: \$REALITY_PORT"
C[67]="正在使用中的端口: \$REALITY_PORT"
E[68]="Adaptive Clash / V2rayN / NekoBox / ShadowRocket / SFI / SFA / SFM Clients"
C[68]="自适应 Clash / V2rayN / NekoBox / ShadowRocket / SFI / SFA / SFM 客户端"
E[69]="Set SElinux: enforcing --> disabled"
C[69]="设置 SElinux: enforcing --> disabled"
E[70]="Sing-box is not installed and cannot change the CDN."
C[70]="Sing-box 未安装，不能更换 CDN"
E[71]="Current CDN is: \${CDN_NOW}"
C[71]="当前 CDN 为: \${CDN_NOW}"
E[72]="Please select or enter a new CDN (press Enter to keep the current one):"
C[72]="请选择或输入新的 CDN (回车保持当前值):"
E[73]="CDN has been changed from \${CDN_NOW} to \${CDN_NEW}"
C[73]="CDN 已从 \${CDN_NOW} 更改为 \${CDN_NEW}"

# 自定义字体彩色，read 函数
warning() { echo -e "\033[31m\033[01m$*\033[0m"; }  # 红色
error() { echo -e "\033[31m\033[01m$*\033[0m" && exit 1; } # 红色
info() { echo -e "\033[32m\033[01m$*\033[0m"; }   # 绿色
hint() { echo -e "\033[33m\033[01m$*\033[0m"; }   # 黄色
reading() { read -rp "$(info "$1")" "$2"; }
text() { grep -q '\$' <<< "${E[$*]}" && eval echo "\$(eval echo "\${${L}[$*]}")" || eval echo "\${${L}[$*]}"; }

# 检测是否需要启用 Github CDN，如能直接连通，则不使用
check_cdn() {
  [ -n "$GH_PROXY" ] && wget --server-response --quiet --output-document=/dev/null --no-check-certificate --tries=2 --timeout=3 ${GH_PROXY}https://raw.githubusercontent.com/fscarmen/sba/main/README.md >/dev/null 2>&1 || unset GH_PROXY
}

# 检测是否解锁 chatGPT，以决定是否使用 warp 链式代理或者是 direct out，此处判断改编自 https://github.com/lmc999/RegionRestrictionCheck
check_chatgpt() {
  local CHECK_STACK=-$1
  local UA_BROWSER="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36"
  local UA_SEC_CH_UA='"Google Chrome";v="125", "Chromium";v="125", "Not.A/Brand";v="24"'
  wget --help | grep -q '\-\-ciphers' && local IS_CIPHERS=is_ciphers

  # 首先检查API访问
  local CHECK_RESULT1=$(wget --timeout=2 --tries=2 --retry-connrefused --waitretry=5 ${CHECK_STACK} -qO- --content-on-error --header='authority: api.openai.com' --header='accept: */*' --header='accept-language: en-US,en;q=0.9' --header='authorization: Bearer null' --header='content-type: application/json' --header='origin: https://platform.openai.com' --header='referer: https://platform.openai.com/' --header="sec-ch-ua: ${UA_SEC_CH_UA}" --header='sec-ch-ua-mobile: ?0' --header='sec-ch-ua-platform: "Windows"' --header='sec-fetch-dest: empty' --header='sec-fetch-mode: cors' --header='sec-fetch-site: same-site' --user-agent="${UA_BROWSER}" 'https://api.openai.com/compliance/cookie_requirements')

  [ -z "$CHECK_RESULT1" ] && grep -qw is_ciphers <<< "$IS_CIPHERS" && local CHECK_RESULT1=$(wget --timeout=2 --tries=2 --retry-connrefused --waitretry=5 ${CHECK_STACK} --ciphers=DEFAULT@SECLEVEL=1 --no-check-certificate -qO- --content-on-error --header='authority: api.openai.com' --header='accept: */*' --header='accept-language: en-US,en;q=0.9' --header='authorization: Bearer null' --header='content-type: application/json' --header='origin: https://platform.openai.com' --header='referer: https://platform.openai.com/' --header="sec-ch-ua: ${UA_SEC_CH_UA}" --header='sec-ch-ua-mobile: ?0' --header='sec-ch-ua-platform: "Windows"' --header='sec-fetch-dest: empty' --header='sec-fetch-mode: cors' --header='sec-fetch-site: same-site' --user-agent="${UA_BROWSER}" 'https://api.openai.com/compliance/cookie_requirements')

  # 如果API检测失败或者检测到unsupported_country,直接返回ban
  if [ -z "$CHECK_RESULT1" ] || grep -qi 'unsupported_country' <<< "$CHECK_RESULT1"; then
    echo "ban"
    return
  fi

  # API检测通过后,继续检查网页访问
  local CHECK_RESULT2=$(wget --timeout=2 --tries=2 --retry-connrefused --waitretry=5 ${CHECK_STACK} -qO- --content-on-error --header='authority: ios.chat.openai.com' --header='accept: */*;q=0.8,application/signed-exchange;v=b3;q=0.7' --header='accept-language: en-US,en;q=0.9' --header="sec-ch-ua: ${UA_SEC_CH_UA}" --header='sec-ch-ua-mobile: ?0' --header='sec-ch-ua-platform: "Windows"' --header='sec-fetch-dest: document' --header='sec-fetch-mode: navigate' --header='sec-fetch-site: none' --header='sec-fetch-user: ?1' --header='upgrade-insecure-requests: 1' --user-agent="${UA_BROWSER}" https://ios.chat.openai.com/)

  [ -z "$CHECK_RESULT2" ] && grep -qw is_ciphers <<< "$IS_CIPHERS" && local CHECK_RESULT2=$(wget --timeout=2 --tries=2 --retry-connrefused --waitretry=5 ${CHECK_STACK} --ciphers=DEFAULT@SECLEVEL=1 --no-check-certificate -qO- --content-on-error --header='authority: ios.chat.openai.com' --header='accept: */*;q=0.8,application/signed-exchange;v=b3;q=0.7' --header='accept-language: en-US,en;q=0.9' --header="sec-ch-ua: ${UA_SEC_CH_UA}" --header='sec-ch-ua-mobile: ?0' --header='sec-ch-ua-platform: "Windows"' --header='sec-fetch-dest: document' --header='sec-fetch-mode: navigate' --header='sec-fetch-site: none' --header='sec-fetch-user: ?1' --header='upgrade-insecure-requests: 1' --user-agent="${UA_BROWSER}" https://ios.chat.openai.com/)

  # 检查第二个结果
  if [ -z "$CHECK_RESULT2" ] || grep -qi 'VPN' <<< "$CHECK_RESULT2"; then
    echo "ban"
  else
    echo "unlock"
  fi
}

# 脚本当天及累计运行次数统计
statistics_of_run-times() {
  local UPDATE_OR_GET=$1
  local SCRIPT=$2
  if grep -q 'update' <<< "$UPDATE_OR_GET"; then
    { wget --no-check-certificate -qO- --timeout=3 "https://stat.cloudflare.now.cc/api/updateStats?script=${SCRIPT}" > $TEMP_DIR/statistics 2>/dev/null || true; }&
  elif grep -q 'get' <<< "$UPDATE_OR_GET"; then
    [ -s $TEMP_DIR/statistics ] && [[ $(cat $TEMP_DIR/statistics) =~ \"todayCount\":([0-9]+),\"totalCount\":([0-9]+) ]] && local TODAY="${BASH_REMATCH[1]}" && local TOTAL="${BASH_REMATCH[2]}" && rm -f $TEMP_DIR/statistics
    hint "\n*******************************************\n\n $(text 55) \n"
  fi
}

# 选择中英语言
select_language() {
  if [ -z "$L" ]; then
    case $(cat $WORK_DIR/language 2>&1) in
      E ) L=E ;;
      C ) L=C ;;
      * ) [ -z "$L" ] && L=E && ! grep -q 'noninteractive_install' <<< "$NONINTERACTIVE_INSTALL" && hint "\n $(text 0) \n" && reading " $(text 24) " LANGUAGE
      [ "$LANGUAGE" = 2 ] && L=C ;;
    esac
  fi
}

# 只允许 root 用户安装脚本
check_root() {
  [ "$(id -u)" != 0 ] && error "\n $(text 47) \n"
}

# 检测处理器架构
check_arch() {
  case $(uname -m) in
    aarch64|arm64 )
      ARGO_ARCH=arm64; SING_BOX_ARCH=arm64; JQ_ARCH=arm64; QRENCODE_ARCH=arm64
      ;;
    x86_64|amd64 )
      ARGO_ARCH=amd64; SING_BOX_ARCH=amd64; JQ_ARCH=amd64; QRENCODE_ARCH=amd64
      ;;
    armv7l )
      ARGO_ARCH=arm; SING_BOX_ARCH=armv7; JQ_ARCH=armhf; QRENCODE_ARCH=arm
      ;;
    * )
      error " $(text 25) "
  esac
}

# 查安装及运行状态，下标0: argo，下标1: sing-box；状态码: 26 未安装， 27 已安装未运行， 28 运行中
check_install() {
  [ -s $WORK_DIR/nginx.conf ] && IS_NGINX=is_nginx || IS_NGINX=no_nginx
  # 检查 argo 服务
  STATUS[0]=$(text 26) && [ -s ${ARGO_DAEMON_FILE} ] && STATUS[0]=$(text 27) && cmd_systemctl status argo >/dev/null 2>&1 && STATUS[0]=$(text 28)

  # 检查 sing-box 服务
  STATUS[1]=$(text 26)
  # sing-box systemd 文件存在的话，检测一下是否本脚本安装的，如果不是则提示并退出
  if [ -s ${SINGBOX_DAEMON_FILE} ]; then
    ! grep -q "$WORK_DIR" ${SINGBOX_DAEMON_FILE} && error " $(text 53)\n $(grep "${DAEMON_RUN_PATTERN}" ${SINGBOX_DAEMON_FILE}) "
    STATUS[1]=$(text 27) && cmd_systemctl status sing-box &>/dev/null && STATUS[1]=$(text 28)
  fi

  # 下载所需文件
  [[ ${STATUS[0]} = "$(text 26)" ]] && [ ! -s $WORK_DIR/cloudflared ] &&
  {
    wget --no-check-certificate -qO $TEMP_DIR/cloudflared ${GH_PROXY}https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-$ARGO_ARCH >/dev/null 2>&1
    chmod +x $TEMP_DIR/cloudflared >/dev/null 2>&1
  }&
  [[ ${STATUS[1]} = "$(text 26)" ]] && [ ! -s $WORK_DIR/sing-box ] &&
  {
    local SING_BOX_LATEST=$(get_sing_box_version)
    wget --no-check-certificate -c -qO- ${GH_PROXY}https://github.com/SagerNet/sing-box/releases/download/v$SING_BOX_LATEST/sing-box-$SING_BOX_LATEST-linux-$SING_BOX_ARCH.tar.gz -qO- | tar xz -C $TEMP_DIR sing-box-$SING_BOX_LATEST-linux-$SING_BOX_ARCH/sing-box
    mv $TEMP_DIR/sing-box-$SING_BOX_LATEST-linux-$SING_BOX_ARCH/sing-box $TEMP_DIR >/dev/null 2>&1
    wget --no-check-certificate --continue -qO $TEMP_DIR/jq ${GH_PROXY}https://github.com/jqlang/jq/releases/download/jq-1.7.1/jq-linux-$JQ_ARCH >/dev/null 2>&1 && chmod +x $TEMP_DIR/jq >/dev/null 2>&1
    wget --no-check-certificate --continue -qO $TEMP_DIR/qrencode ${GH_PROXY}https://github.com/fscarmen/client_template/raw/main/qrencode-go/qrencode-go-linux-$QRENCODE_ARCH >/dev/null 2>&1 && chmod +x $TEMP_DIR/qrencode >/dev/null 2>&1
  }&
}

# 为了适配 alpine，定义 cmd_systemctl 的函数
cmd_systemctl() {
  nginx_run() {
    $(type -p nginx) -c $WORK_DIR/nginx.conf
  }

  nginx_stop() {
    local NGINX_PID=$(ps -ef | awk -v work_dir="$WORK_DIR" '$0 ~ "nginx -c " work_dir "/nginx.conf" {print $2; exit}')
    ss -nltp | sed -n "/pid=$NGINX_PID,/ s/,/ /gp" | grep -oP 'pid=\K\S+' | sort -u | xargs kill -9 >/dev/null 2>&1
  }

  [ -s $WORK_DIR/nginx.conf ] && local IS_NGINX=is_nginx || local IS_NGINX=no_nginx
  local ENABLE_DISABLE=$1
  local APP=$2
  if [ "$ENABLE_DISABLE" = 'enable' ]; then
    if [ "$SYSTEM" = 'Alpine' ]; then
      # 使用 openrc 启动服务
      rc-service $APP start
      # 添加到开机启动
      rc-update add $APP default
    elif [ "$IS_CENTOS" = 'CentOS7' ]; then
      systemctl daemon-reload
      systemctl enable --now $APP
      [[ "$APP" = 'sing-box' && "$IS_NGINX" = 'is_nginx' ]] && [ -s $WORK_DIR/nginx.conf ] && { nginx_run; firewall_configuration open; }
    else
      systemctl daemon-reload
      systemctl enable --now $APP
    fi

  elif [ "$ENABLE_DISABLE" = 'disable' ]; then
    if [ "$SYSTEM" = 'Alpine' ]; then
      # 使用 openrc 停止服务
      rc-service $APP stop
      # 从开机启动中移除
      rc-update del $APP default
    elif [ "$IS_CENTOS" = 'CentOS7' ]; then
      systemctl disable --now $APP
      [[ "$APP" = 'sing-box' && "$IS_NGINX" = 'is_nginx' ]] && [ -s $WORK_DIR/nginx.conf ] && { nginx_stop; firewall_configuration close; }
    else
      systemctl disable --now $APP
    fi
  elif [ "$ENABLE_DISABLE" = 'status' ]; then
    if [ "$SYSTEM" = 'Alpine' ]; then
      rc-service $APP status
    else
      systemctl is-active $APP
    fi
  fi
}

check_system_info() {
  # 判断虚拟化
  if [ -x "$(type -p systemd-detect-virt)" ]; then
    VIRT=$(systemd-detect-virt)
  elif [ -x "$(type -p hostnamectl)" ]; then
    VIRT=$(hostnamectl | awk '/Virtualization/{print $NF}')
  elif [ -x "$(type -p virt-what)" ]; then
    VIRT=$(virt-what | tr '\n' ' ')
  fi

  [ -s /etc/os-release ] && SYS="$(awk -F '"' 'tolower($0) ~ /pretty_name/{print $2}' /etc/os-release)"
  [[ -z "$SYS" && -x "$(type -p hostnamectl)" ]] && SYS="$(hostnamectl | awk -F ': ' 'tolower($0) ~ /operating system/{print $2}')"
  [[ -z "$SYS" && -x "$(type -p lsb_release)" ]] && SYS="$(lsb_release -sd)"
  [[ -z "$SYS" && -s /etc/lsb-release ]] && SYS="$(awk -F '"' 'tolower($0) ~ /distrib_description/{print $2}' /etc/lsb-release)"
  [[ -z "$SYS" && -s /etc/redhat-release ]] && SYS="$(cat /etc/redhat-release)"
  [[ -z "$SYS" && -s /etc/issue ]] && SYS="$(sed -E '/^$|^\\/d' /etc/issue | awk -F '\' '{print $1}' | sed 's/[ ]*$//g')"

  REGEX=("debian" "ubuntu" "centos|red hat|kernel|alma|rocky" "arch linux" "alpine" "fedora")
  RELEASE=("Debian" "Ubuntu" "CentOS" "Arch" "Alpine" "Fedora")
  EXCLUDE=("---")
  MAJOR=("9" "16" "7" "" "" "37")
  PACKAGE_UPDATE=("apt -y update" "apt -y update" "yum -y update" "pacman -Sy" "apk update -f" "dnf -y update")
  PACKAGE_INSTALL=("apt -y install" "apt -y install" "yum -y install" "pacman -S --noconfirm" "apk add --no-cache" "dnf -y install")
  PACKAGE_UNINSTALL=("apt -y autoremove" "apt -y autoremove" "yum -y autoremove" "pacman -Rcnsu --noconfirm" "apk del -f" "dnf -y autoremove")

  for int in "${!REGEX[@]}"; do
    [[ "${SYS,,}" =~ ${REGEX[int]} ]] && SYSTEM="${RELEASE[int]}" && break
  done
  [ -z "$SYSTEM" ] && error " $(text 5) "

  # 针对各厂商的订制系统
  if [ -z "$SYSTEM" ]; then
    [ -x "$(type -p yum)" ] && int=2 && SYSTEM='CentOS' || error " $(text 5) "
  fi

  # 先排除 EXCLUDE 里包括的特定系统，其他系统需要作大发行版本的比较
  for ex in "${EXCLUDE[@]}"; do [[ ! "{$SYS,,}"  =~ $ex ]]; done &&
  [[ "$(echo "$SYS" | sed "s/[^0-9.]//g" | cut -d. -f1)" -lt "${MAJOR[int]}" ]] && error " $(text 6) "

  # 针对部分系统作特殊处理
  ARGO_DAEMON_FILE='/etc/systemd/system/argo.service'; SINGBOX_DAEMON_FILE='/etc/systemd/system/sing-box.service'; DAEMON_RUN_PATTERN="ExecStart="
  if [ "$SYSTEM" = 'CentOS' ]; then
    IS_CENTOS="CentOS$(echo "$SYS" | sed "s/[^0-9.]//g" | cut -d. -f1)"
  elif [ "$SYSTEM" = 'Alpine' ]; then
    ARGO_DAEMON_FILE='/etc/init.d/argo'; SINGBOX_DAEMON_FILE='/etc/init.d/sing-box'; DAEMON_RUN_PATTERN="command_args="
  fi
}

# 检查系统是否已经安装 tcp-brutal
check_brutal() {
  IS_BRUTAL=false && [ -x "$(type -p lsmod)" ] && lsmod | grep -q brutal && IS_BRUTAL=true
  [ "$IS_BRUTAL" = 'false' ] && [ -x "$(type -p modprobe)" ] && modprobe brutal 2>/dev/null && IS_BRUTAL=true
}

# 检测 IPv4 IPv6 信息
check_system_ip() {
  [ "$L" = 'C' ] && local IS_CHINESE='?lang=zh-CN'
  local DEFAULT_LOCAL_INTERFACE4=$(ip -4 route show default | awk '/default/ {for (i=0; i<NF; i++) if ($i=="dev") {print $(i+1); exit}}')
  local DEFAULT_LOCAL_INTERFACE6=$(ip -6 route show default | awk '/default/ {for (i=0; i<NF; i++) if ($i=="dev") {print $(i+1); exit}}')
  if [ -n "${DEFAULT_LOCAL_INTERFACE4}${DEFAULT_LOCAL_INTERFACE6}" ]; then
    local DEFAULT_LOCAL_IP4=$(ip -4 addr show $DEFAULT_LOCAL_INTERFACE4 | sed -n 's#.*inet \([^/]\+\)/[0-9]\+.*global.*#\1#gp')
    local DEFAULT_LOCAL_IP6=$(ip -6 addr show $DEFAULT_LOCAL_INTERFACE6 | sed -n 's#.*inet6 \([^/]\+\)/[0-9]\+.*global.*#\1#gp')
    [ -n "$DEFAULT_LOCAL_IP4" ] && local BIND_ADDRESS4="--bind-address=$DEFAULT_LOCAL_IP4"
    [ -n "$DEFAULT_LOCAL_IP6" ] && local BIND_ADDRESS6="--bind-address=$DEFAULT_LOCAL_IP6"
  fi

  WAN4=$(wget $BIND_ADDRESS4 -qO- --no-check-certificate --tries=2 --timeout=2 http://api-ipv4.ip.sb)
  [ -n "$WAN4" ] && local IP4_JSON=$(wget -qO- --no-check-certificate --tries=2 --timeout=10 https://ip.forvps.gq/${WAN4}${IS_CHINESE}) &&
  COUNTRY4=$(sed -En 's/.*"country":[ ]*"([^"]+)".*/\1/p' <<< "$IP4_JSON") &&
  ASNORG4=$(sed -En 's/.*"(isp|asn_org)":[ ]*"([^"]+)".*/\2/p' <<< "$IP4_JSON")

  WAN6=$(wget $BIND_ADDRESS6 -qO- --no-check-certificate --tries=2 --timeout=2 http://api-ipv6.ip.sb)
  [ -n "$WAN6" ] && local IP6_JSON=$(wget -qO- --no-check-certificate --tries=2 --timeout=10 https://ip.forvps.gq/${WAN6}${IS_CHINESE}) &&
  COUNTRY6=$(sed -En 's/.*"country":[ ]*"([^"]+)".*/\1/p' <<< "$IP6_JSON") &&
  ASNORG6=$(sed -En 's/.*"(isp|asn_org)":[ ]*"([^"]+)".*/\2/p' <<< "$IP6_JSON")
}

# 获取 sing-box 最新版本
get_sing_box_version() {
  # FORCE_VERSION 用于在 sing-box 某个主程序出现 bug 时，强制为指定版本，以防止运行出错
  local FORCE_VERSION=$(wget --no-check-certificate --tries=2 --timeout=3 -qO- ${GH_PROXY}https://raw.githubusercontent.com/fscarmen/sing-box/refs/heads/main/force_version | sed 's/^[vV]//g; s/\r//g')
  if grep -q '.' <<< "$FORCE_VERSION"; then
    local RESULT_VERSION="$FORCE_VERSION"
  else
    # 先判断 github api 返回 http 状态码是否为 200，有时候 IP 会被限制，导致获取不到最新版本
    local API_RESPONSE=$(wget --no-check-certificate --server-response --tries=2 --timeout=3 -qO- "${GH_PROXY}https://api.github.com/repos/SagerNet/sing-box/releases" 2>&1 | grep -E '^[ ]+HTTP/|tag_name')
    if grep -q 'HTTP.* 200' <<< "$API_RESPONSE"; then
      local VERSION_LATEST=$(awk -F '["v-]' '/tag_name/{print $5}' <<< "$API_RESPONSE" | sort -Vr | sed -n '1p')
      local RESULT_VERSION=$(wget --no-check-certificate --tries=2 --timeout=3 -qO- ${GH_PROXY}https://api.github.com/repos/SagerNet/sing-box/releases | awk -F '["v]' -v var="tag_name.*$VERSION_LATEST" '$0 ~ var {print $5; exit}')
    else
      local RESULT_VERSION="$DEFAULT_NEWEST_VERSION"
    fi
  fi
  echo "$RESULT_VERSION"
}

# 定义 Argo 变量，遇到使用 warp 的话，要求输入正确的 IP
argo_variable() {
  if grep -qi 'cloudflare' <<< "$ASNORG4$ASNORG6"; then
    if grep -qi 'cloudflare' <<< "$ASNORG6" && [ -n "$WAN4" ] && ! grep -qi 'cloudflare' <<< "$ASNORG4"; then
      SERVER_IP_DEFAULT=$WAN4
    elif grep -qi 'cloudflare' <<< "$ASNORG4" && [ -n "$WAN6" ] && ! grep -qi 'cloudflare' <<< "$ASNORG6"; then
      SERVER_IP_DEFAULT=$WAN6
    else
      local a=6
      until [ -n "$SERVER_IP" ]; do
        ((a--)) || true
        [ "$a" = 0 ] && error "\n $(text 3) \n"
        reading "\n $(text 54) " SERVER_IP
      done
    fi
  elif [ -n "$WAN4" ]; then
    SERVER_IP_DEFAULT=$WAN4
  elif [ -n "$WAN6" ]; then
    SERVER_IP_DEFAULT=$WAN6
  fi

  # 根据 IPv4 和 IPv6 的网络状态，使不同的 DNS 策略
  [ -x "$(type -p ping)" ] && for i in {1..3}; do
    ping -c 1 -W 1 "151.101.1.91" &>/dev/null && local IS_IPV4=is_ipv4 && break
  done

  if [ -x "$(type -p ping6)" ]; then
    for i in {1..3}; do
      ping6 -c 1 -W 1 "2a04:4e42:200::347" &>/dev/null && local IS_IPV6=is_ipv6 && break
    done
  elif [ -x "$(type -p ping)" ]; then
    for i in {1..3}; do
      ping -c 1 -W 1 "2a04:4e42:200::347" &>/dev/null && local IS_IPV6=is_ipv6 && break
    done
  fi

  case "${IS_IPV4}@${IS_IPV6}" in
    is_ipv4@is_ipv6)
      STRATEGY=prefer_ipv4
      ;;
    is_ipv4@)
      STRATEGY=ipv4_only
      ;;
    @is_ipv6)
      STRATEGY=ipv6_only
      ;;
    *)
      STRATEGY=prefer_ipv4
      ;;
  esac

  # 检测是否解锁 chatGPT
  [ "$(check_chatgpt $(grep -oE '[46]' <<< "$STRATEGY"))" = 'unlock' ] && CHATGPT_OUT=direct || CHATGPT_OUT=warp-ep

  # 输入服务器 IP,默认为检测到的服务器 IP，如果全部为空，则提示并退出脚本
  ! grep -q 'noninteractive_install' <<< "$NONINTERACTIVE_INSTALL" && [ -z "$SERVER_IP" ] && reading "\n $(text 57) " SERVER_IP
  SERVER_IP=${SERVER_IP:-"$SERVER_IP_DEFAULT"}
  [ -z "$SERVER_IP" ] && error " $(text 65) "

  # 处理可能输入的错误，去掉开头和结尾的空格，去掉最后的 :
  [[ "$NONINTERACTIVE_INSTALL" != 'noninteractive_install' && -z "$ARGO_DOMAIN" ]] && reading "\n $(text 10) " ARGO_DOMAIN
  grep -q '.' <<< "$ARGO_DOMAIN" && ARGO_DOMAIN=$(sed 's/[ ]*//g; s/:[ ]*//' <<< "$ARGO_DOMAIN")

  if [[ -n "$ARGO_DOMAIN" && -z "$ARGO_AUTH" ]]; then
    local a=5
    until [[ "$ARGO_AUTH" =~ TunnelSecret || "$ARGO_AUTH" =~ ^[A-Z0-9a-z=]{120,250}$ || "$ARGO_AUTH" =~ .*cloudflared.*service[[:space:]]+install[[:space:]]+[A-Z0-9a-z=]{1,100} ]]; do
      [ "$a" = 0 ] && error "\n $(text 3) \n" || reading "\n $(text 11) " ARGO_AUTH
      if [[ "$ARGO_AUTH" =~ TunnelSecret ]]; then
        ARGO_JSON=${ARGO_AUTH//[ ]/}
      elif [[ "$ARGO_AUTH" =~ ^[A-Z0-9a-z=]{120,250}$ ]]; then
        ARGO_TOKEN=$ARGO_AUTH
      elif [[ "$ARGO_AUTH" =~ .*cloudflared.*service[[:space:]]+install[[:space:]]+[A-Z0-9a-z=]{1,100} ]]; then
        ARGO_TOKEN=$(awk -F ' ' '{print $NF}' <<< "$ARGO_AUTH")
      else
        warning "\n $(text 45) \n"
      fi
      ((a--)) || true
    done
  fi
}

# 定义 Sing-box 变量
sing_box_variable() {
  local a=6
  until [ -n "$REALITY_PORT" ]; do
    ((a--)) || true
    [ "$a" = 0 ] && error "\n $(text 3) \n"
    REALITY_PORT_DEFAULT=$(shuf -i 100-65535 -n 1)
    ! grep -q 'noninteractive_install' <<< "$NONINTERACTIVE_INSTALL" && reading "\n $(text 56) " REALITY_PORT
    REALITY_PORT=${REALITY_PORT:-"$REALITY_PORT_DEFAULT"}
    ss -nltup | grep ":$REALITY_PORT" >/dev/null 2>&1 && warning "\n $(text 67) \n" && unset REALITY_PORT
  done

  # 提供网上热心网友的anycast域名
  if [ -z "$SERVER" ]; then
    if ! grep -q 'noninteractive_install' <<< "$NONINTERACTIVE_INSTALL"; then
      echo ""
      for c in "${!CDN_DOMAIN[@]}"; do
        hint " $[c+1]. ${CDN_DOMAIN[c]} "
      done

      reading "\n $(text 42) " CUSTOM_CDN
    fi
    case "$CUSTOM_CDN" in
      [1-${#CDN_DOMAIN[@]}] )
        SERVER="${CDN_DOMAIN[$((CUSTOM_CDN-1))]}"
      ;;
      ?????* )
        SERVER="$CUSTOM_CDN"
      ;;
      * )
        SERVER="${CDN_DOMAIN[0]}"
    esac
  fi

  local a=6
  until [[ "${UUID,,}" =~ ^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$ ]]; do
    (( a-- )) || true
    [ "$a" = 0 ] && error "\n $(text 3) \n"
    UUID_DEFAULT=$(cat /proc/sys/kernel/random/uuid)
    ! grep -q 'noninteractive_install' <<< "$NONINTERACTIVE_INSTALL" && reading "\n $(text 12) " UUID
    UUID=${UUID:-"$UUID_DEFAULT"}
    [[ ! "${UUID,,}" =~ ^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$ && "$a" != 1 ]] && warning "\n $(text 4) "
  done

  ! grep -q 'noninteractive_install' <<< "$NONINTERACTIVE_INSTALL" && [ -z "$WS_PATH" ] && reading "\n $(text 13) " WS_PATH
  local a=5
  until [[ -z "$WS_PATH" || "$WS_PATH" =~ ^[A-Z0-9a-z]+$ ]]; do
    (( a-- )) || true
    [ "$a" = 0 ] && error " $(text 3) " || reading " $(text 14) " WS_PATH
  done
  WS_PATH=${WS_PATH:-"$WS_PATH_DEFAULT"}

  # 输入节点名，以系统的 hostname 作为默认
  if [ -z "$NODE_NAME" ]; then
    if [ -x "$(type -p hostname)" ]; then
      NODE_NAME_DEFAULT="$(hostname)"
    elif [ -s /etc/hostname ]; then
      NODE_NAME_DEFAULT="$(cat /etc/hostname)"
    else
      NODE_NAME_DEFAULT="sba"
    fi
    ! grep -q 'noninteractive_install' <<< "$NONINTERACTIVE_INSTALL" && reading "\n $(text 49) " NODE_NAME
    NODE_NAME="${NODE_NAME:-"$NODE_NAME_DEFAULT"}"
  fi
}

check_dependencies() {
  # 如果是 Alpine，先升级 wget
  if [ "$SYSTEM" = 'Alpine' ]; then
    local CHECK_WGET=$(wget 2>&1 | head -n 1)
    grep -qi 'busybox' <<< "$CHECK_WGET" && ${PACKAGE_INSTALL[int]} wget >/dev/null 2>&1

    # Alpine 系统只检查必要的依赖，不需要 systemctl 和 python3
    local DEPS_CHECK=("bash" "rc-update" "virt-what")
    local DEPS_INSTALL=("bash" "openrc" "virt-what")
    for g in "${!DEPS_CHECK[@]}"; do
      [ ! -x "$(type -p ${DEPS_CHECK[g]})" ] && DEPS_ALPINE+=(${DEPS_INSTALL[g]})
    done
    if [ "${#DEPS_ALPINE[@]}" -ge 1 ]; then
      info "\n $(text 7) $(sed "s/ /,&/g" <<< ${DEPS_ALPINE[@]}) \n"
      ${PACKAGE_UPDATE[int]} >/dev/null 2>&1
      ${PACKAGE_INSTALL[int]} ${DEPS_ALPINE[@]} >/dev/null 2>&1
      [[ -z "$VIRT" && "${DEPS_ALPINE[@]}" =~ 'virt-what' ]] && VIRT=$(virt-what | tr '\n' ' ')
    fi
  fi

  # 检测 Linux 系统的依赖，升级库并重新安装依赖
  local DEPS_CHECK=("wget" "ss" "tar" "bash" "nginx" "openssl")
  local DEPS_INSTALL=("wget" "iproute2" "tar" "bash" "nginx" "openssl")

  # 非 Alpine 系统额外需要 systemctl
  [ "$SYSTEM" != 'Alpine' ] && DEPS_CHECK+=("systemctl") && DEPS_INSTALL+=("systemctl")

  for g in "${!DEPS_CHECK[@]}"; do
    [ ! -x "$(type -p ${DEPS_CHECK[g]})" ] && DEPS+=(${DEPS_INSTALL[g]})
  done

  if [ "${#DEPS[@]}" -ge 1 ]; then
    info "\n $(text 7) $(sed "s/ /,&/g" <<< ${DEPS[@]}) \n"
    [ "$SYSTEM" != 'CentOS' ] && ${PACKAGE_UPDATE[int]} >/dev/null 2>&1
    ${PACKAGE_INSTALL[int]} ${DEPS[@]} >/dev/null 2>&1
  else
    info "\n $(text 8) \n"
  fi

  # 如果新安装的 Nginx ，先停掉服务
  [[ "${DEPS[@]}" =~ 'nginx' ]] && cmd_systemctl disable nginx >/dev/null 2>&1
}

# 处理防火墙规则
firewall_configuration() {
  local LISTEN_PORT=$(awk -F [:,] '/"listen_port"/{print $2; exit}' $WORK_DIR/sing-box-conf/inbound.json)
  local NGINX_PORT=$(sed -n 's/.*listen 127.0.0.1:\([0-9]\+\).*/\1/gp' $WORK_DIR/nginx.conf)
  if grep -q "open" <<< "$1"; then
    firewall-cmd --zone=public --add-port=${LISTEN_PORT}/tcp --add-port=${NGINX_PORT}/tcp --permanent >/dev/null 2>&1
  elif grep -q "close" <<< "$1"; then
    firewall-cmd --zone=public --remove-port=${LISTEN_PORT}/tcp --remove-port=${NGINX_PORT}/tcp --permanent >/dev/null 2>&1
  fi
  firewall-cmd --reload >/dev/null 2>&1

  if [[ -s /etc/selinux/config && -x "$(type -p getenforce)" && $(getenforce) = 'Enforcing' ]]; then
    hint "\n $(text 69) "
    setenforce 0
    grep -qs '^SELINUX=disabled$' /etc/selinux/config || sed -i 's/^SELINUX=[epd].*/# &/; /SELINUX=[epd]/a\SELINUX=disabled' /etc/selinux/config
  fi
}

# Nginx 配置文件
json_nginx() {
  if [ -s $WORK_DIR/sing-box-conf/*inbound*.json ]; then
    JSON=$(cat $WORK_DIR/sing-box-conf/*inbound*.json)
    WS_PATH=$(expr "$JSON" : '.*path":"/\(.*\)-vl.*')
    SERVER_IP=${SERVER_IP:-"$(awk -F '"' '/"SERVER_IP"/{print $4}' <<< "$JSON")"}
    UUID=$(awk -F '"' '/"password"/{print $4}' <<< "$JSON")
  fi

  [[ "$SERVER_IP" =~ : ]] && REVERSE_IP="[$SERVER_IP]" || REVERSE_IP="$SERVER_IP"
  local NGINX_CONF="user  root;
worker_processes  auto;

error_log  /dev/null;
pid        /var/run/nginx.pid;

events {
    worker_connections  1024;
}

http {
  map \$http_user_agent \$path {
    default                    /;                # 默认路径
    ~*v2rayN|Neko              /base64;          # 匹配 V2rayN / NekoBox 客户端
    ~*clash                    /clash;           # 匹配 Clash 客户端
    ~*ShadowRocket             /shadowrocket;    # 匹配 ShadowRocket  客户端
    ~*SFM                      /sing-box-pc;     # 匹配 Sing-box pc 客户端
    ~*SFI|SFA                  /sing-box-phone;  # 匹配 Sing-box phone 客户端
 #   ~*Chrome|Firefox|Mozilla  /;                # 添加更多的分流规则
  }

    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '\$remote_addr - \$remote_user [\$time_local] \"\$request\" '
                      '\$status \$body_bytes_sent \"\$http_referer\" '
                      '\"\$http_user_agent\" \"\$http_x_forwarded_for\"';

    access_log  /dev/null;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    #include /etc/nginx/conf.d/*.conf;

  server {"

  # 检查 Nginx 版本，决定使用哪种 HTTP/2 配置语法
  local NGINX_VERSION=$(nginx -v 2>&1 | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
  local NGINX_MAJOR=$(awk -F. '{print $1}' <<< "$NGINX_VERSION")
  local NGINX_MINOR=$(awk -F. '{print $2}' <<< "$NGINX_VERSION")

  # Nginx 1.25.0 及以上版本支持 http2 on; 指令
  if [[ "$NGINX_MAJOR" -gt 1 || ("$NGINX_MAJOR" -eq 1 && "$NGINX_MINOR" -ge 25) ]]; then
    NGINX_CONF+="
    listen 127.0.0.1:3010 ssl; # sing-box backend
    http2 on;"
  else
    # 早期版本使用 listen ... ssl http2; 语法
    NGINX_CONF+="
    listen 127.0.0.1:3010 ssl http2; # sing-box backend"
  fi
  NGINX_CONF+="
    server_name $TLS_SERVER;

    ssl_certificate            $WORK_DIR/cert/cert.pem;
    ssl_certificate_key        $WORK_DIR/cert/private.key;
    ssl_protocols              TLSv1.3;
    ssl_session_tickets        on;
    ssl_stapling               off;
    ssl_stapling_verify        off;

    # 反代 sing-box vless websocket
    location /$WS_PATH-vl {
      if (\$http_upgrade != \"websocket\") {
         return 404;
      }
      proxy_pass                          http://127.0.0.1:3011;
      proxy_http_version                  1.1;
      proxy_set_header Upgrade            \$http_upgrade;
      proxy_set_header Connection         \"upgrade\";
      proxy_set_header X-Real-IP          \$remote_addr;
      proxy_set_header X-Forwarded-For    \$proxy_add_x_forwarded_for;
      proxy_set_header Host               \$host;
      proxy_redirect                      off;
    }

    # 反代 sing-box websocket
    location /$WS_PATH-vm {
      if (\$http_upgrade != \"websocket\") {
         return 404;
      }
      proxy_pass                          http://127.0.0.1:3012;
      proxy_http_version                  1.1;
      proxy_set_header Upgrade            \$http_upgrade;
      proxy_set_header Connection         \"upgrade\";
      proxy_set_header X-Real-IP          \$remote_addr;
      proxy_set_header X-Forwarded-For    \$proxy_add_x_forwarded_for;
      proxy_set_header Host               \$host;
      proxy_redirect                      off;
    }

    location /$WS_PATH-tr {
      if (\$http_upgrade != \"websocket\") {
         return 404;
      }
      proxy_pass                          http://127.0.0.1:3013;
      proxy_http_version                  1.1;
      proxy_set_header Upgrade            \$http_upgrade;
      proxy_set_header Connection         \"upgrade\";
      proxy_set_header X-Real-IP          \$remote_addr;
      proxy_set_header X-Forwarded-For    \$proxy_add_x_forwarded_for;
      proxy_set_header Host               \$host;
      proxy_redirect                      off;
    }

    # 来自 /auto 的分流
    location ~ ^/${UUID}/auto {
      default_type 'text/plain; charset=utf-8';
      alias ${WORK_DIR}/subscribe/\$path;
    }

    location ~ ^/${UUID}/(.*) {
      autoindex on;
      proxy_set_header X-Real-IP \$proxy_protocol_addr;
      default_type 'text/plain; charset=utf-8';
      alias ${WORK_DIR}/subscribe/\$1;
    }
  }
}"
  echo "$NGINX_CONF" > $WORK_DIR/nginx.conf
}

# Json 生成两个配置文件
json_argo() {
  [ ! -s $WORK_DIR/tunnel.json ] && echo $ARGO_JSON > $WORK_DIR/tunnel.json
  [ ! -s $WORK_DIR/tunnel.yml ] && cat > $WORK_DIR/tunnel.yml << EOF
tunnel: $(cut -d\" -f12 <<< $ARGO_JSON)
credentials-file: $WORK_DIR/tunnel.json

ingress:
  - hostname: ${ARGO_DOMAIN}
    service: https://localhost:3010
    originRequest:
      noTLSVerify: true
  - service: http_status:404
EOF
}

# 安装 sba 主程序
install_sba() {
  argo_variable
  sing_box_variable
  wait
  mkdir -p $WORK_DIR/sing-box-conf $WORK_DIR/subscribe $WORK_DIR/logs $WORK_DIR/cert && echo "$L" > $WORK_DIR/language
  [ -s "$VARIABLE_FILE" ] && cp $VARIABLE_FILE $WORK_DIR/

  # 把临时目录下载的可执行二进制文件移动到工作目录
  for g in {cloudflared,jq,qrencode}; do
    [[ ! -s $WORK_DIR/$g && -x $TEMP_DIR/$g ]] && mv $TEMP_DIR/$g $WORK_DIR
  done

  if [[ -n "${ARGO_JSON}" && -n "${ARGO_DOMAIN}" ]]; then
    ARGO_RUNS="$WORK_DIR/cloudflared tunnel --edge-ip-version auto --config $WORK_DIR/tunnel.yml run"
    json_argo
  elif [[ -n "${ARGO_TOKEN}" && -n "${ARGO_DOMAIN}" ]]; then
    ARGO_RUNS="$WORK_DIR/cloudflared tunnel --edge-ip-version auto run --token ${ARGO_TOKEN}"
  else
    ARGO_RUNS="$WORK_DIR/cloudflared tunnel --edge-ip-version auto --no-autoupdate --no-tls-verify --metrics 0.0.0.0:$METRICS_PORT --url https://localhost:3010"
  fi

  # 生成100年的自签证书
  openssl ecparam -genkey -name prime256v1 -out $WORK_DIR/cert/private.key && openssl req -new -x509 -days 36500 -key $WORK_DIR/cert/private.key -out $WORK_DIR/cert/cert.pem -subj "/CN=$(awk -F . '{print $(NF-1)"."$NF}' <<< "$TLS_SERVER")"

  # Argo 生成守护进程文件
  if [ "$SYSTEM" = 'Alpine' ]; then
    # 分离命令和参数
    local COMMAND=${ARGO_RUNS%% --*}  # 提取命令部分（包括 cloudflared tunnel）
    local ARGS=${ARGO_RUNS#$COMMAND }  # 提取参数部分

    cat > ${ARGO_DAEMON_FILE} << EOF
#!/sbin/openrc-run

name="argo"
description="Cloudflare Tunnel"
command="${COMMAND}"
command_args="${ARGS}"
pidfile="/var/run/\${RC_SVCNAME}.pid"
command_background="yes"
output_log="$WORK_DIR/argo.log"
error_log="$WORK_DIR/argo.log"

depend() {
    need net
    after net
}

start_pre() {
    # 确保日志目录存在
    mkdir -p $WORK_DIR

    # 如果需要启动 nginx
    if [ -s $WORK_DIR/nginx.conf ]; then
        $(type -p nginx) -c $WORK_DIR/nginx.conf
    fi
}

stop_post() {
    # 停止服务时检查并关闭相关的 nginx 进程
    if [ -s $WORK_DIR/nginx.conf ]; then
        # 查找使用我们配置文件的 nginx 进程并停止它
        local NGINX_PIDS=\$(ps -ef | awk -v work_dir="$WORK_DIR" '{if (\$0 ~ "nginx.*" work_dir "/nginx.conf") print \$1}')
        [ -n "\$NGINX_PIDS" ] && echo " * Stopping nginx processes: \$NGINX_PIDS" && kill -15 \$NGINX_PIDS 2>/dev/null
    fi
}
EOF
    chmod +x ${ARGO_DAEMON_FILE}
  else
    # 创建 systemd 服务
    local ARGO_SERVER="[Unit]
Description=Cloudflare Tunnel
After=network.target

[Service]
Type=simple
NoNewPrivileges=yes
TimeoutStartSec=0"
    [ "$IS_CENTOS" != 'CentOS7' ] && ARGO_SERVER+="
ExecStartPre=$(type -p nginx) -c $WORK_DIR/nginx.conf"
    ARGO_SERVER+="
ExecStart=$ARGO_RUNS
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target"

    echo "$ARGO_SERVER" > ${ARGO_DAEMON_FILE}
  fi

  # Sing-box 生成守护进程文件
  if [ "$SYSTEM" = 'Alpine' ]; then
    cat > ${SINGBOX_DAEMON_FILE} << EOF
#!/sbin/openrc-run

name="Sing-Box"
description="Sing-Box Service"
command="$WORK_DIR/sing-box"
command_args="run -C $WORK_DIR/sing-box-conf"
command_background=true
pidfile="/run/sing-box.pid"
output_log="/var/log/sing-box.log"
error_log="/var/log/sing-box.err"

depend() {
    need net
    after firewall
}
EOF
    chmod +x ${SINGBOX_DAEMON_FILE}
  else
    cat > ${SINGBOX_DAEMON_FILE} << EOF
[Unit]
Description=sing-box service
Documentation=https://sing-box.sagernet.org
After=network.target nss-lookup.target

[Service]
User=root
WorkingDirectory=$WORK_DIR
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SYS_PTRACE CAP_DAC_READ_SEARCH
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SYS_PTRACE CAP_DAC_READ_SEARCH
ExecStart=$WORK_DIR/sing-box run -C $WORK_DIR/sing-box-conf
ExecReload=/bin/kill -HUP \$MAINPID
Restart=on-failure
RestartSec=10
LimitNOFILE=infinity

[Install]
WantedBy=multi-user.target
EOF
  fi

  # 等待 sing-box 二进制文件下载成功并搬到 $WORK_DIR，40秒超时报错退出
  local i=1
  [ ! -s $WORK_DIR/sing-box ] && wait && while [ "$i" -le 20 ]; do [ -s $TEMP_DIR/sing-box ] && mv $TEMP_DIR/sing-box $WORK_DIR && break; ((i++)); sleep 2; done
  [ "$i" -ge 20 ] && local APP=Sing-box && error "\n $(text 48) "

  # 生成 reality 的公私钥
  REALITY_KEYPAIR=$($WORK_DIR/sing-box generate reality-keypair)
  [ -z "$REALITY_PRIVATE" ] && REALITY_PRIVATE=$(awk '/PrivateKey/{print $NF}' <<< "$REALITY_KEYPAIR")
  [ -z "$REALITY_PUBLIC" ] && REALITY_PUBLIC=$(awk '/PublicKey/{print $NF}' <<< "$REALITY_KEYPAIR")
  cat > $WORK_DIR/sing-box-conf/inbound.json << EOF
//  "SERVER_IP":"${SERVER_IP}"
//  "REALITY_PUBLIC":"${REALITY_PUBLIC}"
//  "SERVER":"${SERVER}"
{
    "log":{
        "disabled":false,
        "level":"error",
        "output":"$WORK_DIR/logs/box.log",
        "timestamp":true
    },
    "experimental": {
        "cache_file": {
            "enabled": true,
            "path": "$WORK_DIR/cache.db"
        }
    },
    "dns":{
        "servers":[
            {
                "type":"local"
            }
        ],
        "strategy":"$STRATEGY"
    },
    "ntp": {
        "enabled": true,
        "server": "time.apple.com",
        "server_port": 123,
        "interval": "60m"
    },
    "inbounds":[
        {
            "type":"vless",
            "tag":"${NODE_NAME} vless-reality-vision",
            "listen":"::",
            "listen_port":${REALITY_PORT},
            "users":[
                {
                    "uuid":"${UUID}",
                    "flow":"xtls-rprx-vision"
                }
            ],
            "tls":{
                "enabled":true,
                "server_name":"${TLS_SERVER}",
                "reality":{
                    "enabled":true,
                    "handshake":{
                        "server":"127.0.0.1",
                        "server_port":3010
                    },
                    "private_key":"${REALITY_PRIVATE}",
                    "short_id":[
                        ""
                    ]
                }
            },
            "multiplex":{
                "enabled":false,
                "padding":false,
                "brutal":{
                    "enabled":false,
                    "up_mbps":1000,
                    "down_mbps":1000
                }
            }
        },
        {
            "type":"vless",
            "tag":"vless-in",
            "listen":"127.0.0.1",
            "listen_port":3011,
            "transport":{
                "type":"ws",
                "path":"/${WS_PATH}-vl",
                "max_early_data":2560,
                "early_data_header_name":"Sec-WebSocket-Protocol"
            },
            "multiplex":{
                "enabled":true,
                "padding":true,
                "brutal":{
                    "enabled":${IS_BRUTAL},
                    "up_mbps":1000,
                    "down_mbps":1000
                }
            },
            "users":[
                {
                    "uuid":"${UUID}",
                    "flow":""
                }
            ]
        },
        {
            "type":"vmess",
            "tag":"vmess-in",
            "listen":"127.0.0.1",
            "listen_port":3012,
            "transport":{
                "type":"ws",
                "path":"/${WS_PATH}-vm",
                "max_early_data":2560,
                "early_data_header_name":"Sec-WebSocket-Protocol"
            },
            "multiplex":{
                "enabled":true,
                "padding":true,
                "brutal":{
                    "enabled":${IS_BRUTAL},
                    "up_mbps":1000,
                    "down_mbps":1000
                }
            },
            "users":[
                {
                    "uuid":"${UUID}",
                    "alterId":0
                }
            ]
        },
        {
            "type":"trojan",
            "tag":"trojan-in",
            "listen":"127.0.0.1",
            "listen_port":3013,
            "transport":{
                "type":"ws",
                "path":"/${WS_PATH}-tr",
                "max_early_data":2560,
                "early_data_header_name":"Sec-WebSocket-Protocol"
            },
            "multiplex":{
                "enabled":true,
                "padding":true,
                "brutal":{
                    "enabled":${IS_BRUTAL},
                    "up_mbps":1000,
                    "down_mbps":1000
                }
            },
            "users":[
                {
                    "password":"${UUID}"
                }
            ]
        }
    ]
}
EOF
  cat > $WORK_DIR/sing-box-conf/outbound.json << EOF
{
    "endpoints":[
        {
            "type":"wireguard",
            "tag":"warp-ep",
            "mtu":1280,
            "address":[
                "172.16.0.2/32",
                "2606:4700:110:8a36:df92:102a:9602:fa18/128"
            ],
            "private_key":"YFYOAdbw1bKTHlNNi+aEjBM3BO7unuFC5rOkMRAz9XY=",
            "peers": [
              {
                "address": "engage.cloudflareclient.com",
                "port":2408,
                "public_key":"bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
                "allowed_ips": [
                  "0.0.0.0/0",
                  "::/0"
                ],
                "reserved":[
                    78,
                    135,
                    76
                ]
              }
            ]
        }
    ],
    "outbounds":[
        {
            "type":"direct",
            "tag":"direct"
        }
    ],
    "route":{
        "rule_set":[
            {
                "tag":"geosite-openai",
                "type":"remote",
                "format":"binary",
                "url":"https://raw.githubusercontent.com/SagerNet/sing-geosite/rule-set/geosite-openai.srs"
            }
        ],
        "rules":[
            {
                "action": "sniff"
            },
            {
                "action": "resolve",
                "domain":[
                    "api.openai.com"
                ],
                "strategy": "prefer_ipv4"
            },
            {
                "action": "resolve",
                "rule_set":[
                    "geosite-openai"
                ],
                "strategy": "prefer_ipv6"
            },
            {
                "domain":[
                    "api.openai.com"
                ],
                "rule_set":[
                    "geosite-openai"
                ],
                "outbound":"${CHATGPT_OUT}"
            }
        ]
    }
}
EOF

  # 生成 Nginx 配置文件
  json_nginx

  # CentOS 打开防火墙端口
  [ "$SYSTEM" = 'CentOS' ] && firewall_configuration open

  # 再次检测状态，运行 Argo 和 Sing-box
  check_install
  case "${STATUS[0]}" in
    "$(text 26)" )
      warning "\n Argo $(text 28) $(text 38) \n"
      ;;
    "$(text 27)" )
      cmd_systemctl enable argo && info "\n Argo $(text 28) $(text 37) \n"
      ;;
    "$(text 28)" )
      info "\n Argo $(text 28) $(text 37) \n"
  esac

  case "${STATUS[1]}" in
    "$(text 26)" )
      warning "\n Sing-box $(text 28) $(text 38) \n"
      ;;
    "$(text 27)" )
      cmd_systemctl enable sing-box && info "\n Sing-box $(text 28) $(text 37) \n"
      ;;
    "$(text 28)" )
      info "\n Sing-box $(text 28) $(text 37) \n"
  esac
}

# 创建快捷方式
create_shortcut() {
  cat > $WORK_DIR/sb.sh << EOF
#!/usr/bin/env bash

bash <(wget --no-check-certificate -qO- https://raw.githubusercontent.com/fscarmen/sba/main/sba.sh) \$1
EOF
  chmod +x $WORK_DIR/sb.sh
  ln -sf $WORK_DIR/sb.sh /usr/bin/sb

  # 如果 /usr/bin 不在 PATH 中，添加到 ~/.bashrc
  if [[ ! ":$PATH:" == *":/usr/bin:"* ]]; then
    echo 'export PATH=$PATH:/usr/bin' >> ~/.bashrc
    source ~/.bashrc
  fi

  [ -s /usr/bin/sb ] && hint "\n $(text 62) "
}

export_list() {
  check_install

  # v1.0.9 处理的 jq 和 qrencode 二进制文件代替系统依赖的问题，此处预计6月30日删除
  [[ ! -s $WORK_DIR/jq && -s /usr/bin/jq ]] && cp /usr/bin/jq $WORK_DIR/
  if [ ! -s $WORK_DIR/qrencode ]; then
    check_arch
    wget -qO $WORK_DIR/qrencode ${GH_PROXY}https://github.com/fscarmen/client_template/raw/main/qrencode-go/qrencode-go-linux-$QRENCODE_ARCH && chmod +x $WORK_DIR/qrencode
  fi

  # 没有开启 Argo 和 Sing-box 服务，将不输出节点信息
  local APP
  [ "${STATUS[0]}" != "$(text 28)" ] && APP+=(argo)
  [ "${STATUS[1]}" != "$(text 28)" ] && APP+=(sing-box)
  if [ "${#APP[@]}" -gt 0 ]; then
    reading "\n $(text 50) " OPEN_APP
    if [ "${OPEN_APP,,}" = 'y' ]; then
      [ "${STATUS[0]}" != "$(text 28)" ] && cmd_systemctl enable argo
      [ "${STATUS[1]}" != "$(text 28)" ] && cmd_systemctl enable sing-box
    else
      exit
    fi
  fi

  # 如果是临时隧道，即实时获取其域名
  if grep -qs 'metrics.*url' ${ARGO_DAEMON_FILE}; then
    local a=5
    until [[ -n "$ARGO_DOMAIN" || "$a" = 0 ]]; do
      sleep 8
      local REALTIME_METRICS_PORT=$(sed -n 's/.*--metrics.*:\([0-9]\+\) .*/\1/gp' ${ARGO_DAEMON_FILE})
      ARGO_DOMAIN=$(wget -qO- http://localhost:${REALTIME_METRICS_PORT}/quicktunnel | awk -F '"' '{print $4}')
      ((a--)) || true
    done
  else
    ARGO_DOMAIN=${ARGO_DOMAIN:-"$(grep -m1 '^trojan' $WORK_DIR/list | sed "s@.*host=\(.*\)&.*@\1@g")"}
  fi
  JSON=$(cat $WORK_DIR/sing-box-conf/*inbound*.json)
  SERVER_IP=${SERVER_IP:-"$(awk -F '"' '/"SERVER_IP"/{print $4}' <<< "$JSON")"}
  REALITY_PORT=${REALITY_PORT:-"$(awk -F '[:,]' '/"listen_port"/{print $2; exit}' <<< "$JSON")"}
  REALITY_PUBLIC=${REALITY_PUBLIC:-"$(awk -F '"' '/"REALITY_PUBLIC"/{print $4}' <<< "$JSON")"}
  REALITY_PRIVATE=${REALITY_PRIVATE:-"$(awk -F '"' '/"private_key"/{print $4}' <<< "$JSON")"}
  TLS_SERVER=${TLS_SERVER:-"$(awk -F '"' '/"server_name"/{print $4}' <<< "$JSON")"}
  SERVER=${SERVER:-"$(awk -F '"' '/"SERVER"/{print $4}' <<< "$JSON")"}
  UUID=${UUID:-"$(awk -F '"' '/"password"/{print $4}' <<< "$JSON")"}
  WS_PATH=${WS_PATH:-"$(expr "$JSON" : '.*path":"/\(.*\)-vl.*')"}
  NODE_NAME=${NODE_NAME:-"$(sed -n 's/.*tag":"\(.*\) vless-reality-vision.*/\1/gp' <<< "$JSON")"}

  # IPv6 时的 IP 处理
  if [[ "$SERVER_IP" =~ : ]]; then
    SERVER_IP_1="[$SERVER_IP]"
    SERVER_IP_2="[[$SERVER_IP]]"
  else
    SERVER_IP_1="$SERVER_IP"
    SERVER_IP_2="$SERVER_IP"
  fi

  # 若为临时隧道，处理查询方法
  grep -qs 'metrics.*url' ${ARGO_DAEMON_FILE} && QUICK_TUNNEL_URL=$(text 60)

  # 生成 vmess 文件
  VMESS="{ \"v\": \"2\", \"ps\": \"${NODE_NAME}-Vm\", \"add\": \"${SERVER}\", \"port\": \"443\", \"id\": \"${UUID}\", \"aid\": \"0\", \"scy\": \"auto\", \"net\": \"ws\", \"type\": \"none\", \"host\": \"${ARGO_DOMAIN}\", \"path\": \"/${WS_PATH}-vm?ed=2560\", \"tls\": \"tls\", \"sni\": \"${ARGO_DOMAIN}\", \"alpn\": \"\" }"

  # 生成各订阅文件
  # 生成 Clash proxy providers 订阅文件
  local CLASH_SUBSCRIBE="proxies:
  - {name: \"${NODE_NAME} vless-reality-vision\", type: vless, server: ${SERVER_IP}, port: ${REALITY_PORT}, uuid: ${UUID}, network: tcp, udp: true, tls: true, flow: xtls-rprx-vision, servername: ${TLS_SERVER}, client-fingerprint: firefox, reality-opts: {public-key: ${REALITY_PUBLIC}, short-id: \"\"}, smux: { enabled: false, protocol: 'h2mux', padding: false, max-connections: '8', min-streams: '16', statistic: true, only-tcp: false }, brutal-opts: { enabled: false, up: '1000 Mbps', down: '1000 Mbps' } }
  - {name: \"${NODE_NAME}-Vl\", type: vless, server: ${SERVER}, port: 443, uuid: ${UUID}, tls: true, servername: ${ARGO_DOMAIN}, skip-cert-verify: false, network: ws, ws-opts: { path: \"/${WS_PATH}-vl\", headers: { Host: ${ARGO_DOMAIN}}, max-early-data: 2560, early-data-header-name: Sec-WebSocket-Protocol}, udp: true, smux: { enabled: true, protocol: 'h2mux', padding: true, max-connections: '8', min-streams: '16', statistic: true, only-tcp: false }, brutal-opts: { enabled: ${IS_BRUTAL}, up: '1000 Mbps', down: '1000 Mbps' } }
  - {name: \"${NODE_NAME}-Vm\", type: vmess, server: ${SERVER}, port: 443, uuid: ${UUID}, alterId: 0, cipher: auto, tls: true, skip-cert-verify: false, servername: ${ARGO_DOMAIN}, network: ws, ws-opts: { path: \"/${WS_PATH}-vm\", headers: { Host: ${ARGO_DOMAIN}}, max-early-data: 2560, early-data-header-name: Sec-WebSocket-Protocol}, udp: true, smux: { enabled: true, protocol: 'h2mux', padding: true, max-connections: '8', min-streams: '16', statistic: true, only-tcp: false }, brutal-opts: { enabled: ${IS_BRUTAL}, up: '1000 Mbps', down: '1000 Mbps' } }
  - {name: \"${NODE_NAME}-Tr\", type: trojan, server: ${SERVER}, port: 443, password: ${UUID}, udp: true, tls: true, sni: ${ARGO_DOMAIN}, skip-cert-verify: false, network: ws, ws-opts: { path: \"/${WS_PATH}-tr\", headers: { Host: ${ARGO_DOMAIN}}, max-early-data: 2560, early-data-header-name: Sec-WebSocket-Protocol}, smux: { enabled: true, protocol: 'h2mux', padding: true, max-connections: '8', min-streams: '16', statistic: true, only-tcp: false }, brutal-opts: { enabled: ${IS_BRUTAL}, up: '1000 Mbps', down: '1000 Mbps' } }"

  echo -n "${CLASH_SUBSCRIBE}" > $WORK_DIR/subscribe/proxies

  # 生成 clash 订阅配置文件
  wget --no-check-certificate -qO- --tries=3 --timeout=2 ${SUBSCRIBE_TEMPLATE}/clash | sed "s#NODE_NAME#${NODE_NAME}#g; s#PROXY_PROVIDERS_URL#http://${ARGO_DOMAIN}/${UUID}/proxies#" > $WORK_DIR/subscribe/clash

  # 生成 ShadowRocket 订阅文件
  local SHADOWROCKET_SUBSCRIBE="vless://$(echo -n "auto:${UUID}@${SERVER_IP_2}:${REALITY_PORT}" | base64 -w0)?remarks=${NODE_NAME// /%20}%20vless-reality-vision&tls=1&peer=$TLS_SERVER&xtls=2&pbk=$REALITY_PUBLIC
vless://$(echo -n "auto:${UUID}@${SERVER}:443" | base64 -w0)?remarks=${NODE_NAME// /%20}-Vl&obfsParam=${ARGO_DOMAIN}&path=/${WS_PATH}-vl?ed=2560&obfs=websocket&tls=1&peer=${ARGO_DOMAIN}&mux=1
vmess://$(echo -n "auto:${UUID}@${SERVER}:443" | base64 -w0)?remarks=${NODE_NAME// /%20}-Vm&obfsParam=${ARGO_DOMAIN}&path=/${WS_PATH}-vm?ed=2560&obfs=websocket&tls=1&peer=${ARGO_DOMAIN}&mux=1&alterId=0
trojan://${UUID}@${SERVER}:443?peer=${ARGO_DOMAIN}&mux=1&plugin=obfs-local;obfs=websocket;obfs-host=${ARGO_DOMAIN};obfs-uri=/${WS_PATH}-tr?ed=2560#${NODE_NAME// /%20}-Tr"

  echo -n "${SHADOWROCKET_SUBSCRIBE}" | base64 -w0 > $WORK_DIR/subscribe/shadowrocket

  # 生成 V2rayN / NekoBox 订阅文件
  local V2RAYN_SUBSCRIBE="vless://${UUID}@${SERVER_IP_1}:${REALITY_PORT}?flow=xtls-rprx-vision&security=reality&sni=${TLS_SERVER}&fp=firefox&pbk=${REALITY_PUBLIC}&type=tcp&encryption=none#${NODE_NAME}%20vless-reality-vision
vless://${UUID}@${SERVER}:443?encryption=none&security=tls&sni=${ARGO_DOMAIN}&type=ws&host=${ARGO_DOMAIN}&path=%2F${WS_PATH}-vl%3Fed%3D2560#${NODE_NAME}-Vl
vmess://$(echo -n "$VMESS" | base64 -w0)
trojan://${UUID}@${SERVER}:443?security=tls&sni=${ARGO_DOMAIN}&type=ws&host=${ARGO_DOMAIN}&path=%2F${WS_PATH}-tr%3Fed%3D2560#${NODE_NAME}-Tr"

  echo -n "${V2RAYN_SUBSCRIBE}" | base64 -w0 > $WORK_DIR/subscribe/base64

  # 生成 Sing-box 订阅文件
  local INBOUND_REPLACE="{ \"type\":\"vless\", \"tag\":\"${NODE_NAME} vless-reality-vision\", \"server\":\"${SERVER_IP}\", \"server_port\":${REALITY_PORT}, \"uuid\":\"${UUID}\", \"flow\":\"xtls-rprx-vision\", \"packet_encoding\":\"xudp\", \"tls\":{ \"enabled\":true, \"server_name\":\"${TLS_SERVER}\", \"utls\":{ \"enabled\":true, \"fingerprint\":\"firefox\" }, \"reality\":{ \"enabled\":true, \"public_key\":\"${REALITY_PUBLIC}\", \"short_id\":\"\" } }, \"multiplex\":{ \"enabled\":false, \"protocol\":\"h2mux\", \"max_connections\":16, \"padding\": false, \"brutal\":{ \"enabled\":false, \"up_mbps\":1000, \"down_mbps\":1000 } } }, { \"type\": \"vless\", \"tag\": \"${NODE_NAME}-Vl\", \"server\":\"${SERVER}\", \"server_port\":443, \"uuid\":\"${UUID}\", \"tls\": { \"enabled\":true, \"server_name\":\"${ARGO_DOMAIN}\", \"utls\": { \"enabled\":true, \"fingerprint\":\"firefox\" } }, \"transport\": { \"type\":\"ws\", \"path\":\"/${WS_PATH}-vl\", \"headers\": { \"Host\": \"${ARGO_DOMAIN}\" }, \"max_early_data\":2560, \"early_data_header_name\":\"Sec-WebSocket-Protocol\" }, \"multiplex\": { \"enabled\":true, \"protocol\":\"h2mux\", \"max_streams\":16, \"padding\": true, \"brutal\":{ \"enabled\":${IS_BRUTAL}, \"up_mbps\":1000, \"down_mbps\":1000 } } }, { \"type\": \"vmess\", \"tag\": \"${NODE_NAME}-Vm\", \"server\":\"${SERVER}\", \"server_port\":443, \"uuid\":\"${UUID}\", \"security\": \"auto\", \"alter_id\": 0, \"tls\": { \"enabled\":true, \"server_name\":\"${ARGO_DOMAIN}\", \"utls\": { \"enabled\":true, \"fingerprint\":\"firefox\" } }, \"transport\": { \"type\":\"ws\", \"path\":\"/${WS_PATH}-vm\", \"headers\": { \"Host\": \"${ARGO_DOMAIN}\" }, \"max_early_data\":2560, \"early_data_header_name\":\"Sec-WebSocket-Protocol\" }, \"multiplex\": { \"enabled\":true, \"protocol\":\"h2mux\", \"max_streams\":16, \"padding\": true, \"brutal\":{ \"enabled\":${IS_BRUTAL}, \"up_mbps\":1000, \"down_mbps\":1000 } } }, { \"type\":\"trojan\", \"tag\":\"${NODE_NAME}-Tr\", \"server\": \"${SERVER}\", \"server_port\": 443, \"password\": \"${UUID}\", \"tls\": { \"enabled\":true, \"server_name\":\"${ARGO_DOMAIN}\", \"utls\": { \"enabled\":true, \"fingerprint\":\"firefox\" } }, \"transport\": { \"type\":\"ws\", \"path\":\"/${WS_PATH}-tr\", \"headers\": { \"Host\": \"${ARGO_DOMAIN}\" }, \"max_early_data\":2560, \"early_data_header_name\":\"Sec-WebSocket-Protocol\" }, \"multiplex\": { \"enabled\":true, \"protocol\":\"h2mux\", \"max_connections\": 16, \"padding\": true, \"brutal\":{ \"enabled\":${IS_BRUTAL}, \"up_mbps\":1000, \"down_mbps\":1000 } } }"
  local NODE_REPLACE="\"${NODE_NAME} vless-reality-vision\", \"${NODE_NAME}-Vl\", \"${NODE_NAME}-Vm\", \"${NODE_NAME}-Tr\""

  # 模板
  local SING_BOX_JSON1=$(wget --no-check-certificate -qO- --tries=3 --timeout=2 ${SUBSCRIBE_TEMPLATE}/sing-box1)
  echo $SING_BOX_JSON1 | sed 's#, {[^}]\+"tun-in"[^}]\+}##' | sed "s#\"<INBOUND_REPLACE>\"#$INBOUND_REPLACE#; s#\"<NODE_REPLACE>\"#$NODE_REPLACE#g" | $WORK_DIR/jq > $WORK_DIR/subscribe/sing-box-pc
  echo $SING_BOX_JSON1 | sed 's# {[^}]\+"mixed"[^}]\+},##; s#, "auto_detect_interface": true##' | sed "s#\"<INBOUND_REPLACE>\"#$INBOUND_REPLACE#; s#\"<NODE_REPLACE>\"#$NODE_REPLACE#g" | $WORK_DIR/jq > $WORK_DIR/subscribe/sing-box-phone

  # 生成二维码 url 文件
  cat > $WORK_DIR/subscribe/qr << EOF
$(text 68):
https://${ARGO_DOMAIN}/${UUID}/auto

$(text 66) QRcode:
https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=https://${ARGO_DOMAIN}/${UUID}/auto

$($WORK_DIR/qrencode "https://${ARGO_DOMAIN}/${UUID}/auto")
EOF

  # 生成客户端配置文件
  cat > $WORK_DIR/list << EOF
*******************************************
┌────────────────┐  ┌────────────────┐
│                │  │                │
│     $(warning "V2rayN")     │  │    $(warning "NekoBox")     │
│                │  │                │
└────────────────┘  └────────────────┘
----------------------------

$(info "$(sed "G" <<< "${V2RAYN_SUBSCRIBE}")

+++++ $(text 61) +++++")

*******************************************
┌────────────────┐
│                │
│  $(warning "ShadowRocket")  │
│                │
└────────────────┘
----------------------------

$(hint "$(sed "G" <<< "${SHADOWROCKET_SUBSCRIBE}")")

*******************************************
┌────────────────┐
│                │
│   $(warning "Clash Meta")   │
│                │
└────────────────┘
----------------------------

$(info "$(sed '1d;G' <<< "$CLASH_SUBSCRIBE")")

*******************************************
┌────────────────┐
│                │
│    $(warning "Sing-box")    │
│                │
└────────────────┘
----------------------------

$(hint "$(echo "{ \"outbounds\":[ ${INBOUND_REPLACE%,} ] }" | $WORK_DIR/jq)

 $(text 63)")

*******************************************

$(info "Index:
https://${ARGO_DOMAIN}/${UUID}/

QR code:
https://${ARGO_DOMAIN}/${UUID}/qr

V2rayN / Nekoray $(text 66):
https://${ARGO_DOMAIN}/${UUID}/base64")

$(info "Clash $(text 66):
https://${ARGO_DOMAIN}/${UUID}/clash

sing-box for pc $(text 66):
https://${ARGO_DOMAIN}/${UUID}/sing-box-pc

sing-box for cellphone $(text 66):
https://${ARGO_DOMAIN}/${UUID}/sing-box-phone

ShadowRocket $(text 66):
https://${ARGO_DOMAIN}/${UUID}/shadowrocket")

*******************************************

$(hint " $(text 68):
https://${ARGO_DOMAIN}/${UUID}/auto

 $(text 66) QRcode:
https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=https://${ARGO_DOMAIN}/${UUID}/auto")

$($WORK_DIR/qrencode https://${ARGO_DOMAIN}/${UUID}/auto)

*******************************************

$(info " ${QUICK_TUNNEL_URL} ")
EOF

  # 显示节点信息
  cat $WORK_DIR/list

  # 显示脚本使用情况数据
  # statistics_of_run-times get
}

# 更换 Argo 隧道类型
change_argo() {
  check_install
  [[ ${STATUS[0]} = "$(text 26)" ]] && error " $(text 39) "
  SERVER_IP=$(awk -F '"' '/"SERVER_IP"/{print $4}' $WORK_DIR/sing-box-conf/*inbound*.json)

  case $(grep "${DAEMON_RUN_PATTERN}" ${ARGO_DAEMON_FILE}) in
    *--config* )
      ARGO_TYPE='Json'; ARGO_DOMAIN="$(grep -m1 '^vless' $WORK_DIR/list | sed "s@.*host=\(.*\)&.*@\1@g")" ;;
    *--token* )
      ARGO_TYPE='Token'; ARGO_DOMAIN="$(grep -m1 '^vless' $WORK_DIR/list | sed "s@.*host=\(.*\)&.*@\1@g")" ;;
    * )
      ARGO_TYPE='Try'
      ARGO_DOMAIN=$(wget -qO- http://localhost:${METRICS_PORT}/quicktunnel | awk -F '"' '{print $4}')
  esac

  hint "\n $(text 40) \n"
  unset ARGO_DOMAIN
  hint " $(text 41) \n" && reading " $(text 24) " CHANGE_TO
  case "$CHANGE_TO" in
    1 )
      cmd_systemctl disable argo
      [ -s $WORK_DIR/tunnel.json ] && rm -f $WORK_DIR/tunnel.{json,yml}
      if [ "$SYSTEM" = 'Alpine' ]; then
        # 修改 Alpine 的 OpenRC 服务文件
        local ARGS="--edge-ip-version auto --no-autoupdate --no-tls-verify --metrics 0.0.0.0:${METRICS_PORT} --url http://localhost:3010"
        sed -i "s@^command_args=.*@command_args=\"$ARGS\"@g" ${ARGO_DAEMON_FILE}
      else
        # 修改 systemd 服务文件
        sed -i "s@ExecStart=.*@ExecStart=$WORK_DIR/cloudflared tunnel --edge-ip-version auto --no-autoupdate --no-tls-verify --metrics 0.0.0.0:${METRICS_PORT} --url http://localhost:3010@g" ${ARGO_DAEMON_FILE}
      fi
      ;;
    2 )
      SERVER_IP=$(awk -F '"' '/"SERVER_IP"/{print $4}' $WORK_DIR/sing-box-conf/*inbound*.json)
      argo_variable
      cmd_systemctl disable argo
      if [ -n "$ARGO_TOKEN" ]; then
        [ -s $WORK_DIR/tunnel.json ] && rm -f $WORK_DIR/tunnel.{json,yml}
        if [ "$SYSTEM" = 'Alpine' ]; then
          # 修改 Alpine 的 OpenRC 服务文件
          local ARGS="--edge-ip-version auto run --token ${ARGO_TOKEN}"
          sed -i "s@^command_args=.*@command_args=\"$ARGS\"@g" ${ARGO_DAEMON_FILE}
        else
          # 修改 systemd 服务文件
          sed -i "s@ExecStart=.*@ExecStart=$WORK_DIR/cloudflared tunnel --edge-ip-version auto run --token ${ARGO_TOKEN}@g" ${ARGO_DAEMON_FILE}
        fi
      elif [ -n "$ARGO_JSON" ]; then
        [ -s $WORK_DIR/tunnel.json ] && rm -f $WORK_DIR/tunnel.{json,yml}
        json_argo
        if [ "$SYSTEM" = 'Alpine' ]; then
          # 修改 Alpine 的 OpenRC 服务文件
          local ARGS="--edge-ip-version auto --config $WORK_DIR/tunnel.yml run"
          sed -i "s@^command_args=.*@command_args=\"$ARGS\"@g" ${ARGO_DAEMON_FILE}
        else
          # 修改 systemd 服务文件
          sed -i "s@ExecStart=.*@ExecStart=$WORK_DIR/cloudflared tunnel --edge-ip-version auto --config $WORK_DIR/tunnel.yml run@g" ${ARGO_DAEMON_FILE}
        fi
      fi
      ;;
    * )
      exit 0
  esac

  json_nginx
  cmd_systemctl enable argo
  export_list
}


# 更换 cdn
change_cdn() {
  [ ! -d "${WORK_DIR}" ] && error " $(text 70) "

  # 检测是否有使用 CDN，方法是查找是否有 ${WORK_DIR}/conf/
  local CDN_NOW=$(awk -F '"' '/"SERVER"/{print $4; exit}' ${WORK_DIR}/sing-box-conf/inbound.json)

  # 提示当前使用的 CDN 并让用户选择或输入新的 CDN
  hint "\n $(text 71) \n"
  for ((c=0; c<${#CDN_DOMAIN[@]}; c++)); do
    hint " $[c+1]. ${CDN_DOMAIN[c]} "
  done
  reading "\n $(text 72) " CDN_CHOOSE

  # 如果用户直接回车，保持当前 CDN
  [ -z "$CDN_CHOOSE" ] && exit 0

  # 如果用户输入数字，选择对应的 CDN
  [[ "$CDN_CHOOSE" =~ ^[1-9][0-9]*$ && "$CDN_CHOOSE" -le "${#CDN_DOMAIN[@]}" ]] && CDN_NEW=${CDN_DOMAIN[$((CDN_CHOOSE-1))]} || CDN_NEW=$CDN_CHOOSE

  # 使用 sed 更新所有文件中的 CDN 值
  find ${WORK_DIR} -type f | xargs -P 50 sed -i "s/${CDN_NOW}/${CDN_NEW}/g"

  # 更新完成后提示并导出订阅列表
  export_list; info "\n $(text 73) \n"
}

uninstall() {
  if [ -d ${WORK_DIR} ]; then
    [ -s ${ARGO_DAEMON_FILE} ] && cmd_systemctl disable argo &>/dev/null
    [ -s ${SINGBOX_DAEMON_FILE} ] && cmd_systemctl disable sing-box &>/dev/null
    sleep 1
    [[ -s ${WORK_DIR}/nginx.conf && $(ps -ef | grep 'nginx' | wc -l) -le 1 ]] && reading "\n $(text 59) " REMOVE_NGINX
    [ "${REMOVE_NGINX,,}" = 'y' ] && ${PACKAGE_UNINSTALL[int]} nginx >/dev/null 2>&1
    [ "$SYSTEM" = 'CentOS' ] && firewall_configuration close
    rm -rf ${WORK_DIR} ${TEMP_DIR} ${ARGO_DAEMON_FILE} ${SINGBOX_DAEMON_FILE} /usr/bin/sb
    info "\n $(text 16) \n"
  else
    error "\n $(text 15) \n"
  fi
}

# Argo 与 Sing-box 的最新版本
version() {
  # Argo 版本
  local ONLINE=$(wget --no-check-certificate -qO- ${GH_PROXY}https://api.github.com/repos/cloudflare/cloudflared/releases/latest | awk -F '"' '/"tag_name"/{print $4}')
  local LOCAL=$($WORK_DIR/cloudflared -v | awk '{for (i=0; i<NF; i++) if ($i=="version") {print $(i+1)}}')
  local APP=ARGO && info "\n $(text 43) "
  [[ -n "$ONLINE" && "$ONLINE" != "$LOCAL" ]] && reading "\n $(text 9) " UPDATE[0] || info " $(text 44) "
  local ONLINE=$(get_sing_box_version)
  local LOCAL=$($WORK_DIR/sing-box version | awk '/version/{print $NF}')
  local APP=Sing-box && info "\n $(text 43) "
  [[ -n "$ONLINE" && "$ONLINE" != "$LOCAL" ]] && reading "\n $(text 9) " UPDATE[1] || info " $(text 44) "

  [[ ${UPDATE[*],,} =~ 'y' ]] && check_system_info
  if [ ${UPDATE[0],,} = 'y' ]; then
    wget --no-check-certificate -O $TEMP_DIR/cloudflared ${GH_PROXY}https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-$ARGO_ARCH
    if [ -s $TEMP_DIR/cloudflared ]; then
      cmd_systemctl disable argo
      chmod +x $TEMP_DIR/cloudflared && mv $TEMP_DIR/cloudflared $WORK_DIR/cloudflared
      cmd_systemctl enable argo && systemctl status argo &>/dev/null && info " Argo $(text 28) $(text 37)" || error " Argo $(text 28) $(text 38) "
    else
      local APP=ARGO && error "\n $(text 48) "
    fi
  fi
  if [ ${UPDATE[1],,} = 'y' ]; then
    wget --no-check-certificate -c ${GH_PROXY}https://github.com/SagerNet/sing-box/releases/download/v$ONLINE/sing-box-$ONLINE-linux-$SING_BOX_ARCH.tar.gz -qO- | tar xz -C $TEMP_DIR sing-box-$ONLINE-linux-$SING_BOX_ARCH/sing-box
    if [ -s $TEMP_DIR/sing-box-$ONLINE-linux-$SING_BOX_ARCH/sing-box ]; then
      cmd_systemctl disable sing-box
      mv $TEMP_DIR/sing-box-$ONLINE-linux-$SING_BOX_ARCH/sing-box $WORK_DIR
      rm -rf $TEMP_DIR/sing-box-$ONLINE-linux-$SING_BOX_ARCH
      cmd_systemctl enable sing-box && systemctl status sing-box &>/dev/null && info " Sing-box $(text 28) $(text 37)" || error " Sing-box  $(text 28) $(text 38) "
    else
      local APP=Sing-box && error "\n $(text 48) "
    fi
  fi
}

# 判断当前 sba 的运行状态，并对应的给菜单和动作赋值
menu_setting() {
  if [[ ${STATUS[*]} =~ $(text 27)|$(text 28) ]]; then
    if [ -s $WORK_DIR/cloudflared ]; then
      ARGO_VERSION=$($WORK_DIR/cloudflared -v | awk '{print $3}' | sed "s@^@Version: &@g")
      grep -q '^Alpine$' <<< "$SYSTEM" && local PID_COLUMN='1' || local PID_COLUMN='2'
      local PID=$(ps -ef | awk -v work_dir="${WORK_DIR}" -v col="$PID_COLUMN" '$0 ~ work_dir".*cloudflared" && !/grep/ {print $col; exit}')
      local REALTIME_METRICS_PORT=$(ss -nltp | awk -v pid=$PID '$0 ~ "pid="pid"," {split($4, a, ":"); print a[length(a)]}')
      ss -nltp | grep -q "cloudflared.*pid=${PID}," && ARGO_CHECKHEALTH="$(text 46): $(wget -qO- http://localhost:${REALTIME_METRICS_PORT}/healthcheck | sed "s/OK/$(text 37)/")"
    fi
    [ -s $WORK_DIR/sing-box ] && SING_BOX_VERSION=$($WORK_DIR/sing-box version | awk '/version/{print $NF}' | sed "s@^@Version: &@g")
    [ "$SYSTEM" = 'Alpine' ] && PS_LIST=$(ps -ef) || PS_LIST=$(ps -ef | grep -E 'sing-box|cloudflared|nginx' | awk '{ $1=""; sub(/^ */, ""); print $0 }')
    [ -x "$(type -p nginx)" ] && NGINX_VERSION=$(nginx -v 2>&1 | sed "s#.*/#Version: #")

    OPTION[1]="1 .  $(text 29)"
    if [ ${STATUS[0]} = "$(text 28)" ]; then
      ARGO_PID=$(awk '/\/etc\/sba\/cloudflared/{print $1}' <<< "$PS_LIST")
      [ -n "$ARGO_PID" ] && [ -f "/proc/$ARGO_PID/status" ] && ARGO_MEMORY="$(text 52): $(awk '/VmRSS/{printf "%.1f\n", $2/1024}' /proc/$ARGO_PID/status) MB" || ARGO_MEMORY="$(text 52): N/A"

      NGINX_PID=$(awk '/\/etc\/sba\/nginx/{print $1}' <<< "$PS_LIST")
      [ -n "$NGINX_PID" ] && [ -f "/proc/$NGINX_PID/status" ] && NGINX_MEMORY="$(text 52): $(awk '/VmRSS/{printf "%.1f\n", $2/1024}' /proc/$NGINX_PID/status) MB" || NGINX_MEMORY="$(text 52): N/A"
      OPTION[2]="2 .  $(text 27) Argo (sb -a)"
    else
      OPTION[2]="2 .  $(text 28) Argo (sb -a)"
    fi
    if [ ${STATUS[1]} = "$(text 28)" ]; then
      SING_BOX_PID=$(awk '/\/etc\/sba\/sing-box.*\/etc\/sba/{print $1}' <<< "$PS_LIST")
      [ -n "$SING_BOX_PID" ] && [ -f "/proc/$SING_BOX_PID/status" ] && SING_BOX_MEMORY="$(text 52): $(awk '/VmRSS/{printf "%.1f\n", $2/1024}' /proc/$SING_BOX_PID/status) MB" || SING_BOX_MEMORY="$(text 52): N/A"
      OPTION[3]="3 .  $(text 27) Sing-box (sb -s)"
    else
      OPTION[3]="3 .  $(text 28) Sing-box (sb -s)"
    fi
    OPTION[4]="4 .  $(text 30)"
    OPTION[5]="5 .  $(text 31)"
    OPTION[6]="6 .  $(text 32)"
    OPTION[7]="7 .  $(text 33)"
    OPTION[8]="8 .  $(text 51)"
    OPTION[9]="9 .  $(text 58)"
    OPTION[10]="10.  $(text 64)"

    ACTION[1]() { export_list; }
    [[ ${STATUS[0]} = "$(text 28)" ]] &&
    ACTION[2]() {
      cmd_systemctl disable argo
      cmd_systemctl status argo &>/dev/null && error " Argo $(text 27) $(text 38) " || info "\n Argo $(text 27) $(text 37)"
    } ||
    ACTION[2]() {
      cmd_systemctl enable argo
      cmd_systemctl status argo &>/dev/null && info "\n Argo $(text 28) $(text 37)" || error " Argo $(text 28) $(text 38) "
    }
    [[ ${STATUS[1]} = "$(text 28)" ]] &&
    ACTION[3]() {
      cmd_systemctl disable sing-box
      cmd_systemctl status sing-box &>/dev/null && error " Sing-box $(text 27) $(text 38) " || info "\n Sing-box $(text 27) $(text 37)"
    } ||
    ACTION[3]() {
      cmd_systemctl enable sing-box
      cmd_systemctl stauts sing-box &>/dev/null && info "\n Sing-box $(text 28) $(text 37)" || error " Sing-box $(text 28) $(text 38) "
    }
    ACTION[4]() { change_argo; exit; }
    ACTION[5]() { version; }
    ACTION[6]() { bash <(wget --no-check-certificate -qO- ${GH_PROXY}https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcp.sh); exit; }
    ACTION[7]() { uninstall; exit 0; }
    ACTION[8]() { bash <(wget --no-check-certificate -qO- ${GH_PROXY}https://raw.githubusercontent.com/fscarmen/sing-box/main/sing-box.sh) -$L; exit; }
    ACTION[9]() { bash <(wget --no-check-certificate -qO- ${GH_PROXY}https://raw.githubusercontent.com/fscarmen/argox/main/argox.sh) -$L; exit; }
    ACTION[10]() { bash <(wget --no-check-certificate -qO- https://tcp.hy2.sh/); exit; }

  else
    OPTION[1]="1.  $(text 34)"
    OPTION[2]="2.  $(text 32)"
    OPTION[3]="3.  $(text 51)"
    OPTION[4]="4.  $(text 58)"
    OPTION[5]="5.  $(text 64)"

    ACTION[1]() { install_sba; export_list; create_shortcut; exit; }
    ACTION[2]() { bash <(wget --no-check-certificate -qO- ${GH_PROXY}https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcp.sh); exit; }
    ACTION[3]() { bash <(wget --no-check-certificate -qO- ${GH_PROXY}https://raw.githubusercontent.com/fscarmen/sing-box/main/sing-box.sh) -$L; exit; }
    ACTION[4]() { bash <(wget --no-check-certificate -qO- ${GH_PROXY}https://raw.githubusercontent.com/fscarmen/argox/main/argox.sh) -$L; exit; }
    ACTION[5]() { bash <(wget --no-check-certificate -qO- https://tcp.hy2.sh/); exit; }
  fi

  [ "${#OPTION[@]}" -ge '10' ] && OPTION[0]="0 .  $(text 35)" || OPTION[0]="0.  $(text 35)"
  ACTION[0]() { exit; }
}

menu() {
  clear
  ### hint " $(text 2) "
  echo -e "======================================================================================================================\n"
  info " $(text 17):$VERSION\n $(text 18):$(text 1)\n $(text 19):\n\t $(text 20):$SYS\n\t $(text 21):$(uname -r)\n\t $(text 22):$SING_BOX_ARCH\n\t $(text 23):$VIRT "
  info "\t IPv4: $WAN4 $WARPSTATUS4 $COUNTRY4  $ASNORG4 "
  info "\t IPv6: $WAN6 $WARPSTATUS6 $COUNTRY6  $ASNORG6 "
  info "\t Argo: ${STATUS[0]}\t $ARGO_VERSION\t $ARGO_MEMORY\t $ARGO_CHECKHEALTH\n\t Sing-box: ${STATUS[1]}\t $SING_BOX_VERSION\t\t $SING_BOX_MEMORY\n\t Nginx: ${STATUS[0]}\t $NGINX_VERSION\t $NGINX_MEMORY "
  echo -e "\n======================================================================================================================\n"
  for ((b=1;b<${#OPTION[*]};b++)); do hint " ${OPTION[b]} "; done
  hint " ${OPTION[0]} "
  reading "\n $(text 24) " CHOOSE

  # 输入必须是数字且少于等于最大可选项
  if grep -qE "^[0-9]{1,2}$" <<< "$CHOOSE" && [ "$CHOOSE" -lt "${#OPTION[*]}" ]; then
    ACTION[$CHOOSE]
  else
    warning " $(text 36) [0-$((${#OPTION[*]}-1))] " && sleep 1 && menu
  fi
}

check_cdn
# statistics_of_run-times update sba.sh 2>/dev/null

# 传参
[[ "${*,,}" =~ '-e' ]] && L=E
[[ "${*,,}" =~ '-c' ]] && L=C

while getopts ":AaSsUuNnTtDdVvBbFf:" OPTNAME; do
  case "${OPTNAME,,}" in
    a ) select_language; check_system_info; check_install
      case "${STATUS[0]}" in
        "$(text 28)" )
          cmd_systemctl disable argo
          cmd_systemctl status argo &>/dev/null && error " Argo $(text 27) $(text 38) " || info "\n Argo $(text 27) $(text 37)"
          ;;
        *)
          cmd_systemctl enable argo
          cmd_systemctl status argo &>/dev/null && info "\n Argo $(text 28) $(text 37)" || error " Argo $(text 28) $(text 38) "
      esac
      exit 0 ;;
    s ) select_language; check_system_info; check_install
      case "${STATUS[1]}" in
        "$(text 28)" )
          cmd_systemctl disable sing-box
          cmd_systemctl status sing-box &>/dev/null && error " Sing-box $(text 27) $(text 38) " || info "\n Sing-box $(text 27) $(text 37)"
          ;;
        *)
          cmd_systemctl enable sing-box
          cmd_systemctl status sing-box &>/dev/null && info "\n Sing-box $(text 28) $(text 37)" || error " Sing-box $(text 28) $(text 38) "
      esac
      exit 0 ;;
    u ) select_language; check_system_info; uninstall; exit 0 ;;
    n ) select_language; check_system_info; check_brutal; export_list; exit 0 ;;
    t ) select_language; check_system_info; check_brutal; change_argo; exit 0 ;;
    d ) select_language; check_system_info; check_brutal; change_cdn; exit 0 ;;
    v ) select_language; check_arch; version; exit 0;;
    b ) select_language; bash <(wget --no-check-certificate -qO- "${GH_PROXY}https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcp.sh"); exit ;;
    f ) NONINTERACTIVE_INSTALL='noninteractive_install'; VARIABLE_FILE=$OPTARG; . $VARIABLE_FILE ;;
  esac
done

select_language
check_root
check_arch
check_system_info
check_brutal
check_dependencies
check_system_ip
check_install
menu_setting

[ -z "$VARIABLE_FILE" ] && menu || ACTION[1]