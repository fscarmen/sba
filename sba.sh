#!/usr/bin/env bash

# 当前脚本版本号
VERSION=1.0

# 各变量默认值
# GH_PROXY='https://ghproxy.com/' # 不稳定，暂不使用
WS_PATH_DEFAULT='sba'
WORK_DIR='/etc/sba'
TEMP_DIR='/tmp/sba'
TLS_SERVER=addons.mozilla.org
CDN_DOMAIN=("www.who.int" "cdn.anycast.eu.org" "443.cf.bestl.de" "cn.azhz.eu.org" "cfip.gay")

trap "rm -rf $TEMP_DIR; echo -e '\n' ;exit 1" INT QUIT TERM EXIT

mkdir -p $TEMP_DIR

E[0]="Language:\n 1. English (default) \n 2. 简体中文"
C[0]="${E[0]}"
E[1]="Reality xtls-rprx-vision/ vless + WSS + Argo / vmess + WSS + Argo / trojan + WSS + Argo, 4 in 1 scripts"
C[1]="Reality xtls-rprx-vision/ vless + WSS + Argo / vmess + WSS + Argo / trojan + WSS + Argo, 4 合 1 脚本"
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
E[10]="Please input Argo Domain (Default is temporary domain if left blank):"
C[10]="请输入 Argo 域名 (如果没有，可以跳过以使用 Argo 临时域名):"
E[11]="Please input Argo Token or Json ( User can easily obtain the json at https://fscarmen.cloudflare.now.cc ):"
C[11]="请输入 Argo Token 或者 Json ( 用户通过以下网站轻松获取 json: https://fscarmen.cloudflare.now.cc ):"
E[12]="Please input Sing-box UUID \(Default is \$UUID_DEFAULT\):"
C[12]="请输入 Sing-box UUID \(默认为 \$UUID_DEFAULT\):"
E[13]="Please input Sing-box WS Path \(Default is \$WS_PATH_DEFAULT\):"
C[13]="请输入 Sing-box WS 路径 \(默认为 \$WS_PATH_DEFAULT\):"
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
E[34]="Install script"
C[34]="安装脚本"
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
E[42]="Please select or enter the preferred domain, the default is \${CDN_DOMAIN[0]}:"
C[42]="请选择或者填入优选域名，默认为 \${CDN_DOMAIN[0]}:"
E[43]="\$APP local verion: \$LOCAL.\\\t The newest verion: \$ONLINE"
C[43]="\$APP 本地版本: \$LOCAL.\\\t 最新版本: \$ONLINE"
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
E[49]="Please enter the node name. \(Default is \${NODE_NAME_DEFAULT}\):"
C[49]="请输入节点名称 \(默认为 \${NODE_NAME_DEFAULT}\):"
E[50]="Argo or Sing-box services are not enabled, node information cannot be output. Press [y] if you want to open."
C[50]="\${APP[@]} 服务未开启，不能输出节点信息。如需打开请按 [y]: "
E[51]="Install Sing-box multi-protocol scripts [https://github.com/fscarmen/sing-box]"
C[51]="安装 Sing-box 协议全家桶脚本 [https://github.com/fscarmen/sing-box]"
E[52]="Memory Usage"
C[52]="内存占用"
E[53]="The Sing-box service is detected to be installed. Please enter the correct server IP:"
C[53]="检测到已安装 Sing-box 服务，请输入正确的服务器 IP:"
E[54]="Warp / warp-go was detected to be running. Please enter the correct server IP:"
C[54]="检测到 warp / warp-go 正在运行，请输入确认的服务器 IP:"
E[55]="The script runs today: \$TODAY. Total: \$TOTAL"
C[55]="脚本当天运行次数: \$TODAY，累计运行次数: \$TOTAL"
E[56]="No server ip, script exits. Feedback:[https://github.com/fscarmen/sing-box/issues]"
C[56]="没有 server ip，脚本退出，问题反馈:[https://github.com/fscarmen/sing-box/issues]"
E[57]="Please enter VPS IP \(Default is: \${SERVER_IP_DEFAULT}\):"
C[57]="请输入 VPS IP \(默认为: \${SERVER_IP_DEFAULT}\):"
E[58]="Install ArgoX scripts (argo + xray) [https://github.com/fscarmen/argox]"
C[58]="安装 ArgoX 脚本 (argo + xray) [https://github.com/fscarmen/argox]"
E[59]="To uninstall Nginx press [y], it is not uninstalled by default:"
C[59]="如要卸载 Nginx 请按 [y]，默认不卸载:"
E[60]="Quicktunnel domain can be obtained from: https://\${SERVER_IP_1}/argo"
C[60]="临时隧道域名可以从以下网站获取: https://\${SERVER_IP_1}/argo"
E[61]="Enable multiplexing"
C[61]="可开启多路复用"
E[62]="Create shortcut [ sb ] successfully."
C[62]="创建快捷 [ sb ] 指令成功!"
E[63]="The full template can be found at: https://t.me/ztvps/37"
C[63]="完整模板可参照: https://t.me/ztvps/37"

# 自定义字体彩色，read 函数
warning() { echo -e "\033[31m\033[01m$*\033[0m"; }  # 红色
error() { echo -e "\033[31m\033[01m$*\033[0m" && exit 1; } # 红色
info() { echo -e "\033[32m\033[01m$*\033[0m"; }   # 绿色
hint() { echo -e "\033[33m\033[01m$*\033[0m"; }   # 黄色
reading() { read -rp "$(info "$1")" "$2"; }
text() { grep -q '\$' <<< "${E[$*]}" && eval echo "\$(eval echo "\${${L}[$*]}")" || eval echo "\${${L}[$*]}"; }

# 自定义友道或谷歌翻译函数
translate() {
  [ -n "$@" ] && EN="$@"
  ZH=$(wget -qO- -t1T2 "https://translate.google.com/translate_a/t?client=any_client_id_works&sl=en&tl=zh&q=${EN//[[:space:]]/}")
  [[ "$ZH" =~ ^\[\".+\"\]$ ]] && cut -d \" -f2 <<< "$ZH"
}

# 脚本当天及累计运行次数统计
statistics_of_run-times() {
  local COUNT=$(wget -qO- -t1T2 "https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fraw.githubusercontent.com%2Ffscarmen%2Fsba%2Fmain%2Fsba.sh" 2>&1 | grep -m1 -oE "[0-9]+[ ]+/[ ]+[0-9]+") &&
  TODAY=$(cut -d " " -f1 <<< "$COUNT") &&
  TOTAL=$(cut -d " " -f3 <<< "$COUNT")
}

# 选择中英语言
select_language() {
  if [ -z "$L" ]; then
    case $(cat $WORK_DIR/language 2>&1) in
      E ) L=E ;;
      C ) L=C ;;
      * ) [ -z "$L" ] && L=E && hint "\n $(text 0) \n" && reading " $(text 24) " LANGUAGE
      [ "$LANGUAGE" = 2 ] && L=C ;;
    esac
  fi
}

check_root() {
  [ "$(id -u)" != 0 ] && error "\n $(text 47) \n"
}

check_arch() {
  # 判断处理器架构
  case $(uname -m) in
    aarch64|arm64 ) ARGO_ARCH=arm64 ; SING_BOX_ARCH=arm64 ;;
    x86_64|amd64 ) ARGO_ARCH=amd64 ; [[ "$(awk -F ':' '/flags/{print $2; exit}' /proc/cpuinfo)" =~ avx2 ]] && SING_BOX_ARCH=amd64v3 || SING_BOX_ARCH=amd64 ;;
    armv7l ) ARGO_ARCH=arm ; SING_BOX_ARCH=armv7 ;;
    * ) error " $(text 25) " ;;
  esac
}

# 查安装及运行状态，下标0: argo，下标1: sing-box，下标2：docker；状态码: 26 未安装， 27 已安装未运行， 28 运行中
check_install() {
  STATUS[0]=$(text 26) && [ -s /etc/systemd/system/argo.service ] && STATUS[0]=$(text 27) && [ "$(systemctl is-active argo)" = 'active' ] && STATUS[0]=$(text 28)
  STATUS[1]=$(text 26)
  # sing-box systemd 文件存在的话，检测一下是否本脚本安装的，如果不是则提示并提出
  if [ -s /etc/systemd/system/sing-box.service ]; then
    ! grep -q "$WORK_DIR" /etc/systemd/system/sing-box.service && error " $(text 53)\n $(grep 'ExecStart=' /etc/systemd/system/sing-box.service) "
    STATUS[1]=$(text 27) && [ "$(systemctl is-active sing-box)" = 'active' ] && STATUS[1]=$(text 28)
  fi
  [[ ${STATUS[0]} = "$(text 26)" ]] && [ ! -s $WORK_DIR/cloudflared ] &&
  {
    wget -qO $TEMP_DIR/cloudflared ${GH_PROXY}https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-$ARGO_ARCH >/dev/null 2>&1
    chmod +x $TEMP_DIR/cloudflared >/dev/null 2>&1
  }&
  [[ ${STATUS[1]} = "$(text 26)" ]] && [ ! -s $WORK_DIR/sing-box ] &&
  {
    local SING_BOX_LATEST=$(wget -qO- "https://api.github.com/repos/SagerNet/sing-box/releases/latest" | grep "tag_name" | sed "s@.*\"v\(.*\)\",@\1@g")
    SING_BOX_LATEST=${SING_BOX_LATEST:-'1.6.0'}
    wget -c $TEMP_DIR/sing-box.tar.gz ${GH_PROXY}https://github.com/SagerNet/sing-box/releases/download/v$SING_BOX_LATEST/sing-box-$SING_BOX_LATEST-linux-$SING_BOX_ARCH.tar.gz -qO- | tar xz -C $TEMP_DIR sing-box-$SING_BOX_LATEST-linux-$SING_BOX_ARCH/sing-box
    mv $TEMP_DIR/sing-box-$SING_BOX_LATEST-linux-$SING_BOX_ARCH/sing-box $TEMP_DIR >/dev/null 2>&1
  }&
}

# 为了适配 alpine，定义 cmd_systemctl 的函数
cmd_systemctl() {
  local ENABLE_DISABLE=$1
  local APP=$2
  if [ "$ENABLE_DISABLE" = 'enable' ]; then
    if [ "$SYSTEM" = 'Alpine' ]; then
      systemctl start $APP
      cat > /etc/local.d/$APP.start << EOF
#!/usr/bin/env bash

systemctl start $APP
EOF
      chmod +x /etc/local.d/$APP.start
      rc-update add local >/dev/null 2>&1
    else
      systemctl enable --now $APP
    fi
    [ $(ps -ef | grep "$WORK_DIR/nginx" | wc -l) -le 1 ] && nginx -c $WORK_DIR/nginx.conf

  elif [ "$ENABLE_DISABLE" = 'disable' ]; then
    if [ "$SYSTEM" = 'Alpine' ]; then
      systemctl stop $APP
      rm -f /etc/local.d/$APP.start
    else
      systemctl disable --now $APP
    fi
    kill -9 $(ss -nltp | grep '3010.*nginx' | grep -oE 'pid=[0-9]+' | awk -F "=" '{print $2}' | tr '\n' ' ') >/dev/null 2>&1
  fi
}

check_system_info() {
  # 判断虚拟化
  if [ $(type -p systemd-detect-virt) ]; then
    VIRT=$(systemd-detect-virt)
  elif [ $(type -p hostnamectl) ]; then
    VIRT=$(hostnamectl | awk '/Virtualization/{print $NF}')
  elif [ $(type -p virt-what) ]; then
    VIRT=$(virt-what)
  fi

  [ -s /etc/os-release ] && SYS="$(grep -i pretty_name /etc/os-release | cut -d \" -f2)"
  [[ -z "$SYS" && $(type -p hostnamectl) ]] && SYS="$(hostnamectl | grep -i system | cut -d : -f2)"
  [[ -z "$SYS" && $(type -p lsb_release) ]] && SYS="$(lsb_release -sd)"
  [[ -z "$SYS" && -s /etc/lsb-release ]] && SYS="$(grep -i description /etc/lsb-release | cut -d \" -f2)"
  [[ -z "$SYS" && -s /etc/redhat-release ]] && SYS="$(grep . /etc/redhat-release)"
  [[ -z "$SYS" && -s /etc/issue ]] && SYS="$(grep . /etc/issue | cut -d '\' -f1 | sed '/^[ ]*$/d')"

  REGEX=("debian" "ubuntu" "centos|red hat|kernel|oracle linux|alma|rocky" "amazon linux" "arch linux" "alpine" "fedora")
  RELEASE=("Debian" "Ubuntu" "CentOS" "CentOS" "Arch" "Alpine" "Fedora")
  EXCLUDE=("")
  MAJOR=("9" "16" "7" "7" "3" "" "37")
  PACKAGE_UPDATE=("apt -y update" "apt -y update" "yum -y update" "yum -y update" "pacman -Sy" "apk update -f" "dnf -y update")
  PACKAGE_INSTALL=("apt -y install" "apt -y install" "yum -y install" "yum -y install" "pacman -S --noconfirm" "apk add --no-cache" "dnf -y install")
  PACKAGE_UNINSTALL=("apt -y autoremove" "apt -y autoremove" "yum -y autoremove" "yum -y autoremove" "pacman -Rcnsu --noconfirm" "apk del -f" "dnf -y autoremove")

  for int in "${!REGEX[@]}"; do [[ $(tr 'A-Z' 'a-z' <<< "$SYS") =~ ${REGEX[int]} ]] && SYSTEM="${RELEASE[int]}" && break; done
  [ -z "$SYSTEM" ] && error " $(text 5) "

  # 先排除 EXCLUDE 里包括的特定系统，其他系统需要作大发行版本的比较
  for ex in "${EXCLUDE[@]}"; do [[ ! $(tr 'A-Z' 'a-z' <<< "$SYS")  =~ $ex ]]; done &&
  [[ "$(echo "$SYS" | sed "s/[^0-9.]//g" | cut -d. -f1)" -lt "${MAJOR[int]}" ]] && error " $(text 6) "
}

check_system_ip() {
  if [ -z "$VARIABLE_FILE" ]; then
    # 检测 IPv4 IPv6 信息，WARP Ineterface 开启，普通还是 Plus账户 和 IP 信息
    IP4=$(wget -4 -qO- --no-check-certificate --user-agent=Mozilla --tries=2 --timeout=3 http://ip-api.com/json/) &&
    WAN4=$(expr "$IP4" : '.*query\":[ ]*\"\([^"]*\).*') &&
    COUNTRY4=$(expr "$IP4" : '.*country\":[ ]*\"\([^"]*\).*') &&
    ASNORG4=$(expr "$IP4" : '.*isp\":[ ]*\"\([^"]*\).*') &&
    [[ "$L" = C && -n "$COUNTRY4" ]] && COUNTRY4=$(translate "$COUNTRY4")

    IP6=$(wget -6 -qO- --no-check-certificate --user-agent=Mozilla --tries=2 --timeout=3 https://api.ip.sb/geoip) &&
    WAN6=$(expr "$IP6" : '.*ip\":[ ]*\"\([^"]*\).*') &&
    COUNTRY6=$(expr "$IP6" : '.*country\":[ ]*\"\([^"]*\).*') &&
    ASNORG6=$(expr "$IP6" : '.*isp\":[ ]*\"\([^"]*\).*') &&
    [[ "$L" = C && -n "$COUNTRY6" ]] && COUNTRY6=$(translate "$COUNTRY6")
  fi
}

# 定义 Argo 变量，遇到使用 warp 的话，要求输入正确的 IP
argo_variable() {
  if grep -qi 'cloudflare' <<< "$ASNORG4$ASNORG6"; then
    local a=6
    until [ -n "$SERVER_IP" ]; do
      ((a--)) || true
      [ "$a" = 0 ] && error "\n $(text 3) \n"
      reading "\n $(text 54) " SERVER_IP
    done
    if [[ "$SERVER_IP" =~ : ]]; then
      WARP_ENDPOINT=2606:4700:d0::a29f:c101
      DOMAIN_STRATEG=prefer_ipv6
    else
      WARP_ENDPOINT=162.159.193.10
      DOMAIN_STRATEG=prefer_ipv4
    fi
  elif [ -n "$WAN4" ]; then
    SERVER_IP_DEFAULT=$WAN4
    WARP_ENDPOINT=162.159.193.10
    DOMAIN_STRATEG=prefer_ipv4
  elif [ -n "$WAN6" ]; then
    SERVER_IP_DEFAULT=$WAN6
    WARP_ENDPOINT=2606:4700:d0::a29f:c101
    DOMAIN_STRATEG=prefer_ipv6
  fi

  # 输入服务器 IP,默认为检测到的服务器 IP，如果全部为空，则提示并退出脚本
  [ -z "$SERVER_IP" ] && reading "\n $(text 57) " SERVER_IP
  SERVER_IP=${SERVER_IP:-"$SERVER_IP_DEFAULT"}
  [ -z "$SERVER_IP" ] && error " $(text 56) "

  # 处理可能输入的错误，去掉开头和结尾的空格，去掉最后的 :
  [ -z "$ARGO_DOMAIN" ] && reading "\n $(text 10) " ARGO_DOMAIN
  ARGO_DOMAIN=$(sed 's/[ ]*//g; s/:[ ]*//' <<< "$ARGO_DOMAIN")

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
  # 提供网上热心网友的anycast域名
  if [ -z "$SERVER" ]; then
    echo ""
    for c in "${!CDN_DOMAIN[@]}"; do
      hint " $[c+1]. ${CDN_DOMAIN[c]} "
    done

    reading "\n $(text 42) " CUSTOM_CDN
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
  until [[ "$UUID" =~ ^[A-F0-9a-f]{8}-[A-F0-9a-f]{4}-[A-F0-9a-f]{4}-[A-F0-9a-f]{4}-[A-F0-9a-f]{12}$ ]]; do
    (( a-- )) || true
    [ "$a" = 0 ] && error "\n $(text 3) \n"
    UUID_DEFAULT=$(cat /proc/sys/kernel/random/uuid)
    reading "\n $(text 12) " UUID
    UUID=${UUID:-"$UUID_DEFAULT"}
    [[ ! "$UUID" =~ ^[A-F0-9a-f]{8}-[A-F0-9a-f]{4}-[A-F0-9a-f]{4}-[A-F0-9a-f]{4}-[A-F0-9a-f]{12}$ && "$a" != 1 ]] && warning "\n $(text 4) "
  done

  [ -z "$WS_PATH" ] && reading "\n $(text 13) " WS_PATH
  local a=5
  until [[ -z "$WS_PATH" || "$WS_PATH" =~ ^[A-Z0-9a-z]+$ ]]; do
    (( a-- )) || true
    [ "$a" = 0 ] && error " $(text 3) " || reading " $(text 14) " WS_PATH
  done
  WS_PATH=${WS_PATH:-"$WS_PATH_DEFAULT"}

  # 输入节点名，以系统的 hostname 作为默认
  if [ -s /etc/hostname ]; then
    NODE_NAME_DEFAULT="$(cat /etc/hostname)"
  elif [ $(type -p hostname) ]; then
    NODE_NAME_DEFAULT="$(hostname)"
  else
    NODE_NAME_DEFAULT="sba"
  fi
  reading "\n $(text 49) " NODE_NAME
  NODE_NAME="${NODE_NAME:-"$NODE_NAME_DEFAULT"}"
}

check_dependencies() {
  # 如果是 Alpine，先升级 wget ，安装 systemctl-py 版
  if [ "$SYSTEM" = 'Alpine' ]; then
    CHECK_WGET=$(wget 2>&1 | head -n 1)
    grep -qi 'busybox' <<< "$CHECK_WGET" && ${PACKAGE_INSTALL[int]} wget >/dev/null 2>&1

    DEPS_CHECK=("bash" "python3" "rc-update" "ss" "virt-what" "nginx")
    DEPS_INSTALL=("bash" "python3" "openrc" "iproute2" "virt-what" "nginx")
    for ((g=0; g<${#DEPS_CHECK[@]}; g++)); do [ ! $(type -p ${DEPS_CHECK[g]}) ] && [[ ! "${DEPS[@]}" =~ "${DEPS_INSTALL[g]}" ]] && DEPS+=(${DEPS_INSTALL[g]}); done
    if [ "${#DEPS[@]}" -ge 1 ]; then
      info "\n $(text 7) ${DEPS[@]} \n"
      ${PACKAGE_UPDATE[int]} >/dev/null 2>&1
      ${PACKAGE_INSTALL[int]} ${DEPS[@]} >/dev/null 2>&1
    fi

    [ ! $(type -p systemctl) ] && wget https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py -O /bin/systemctl && chmod a+x /bin/systemctl
  fi

  # 检测 Linux 系统的依赖，升级库并重新安装依赖
  unset DEPS_CHECK DEPS_INSTALL DEPS
  DEPS_CHECK=("ping" "wget" "systemctl" "ip" "tar" "bash" "nginx" "openssl")
  DEPS_INSTALL=("iputils-ping" "wget" "systemctl" "iproute2" "tar" "bash" "nginx" "openssl")
  for g in "${!DEPS_CHECK[@]}"; do
    [ ! $(type -p ${DEPS_CHECK[g]}) ] && [[ ! "${DEPS[@]}" =~ "${DEPS_INSTALL[g]}" ]] && DEPS+=(${DEPS_INSTALL[g]})
  done
  if [ "${#DEPS[@]}" -ge 1 ]; then
    info "\n $(text 7) ${DEPS[@]} \n"
    ${PACKAGE_UPDATE[int]} >/dev/null 2>&1
    ${PACKAGE_INSTALL[int]} ${DEPS[@]} >/dev/null 2>&1
  else
    info "\n $(text 8) \n"
  fi
}

# Nginx 配置文件
json_nginx() {
  WS_PATH=${WS_PATH:-"$(grep -m1 'path.*vm' $WORK_DIR/sing-box-conf/inbound.json | sed "s@.*/\(.*\)-vm.*@\1@g")"}
  SERVER_IP=${SERVER_IP:-"$(sed -r "s/\x1B\[[0-9;]*[mG]//g" $WORK_DIR/list | sed -n "s/.*{name.*server:[ ]*\([^,]\+\).*/\1/pg" | sed -n '1p')"}
  [[ "$SERVER_IP" =~ : ]] && REVERSE_IP="[$SERVER_IP]" || REVERSE_IP="$SERVER_IP"
  cat > $WORK_DIR/nginx.conf << EOF
user  root;
worker_processes  auto;

error_log  /dev/null;
pid        /var/run/nginx.pid;

events {
    worker_connections  1024;
}


http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '\$remote_addr - \$remote_user [\$time_local] "\$request" '
                      '\$status \$body_bytes_sent "\$http_referer" '
                      '"\$http_user_agent" "\$http_x_forwarded_for"';

    access_log  /dev/null;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    #include /etc/nginx/conf.d/*.conf;

  server
    {
      listen 127.0.0.1:3010 ssl http2; # sing-box backend
      # http2 on;
      server_name $TLS_SERVER;

      ssl_certificate            $WORK_DIR/cert/cert.pem;
      ssl_certificate_key        $WORK_DIR/cert/private.key;
      ssl_protocols              TLSv1.3;
      ssl_session_tickets        on;
      ssl_stapling               off;
      ssl_stapling_verify        off;

      # 反代 sing-box vless websocket
      location /$WS_PATH-vl {
        if (\$http_upgrade != "websocket") {
           return 404;
        }
        proxy_pass                          http://127.0.0.1:3011;
        proxy_http_version                  1.1;
        proxy_set_header Upgrade            \$http_upgrade;
        proxy_set_header Connection         "upgrade";
        proxy_set_header X-Real-IP          \$remote_addr;
        proxy_set_header X-Forwarded-For    \$proxy_add_x_forwarded_for;
        proxy_set_header Host               \$host;
        proxy_redirect                      off;
      }

      # 反代 sing-box websocket
      location /$WS_PATH-vm {
        if (\$http_upgrade != "websocket") {
           return 404;
        }
        proxy_pass                          http://127.0.0.1:3012;
        proxy_http_version                  1.1;
        proxy_set_header Upgrade            \$http_upgrade;
        proxy_set_header Connection         "upgrade";
        proxy_set_header X-Real-IP          \$remote_addr;
        proxy_set_header X-Forwarded-For    \$proxy_add_x_forwarded_for;
        proxy_set_header Host               \$host;
        proxy_redirect                      off;
      }

      location /$WS_PATH-tr {
        if (\$http_upgrade != "websocket") {
           return 404;
        }
        proxy_pass                          http://127.0.0.1:3013;
        proxy_http_version                  1.1;
        proxy_set_header Upgrade            \$http_upgrade;
        proxy_set_header Connection         "upgrade";
        proxy_set_header X-Real-IP          \$remote_addr;
        proxy_set_header X-Forwarded-For    \$proxy_add_x_forwarded_for;
        proxy_set_header Host               \$host;
        proxy_redirect                      off;
      }
EOF
  [ -n "$METRICS_PORT" ] && cat >> $WORK_DIR/nginx.conf << EOF

      location /argo {
        proxy_pass http://$REVERSE_IP:$METRICS_PORT/quicktunnel;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
      }
EOF
  cat >> $WORK_DIR/nginx.conf << EOF
    }
}
EOF
}

# Json 生成两个配置文件
json_argo() {
  [ ! -s $WORK_DIR/tunnel.json ] && echo $ARGO_JSON > $WORK_DIR/tunnel.json
  [ ! -s $WORK_DIR/tunnel.yml ] && cat > $WORK_DIR/tunnel.yml << EOF
tunnel: $(cut -d\" -f12 <<< $ARGO_JSON)
credentials-file: $WORK_DIR/tunnel.json
protocol: http2

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
  [ ! -d /etc/systemd/system ] && mkdir -p /etc/systemd/system
  mkdir -p $WORK_DIR/sing-box-conf $WORK_DIR/logs $WORK_DIR/cert && echo "$L" > $WORK_DIR/language
  [ -s "$VARIABLE_FILE" ] && cp $VARIABLE_FILE $WORK_DIR/
  # Argo 生成守护进程文件
  local i=1
  [ ! -s $WORK_DIR/cloudflared ] && wait && while [ "$i" -le 20 ]; do [ -s $TEMP_DIR/cloudflared ] && mv $TEMP_DIR/cloudflared $WORK_DIR && break; ((i++)); sleep 2; done
  [ "$i" -ge 20 ] && local APP=ARGO && error "\n $(text 48) "
  if [[ -n "${ARGO_JSON}" && -n "${ARGO_DOMAIN}" ]]; then
    ARGO_RUNS="$WORK_DIR/cloudflared tunnel --edge-ip-version auto --config $WORK_DIR/tunnel.yml run"
    json_argo
  elif [[ -n "${ARGO_TOKEN}" && -n "${ARGO_DOMAIN}" ]]; then
    ARGO_RUNS="$WORK_DIR/cloudflared tunnel --edge-ip-version auto --protocol http2 run --token ${ARGO_TOKEN}"
  else
    METRICS_PORT=$(shuf -i 1000-65535 -n 1)
    ARGO_RUNS="$WORK_DIR/cloudflared tunnel --edge-ip-version auto --no-autoupdate --protocol http2 --no-tls-verify --metrics 0.0.0.0:$METRICS_PORT --url https://localhost:3010"
  fi

  # 生成100年的自签证书
  openssl ecparam -genkey -name prime256v1 -out $WORK_DIR/cert/private.key && openssl req -new -x509 -days 36500 -key $WORK_DIR/cert/private.key -out $WORK_DIR/cert/cert.pem -subj "/CN=$(awk -F . '{print $(NF-1)"."$NF}' <<< "$TLS_SERVER")"

  cat > /etc/systemd/system/argo.service << EOF
[Unit]
Description=Cloudflare Tunnel
After=network.target

[Service]
Type=simple
NoNewPrivileges=yes
TimeoutStartSec=0
ExecStart=$ARGO_RUNS
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

  # 生成配置文件及守护进程文件
  # 等待 sing-box 二进制文件下载成功并搬到 $WORK_DIR，40秒超时报错退出
  local i=1
  [ ! -s $WORK_DIR/sing-box ] && wait && while [ "$i" -le 20 ]; do [ -s $TEMP_DIR/sing-box ] && mv $TEMP_DIR/sing-box $WORK_DIR && break; ((i++)); sleep 2; done
  [ "$i" -ge 20 ] && local APP=Sing-box && error "\n $(text 48) "

  # 生成 reality 的公私钥
  REALITY_KEYPAIR=$($WORK_DIR/sing-box generate reality-keypair)
  [ -z "$REALITY_PRIVATE" ] && REALITY_PRIVATE=$(awk '/PrivateKey/{print $NF}' <<< "$REALITY_KEYPAIR")
  [ -z "$REALITY_PUBLIC" ] && REALITY_PUBLIC=$(awk '/PublicKey/{print $NF}' <<< "$REALITY_KEYPAIR")
  cat > $WORK_DIR/sing-box-conf/inbound.json << EOF
{
    "log":{
        "disabled":false,
        "level":"error",
        "output":"$WORK_DIR/logs/box.log",
        "timestamp":true
    },
    "inbounds":[
        {
            "type":"vless",
            "listen":"::",
            "listen_port":443,
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
            }
        },
        {
            "type":"vless",
            "tag":"vless-in",
            "listen":"127.0.0.1",
            "listen_port":3011,
            "sniff":true,
            "sniff_override_destination":true,
            "transport":{
                "type":"ws",
                "path":"/${WS_PATH}-vl",
                "max_early_data":2048,
                "early_data_header_name":"Sec-WebSocket-Protocol"
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
            "sniff":true,
            "sniff_override_destination":true,
            "transport":{
                "type":"ws",
                "path":"/${WS_PATH}-vm",
                "max_early_data":2048,
                "early_data_header_name":"Sec-WebSocket-Protocol"
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
            "sniff":true,
            "sniff_override_destination":true,
            "transport":{
                "type":"ws",
                "path":"/${WS_PATH}-tr",
                "max_early_data":2048,
                "early_data_header_name":"Sec-WebSocket-Protocol"
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
    "outbounds":[
        {
            "type":"direct",
            "tag":"direct",
            "domain_strategy":"${DOMAIN_STRATEG}"
        },
        {
            "type":"direct",
            "tag":"warp-IPv4-out",
            "detour":"wireguard-out",
            "domain_strategy":"ipv4_only"
        },
        {
            "type":"direct",
            "tag":"warp-IPv6-out",
            "detour":"wireguard-out",
            "domain_strategy":"ipv6_only"
        },
        {
            "type":"wireguard",
            "tag":"wireguard-out",
            "server":"${WARP_ENDPOINT}",
            "server_port":2408,
            "local_address":[
                "172.16.0.2/32",
                "2606:4700:110:8a36:df92:102a:9602:fa18/128"
            ],
            "private_key":"YFYOAdbw1bKTHlNNi+aEjBM3BO7unuFC5rOkMRAz9XY=",
            "peer_public_key":"bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
            "reserved":[
                78,
                135,
                76
            ],
            "mtu":1280
        },
        {
            "type":"block",
            "tag":"block"
        }
    ],
    "route":{
        "geoip":{
            "download_url":"https://github.com/SagerNet/sing-geoip/releases/latest/download/geoip.db",
            "download_detour":"direct"
        },
        "geosite":{
            "download_url":"https://github.com/SagerNet/sing-geosite/releases/latest/download/geosite.db",
            "download_detour":"direct"
        },
        "rules":[
            {
                "geosite":[
                    "openai"
                ],
                "outbound":"warp-IPv6-out"
            }
        ]
    }
}
EOF

  cat > /etc/systemd/system/sing-box.service << EOF
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

  # 生成 Nginx 配置文件
  json_nginx

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

  case "${STATUS[0]}" in
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

bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/sba/main/sba.sh) \$1
EOF
  chmod +x $WORK_DIR/sb.sh
  ln -sf $WORK_DIR/sb.sh /usr/bin/sb
  [ -s /usr/bin/argox ] && hint "\n $(text 62) "
}

export_list() {
  check_install
  # 没有开启 Argo 和 Sing-box 服务，将不输出节点信息
  local APP
  [ "${STATUS[0]}" != "$(text 28)" ] && APP+=(argo)
  [ "${STATUS[1]}" != "$(text 28)" ] && APP+=(sing-box)
  if [ "${#APP[@]}" -gt 0 ]; then
    reading "\n $(text 50) " OPEN_APP
    if [[ "$OPEN_APP" = [Yy] ]]; then
      [ "${STATUS[0]}" != "$(text 28)" ] && cmd_systemctl enable argo
      [ "${STATUS[1]}" != "$(text 28)" ] && cmd_systemctl enable sing-box
    else
      exit
    fi
  fi

  # 如果是临时隧道，即实时获取其域名
  if grep -q 'metrics.*url' /etc/systemd/system/argo.service; then
    local a=5
    until [[ -n "$ARGO_DOMAIN" || "$a" = 0 ]]; do
      sleep 2
      ARGO_DOMAIN=$(wget -qO- http://localhost:$(ps -ef | awk -F '0.0.0.0:' '/cloudflared.*:3010/{print $2}' | awk 'NR==1 {print $1}')/quicktunnel | cut -d\" -f4)
      ((a--)) || true
    done
  else
    ARGO_DOMAIN=${ARGO_DOMAIN:-"$(grep -m1 'vless' $WORK_DIR/list | sed "s@.*host=\(.*\)&.*@\1@g")"}
  fi
  SERVER_IP=${SERVER_IP:-"$(sed -r "s/\x1B\[[0-9;]*[mG]//g" $WORK_DIR/list | sed -n "s/.*{name.*server:[ ]*\([^,]\+\).*/\1/pg" | sed -n '1p')"}
  REALITY_PUBLIC=${REALITY_PUBLIC:-"$(sed -n 's/.*{name.*public-key:[ ]*\([^,]\+\).*/\1/pg' $WORK_DIR/list)"}
  SERVER=${SERVER:-"$(sed -n "/type: vmess/s/.*server:[ ]*\([^,]*\),.*/\1/gp" $WORK_DIR/list)"}
  UUID=${UUID:-"$(grep 'password' $WORK_DIR/sing-box-conf/inbound.json | awk -F \" 'NR==1{print $4}')"}
  WS_PATH=${WS_PATH:-"$(grep -m1 'path.*vm' $WORK_DIR/sing-box-conf/inbound.json | sed "s@.*/\(.*\)-vm.*@\1@g")"}
  NODE_NAME=${NODE_NAME:-"$(sed -n "/type:[ ]*vmess/s/.*{name:[ ]*[\"]*\(.*\)-Vm.*/\1/gp" $WORK_DIR/list)"}

  # IPv6 时的 IP 处理
  if [[ "$SERVER_IP" =~ : ]]; then
    SERVER_IP_1="[$SERVER_IP]"
    SERVER_IP_2="[[$SERVER_IP]]"
  else
    SERVER_IP_1="$SERVER_IP"
    SERVER_IP_2="$SERVER_IP"
  fi

  # 若为临时隧道，处理查询方法
  grep -q 'metrics.*url' /etc/systemd/system/argo.service && QUICK_TUNNEL_URL=$(text 60)

  # 生成配置文件
  VMESS="{ \"v\": \"2\", \"ps\": \"${NODE_NAME}-Vm\", \"add\": \"${SERVER}\", \"port\": \"443\", \"id\": \"${UUID}\", \"aid\": \"0\", \"scy\": \"none\", \"net\": \"ws\", \"type\": \"none\", \"host\": \"${ARGO_DOMAIN}\", \"path\": \"/${WS_PATH}-vm\", \"tls\": \"tls\", \"sni\": \"${ARGO_DOMAIN}\", \"alpn\": \"\" }"
  cat > $WORK_DIR/list << EOF
*******************************************
┌────────────────┐  ┌────────────────┐
│                │  │                │
│     $(warning "V2rayN")     │  │    $(warning "NekoBox")     │
│                │  │                │
└────────────────┘  └────────────────┘
----------------------------
$(info "vless://${UUID}@${SERVER_IP_1}:443?security=reality&sni=${TLS_SERVER}&fp=chrome&pbk=${REALITY_PUBLIC}&type=tcp&flow=xtls-rprx-vision&encryption=none#${NODE_NAME}%20vless-reality-vision

vless://${UUID}@${SERVER}:443?encryption=none&security=tls&sni=${ARGO_DOMAIN}&type=ws&host=${ARGO_DOMAIN}&path=%2F${WS_PATH}-vl#${NODE_NAME}-Vl

vmess://$(base64 -w0 <<< $VMESS | sed "s/Cg==$//")

trojan://${UUID}@${SERVER}:443?security=tls&sni=${ARGO_DOMAIN}&type=ws&host=${ARGO_DOMAIN}&path=%2F${WS_PATH}-tr#${NODE_NAME}-Tr

+++++ $(text 61) +++++")

*******************************************
┌────────────────┐
│                │
│  $(warning "Shadowrocket")  │
│                │
└────────────────┘
----------------------------
$(hint "vless://$(base64 -w0 <<< auto:${UUID}@${SERVER_IP_2}:443 | sed "s/Cg==$//")?remarks=${NODE_NAME}%20vless-reality-vision&obfs=none&tls=1&peer=$TLS_SERVER&mux=1&xtls=2&pbk=$REALITY_PUBLIC

vless://$(base64 -w0 <<< auto:${UUID}@${SERVER}:443 | sed "s/Cg==$//")?remarks=${NODE_NAME}-Vl&obfsParam=${ARGO_DOMAIN}&path=/${WS_PATH}-vl?ed=2048&obfs=websocket&tls=1&peer=${ARGO_DOMAIN}&mux=1

vmess://$(base64 -w0 <<< none:${UUID}@${SERVER}:443 | sed "s/Cg==$//")?remarks=${NODE_NAME}-Vm&obfsParam=${ARGO_DOMAIN}&path=/${WS_PATH}-vm?ed=2048&obfs=websocket&tls=1&peer=${ARGO_DOMAIN}&mux=1&alterId=0

trojan://${UUID}@${SERVER}:443?peer=${ARGO_DOMAIN}&mux=1&plugin=obfs-local;obfs=websocket;obfs-host=${ARGO_DOMAIN};obfs-uri=/${WS_PATH}-tr?ed=2048#${NODE_NAME}-Tr")

*******************************************
┌────────────────┐
│                │
│   $(warning "Clash Meta")   │
│                │
└────────────────┘
----------------------------
$(info "- {name: \"${NODE_NAME} vless-reality-vision\", type: vless, server: ${SERVER_IP}, port: 443, uuid: ${UUID}, network: tcp, udp: true, tls: true, servername: ${TLS_SERVER}, flow: xtls-rprx-vision, client-fingerprint: chrome, reality-opts: {public-key: ${REALITY_PUBLIC}, short-id: \"\"}, smux: { enabled: true, protocol: 'h2mux', padding: true, max-connections: '0', min-streams: '0', max-streams: '8', statistic: true, only-tcp: false } }

- {name: \"${NODE_NAME}-Vl\", type: vless, server: ${SERVER}, port: 443, uuid: ${UUID}, tls: true, servername: ${ARGO_DOMAIN}, skip-cert-verify: false, network: ws, ws-opts: { path: /${WS_PATH}-vl?ed=2048, max-early-data: 2048, early-data-header-name: Sec-WebSocket-Protocol, headers: { Host: ${ARGO_DOMAIN}}}, udp: true, smux: { enabled: true, protocol: 'h2mux', padding: true, max-connections: '0', min-streams: '0', max-streams: '8', statistic: true, only-tcp: false } }

- {name: \"${NODE_NAME}-Vm\", type: vmess, server: ${SERVER}, port: 443, uuid: ${UUID}, alterId: 0, cipher: none, tls: true, skip-cert-verify: true, network: ws, ws-opts: { path: /${WS_PATH}-vm?ed=2048, max-early-data: 2048, early-data-header-name: Sec-WebSocket-Protocol, headers: {Host: ${ARGO_DOMAIN}}}, udp: true, smux: { enabled: true, protocol: 'h2mux', padding: true, max-connections: '0', min-streams: '0', max-streams: '8', statistic: true, only-tcp: false } }

- {name: \"${NODE_NAME}-Tr\", type: trojan, server: ${SERVER}, port: 443, password: ${UUID}, udp: true, tls: true, sni: ${ARGO_DOMAIN}, skip-cert-verify: false, network: ws, ws-opts: { path: /${WS_PATH}-tr?ed=2048, max-early-data: 2048, early-data-header-name: Sec-WebSocket-Protocol, headers: { Host: ${ARGO_DOMAIN} } }, smux: { enabled: true, protocol: 'h2mux', padding: true, max-connections: '0', min-streams: '0', max-streams: '8', statistic: true, only-tcp: false } }")

*******************************************
┌────────────────┐
│                │
│    $(warning "Sing-box")    │
│                │
└────────────────┘
----------------------------
$(hint "{
  \"outbounds\":[
      {
        \"type\":\"vless\",
        \"tag\":\"${NODE_NAME} vless-reality-vision\",
        \"server\":\"${SERVER_IP}\",
        \"server_port\":443,
        \"uuid\":\"${UUID}\",
        \"flow\":\"xtls-rprx-vision\",
        \"packet_encoding\":\"xudp\",
        \"tls\":{
            \"enabled\":true,
            \"server_name\":\"${TLS_SERVER}\",
            \"utls\":{
                \"enabled\":true,
                \"fingerprint\":\"chrome\"
            },
            \"reality\":{
                \"enabled\":true,
                \"public_key\":\"${REALITY_PUBLIC}\",
                \"short_id\":\"\"
            }
        },
        \"multiplex\":{
            \"enabled\":true,
            \"protocol\":\"h2mux\",
            \"max_connections\":16,
            \"padding\":true
        }
      },
      {
        \"type\": \"vless\",
        \"tag\": \"${NODE_NAME}-Vl\",
        \"server\":\"${SERVER}\",
        \"server_port\":443,
        \"uuid\":\"${UUID}\",
        \"tls\": {
          \"enabled\":true,
          \"server_name\":\"${ARGO_DOMAIN}\",
          \"utls\": {
            \"enabled\":true,
            \"fingerprint\":\"chrome\"
          }
        },
        \"transport\": {
          \"type\":\"ws\",
          \"path\":\"/${WS_PATH}-vl\",
          \"headers\": {
            \"Host\": \"${ARGO_DOMAIN}\"
          },
          \"max_early_data\":2408,
          \"early_data_header_name\":\"Sec-WebSocket-Protocol\"
        },
        \"multiplex\": {
          \"enabled\":true,
          \"protocol\":\"h2mux\",
          \"max_streams\":16,
          \"padding\":true
        }
      },
      {
        \"type\": \"vmess\",
        \"tag\": \"${NODE_NAME}-Vm\",
        \"server\":\"${SERVER}\",
        \"server_port\":443,
        \"uuid\":\"${UUID}\",
        \"tls\": {
          \"enabled\":true,
          \"server_name\":\"${ARGO_DOMAIN}\",
          \"utls\": {
            \"enabled\":true,
            \"fingerprint\":\"chrome\"
          }
        },
        \"transport\": {
          \"type\":\"ws\",
          \"path\":\"/${WS_PATH}-vm\",
          \"headers\": {
            \"Host\": \"${ARGO_DOMAIN}\"
          },
          \"max_early_data\":2408,
          \"early_data_header_name\":\"Sec-WebSocket-Protocol\"
        },
        \"multiplex\": {
          \"enabled\":true,
          \"protocol\":\"h2mux\",
          \"max_streams\":16,
          \"padding\":true
        }
      },
      {
        \"type\":\"trojan\",
        \"tag\":\"${NODE_NAME}-Tr\",
        \"server\": \"${SERVER}\",
        \"server_port\": 443,
        \"password\": \"${UUID}\",
        \"tls\": {
          \"enabled\":true,
          \"server_name\":\"${ARGO_DOMAIN}\",
          \"utls\": {
            \"enabled\":true,
            \"fingerprint\":\"chrome\"
          }
        },
        \"transport\": {
            \"type\":\"ws\",
            \"path\":\"/${WS_PATH}-tr\",
            \"headers\": {
              \"Host\": \"${ARGO_DOMAIN}\"
            },
            \"max_early_data\":2408,
            \"early_data_header_name\":\"Sec-WebSocket-Protocol\"
          },
        \"multiplex\": {
          \"enabled\":true,
          \"protocol\":\"h2mux\",
          \"max_connections\": 16,
          \"padding\":true
        }
      }
  ]
}

 $(text 63)")

$(info " ${QUICK_TUNNEL_URL} ")
EOF
  cat $WORK_DIR/list

  # 显示脚本使用情况数据
  hint "\n $(text 55) \n"
}

# 更换 Argo 隧道类型
change_argo() {
  check_install
  [[ ${STATUS[0]} = "$(text 26)" ]] && error " $(text 39) "
  SERVER_IP=$(sed -r "s/\x1B\[[0-9;]*[mG]//g" $WORK_DIR/list | sed -n "s/.*{name.*server:[ ]*\([^,]\+\).*/\1/pg" | sed -n '1p')

  case $(grep "ExecStart" /etc/systemd/system/argo.service) in
    *--config* )
      ARGO_TYPE='Json'; ARGO_DOMAIN="$(grep -m1 '^vless' $WORK_DIR/list | sed "s@.*host=\(.*\)&.*@\1@g")" ;;
    *--token* )
      ARGO_TYPE='Token'; ARGO_DOMAIN="$(grep -m1 '^vless' $WORK_DIR/list | sed "s@.*host=\(.*\)&.*@\1@g")" ;;
    * )
      ARGO_TYPE='Try'; ARGO_DOMAIN=$(wget -qO- http://localhost:$(ps -ef | awk -F '0.0.0.0:' '/cloudflared.*:3010/{print $2}' | awk 'NR==1 {print $1}')/quicktunnel | cut -d\" -f4) ;;
  esac

  hint "\n $(text 40) \n"
  unset ARGO_DOMAIN
  hint " $(text 41) \n" && reading " $(text 24) " CHANGE_TO
    case "$CHANGE_TO" in
      1 ) cmd_systemctl disable argo
          [ -s $WORK_DIR/tunnel.json ] && rm -f $WORK_DIR/tunnel.{json,yml}
          METRICS_PORT=$(shuf -i 1000-65535 -n 1)
          sed -i "s@ExecStart.*@ExecStart=$WORK_DIR/cloudflared tunnel --edge-ip-version auto --protocol http2 --no-autoupdate --protocol http2 --no-tls-verify --metrics 0.0.0.0:$METRICS_PORT --url https://localhost:3010@g" /etc/systemd/system/argo.service
          ;;
      2 ) argo_variable
          cmd_systemctl disable argo
          if [ -n "$ARGO_TOKEN" ]; then
            [ -s $WORK_DIR/tunnel.json ] && rm -f $WORK_DIR/tunnel.{json,yml}
            sed -i "s@ExecStart.*@ExecStart=$WORK_DIR/cloudflared tunnel --edge-ip-version auto --protocol http2 run --token ${ARGO_TOKEN}@g" /etc/systemd/system/argo.service
          elif [ -n "$ARGO_JSON" ]; then
            [ -s $WORK_DIR/tunnel.json ] && rm -f $WORK_DIR/tunnel.{json,yml}
            json_argo
            sed -i "s@ExecStart.*@ExecStart=$WORK_DIR/cloudflared tunnel --edge-ip-version auto --config $WORK_DIR/tunnel.yml run@g" /etc/systemd/system/argo.service
          fi
          ;;
      * ) exit 0
          ;;
    esac

    json_nginx
    cmd_systemctl enable argo
    export_list
}

uninstall() {
  if [ -d $WORK_DIR ]; then
    cmd_systemctl disable argo
    cmd_systemctl disable sing-box
    rm -rf $WORK_DIR $TEMP_DIR /etc/systemd/system/{sing-box,argo}.service /usr/bin/sb
    [ $(ps -ef | grep 'nginx' | wc -l) -le 1 ] && reading " $(text 59) " REMOVE_NGINX
    [[ "$REMOVE_NGINX" = [Yy] ]] && ${PACKAGE_UNINSTALL[int]} nginx
    info "\n $(text 16) \n"
  else
    error "\n $(text 15) \n"
  fi

  # 如果 Alpine 系统，删除开机自启动
  [ "$SYSTEM" = 'Alpine' ] && ( rm -f /etc/local.d/argo.start /etc/local.d/sing-box.start; rc-update add local >/dev/null 2>&1 )
}

# Argo 与 Sing-box 的最新版本
version() {
  # Argo 版本
  local ONLINE=$(wget -qO- "https://api.github.com/repos/cloudflare/cloudflared/releases/latest" | grep "tag_name" | cut -d \" -f4)
  local LOCAL=$($WORK_DIR/cloudflared -v | awk '{for (i=0; i<NF; i++) if ($i=="version") {print $(i+1)}}')
  local APP=ARGO && info "\n $(text 43) "
  [[ -n "$ONLINE" && "$ONLINE" != "$LOCAL" ]] && reading "\n $(text 9) " UPDATE[0] || info " $(text 44) "
  local ONLINE=$(wget -qO- "https://api.github.com/repos/SagerNet/sing-box/releases/latest" | grep "tag_name" | sed "s@.*\"v\(.*\)\",@\1@g")
  local LOCAL=$($WORK_DIR/sing-box version | awk '/version/{print $NF}')
  local APP=Sing-box && info "\n $(text 43) "
  [[ -n "$ONLINE" && "$ONLINE" != "$LOCAL" ]] && reading "\n $(text 9) " UPDATE[1] || info " $(text 44) "

  [[ ${UPDATE[*]} =~ [Yy] ]] && check_system_info
  if [[ ${UPDATE[0]} = [Yy] ]]; then
    wget -O $TEMP_DIR/cloudflared ${GH_PROXY}https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-$ARGO_ARCH
    if [ -s $TEMP_DIR/cloudflared ]; then
      cmd_systemctl disable argo
      chmod +x $TEMP_DIR/cloudflared && mv $TEMP_DIR/cloudflared $WORK_DIR/cloudflared
      cmd_systemctl enable argo && [ "$(systemctl is-active argo)" = 'active' ] && info " Argo $(text 28) $(text 37)" || error " Argo $(text 28) $(text 38) "
    else
      local APP=ARGO && error "\n $(text 48) "
    fi
  fi
  if [[ ${UPDATE[1]} = [Yy] ]]; then
    wget -c ${GH_PROXY}https://github.com/SagerNet/sing-box/releases/download/v$ONLINE/sing-box-$ONLINE-linux-$SING_BOX_ARCH.tar.gz -qO- | tar xz -C $TEMP_DIR sing-box-$ONLINE-linux-$SING_BOX_ARCH/sing-box
    if [ -s $TEMP_DIR/sing-box-$ONLINE-linux-$SING_BOX_ARCH/sing-box ]; then
      cmd_systemctl disable sing-box
      mv $TEMP_DIR/sing-box-$ONLINE-linux-$SING_BOX_ARCH/sing-box $WORK_DIR
      rm -rf $TEMP_DIR/sing-box-$ONLINE-linux-$SING_BOX_ARCH
      cmd_systemctl enable sing-box && [ "$(systemctl is-active sing-box)" = 'active' ] && info " Sing-box $(text 28) $(text 37)" || error " Sing-box  $(text 28) $(text 38) "
    else
      local APP=Sing-box && error "\n $(text 48) "
    fi
  fi
}

# 判断当前 sba 的运行状态，并对应的给菜单和动作赋值
menu_setting() {
  OPTION[0]="0.  $(text 35)"
  ACTION[0]() { exit; }

  if [[ ${STATUS[*]} =~ $(text 27)|$(text 28) ]]; then
    if [ -s $WORK_DIR/cloudflared ]; then
      ARGO_VERSION=$($WORK_DIR/cloudflared -v | awk '{print $3}' | sed "s@^@Version: &@g")
      [ $(ps -ef | grep "metrics.*:3010" | wc -l) -gt 1 ] && ARGO_CHECKHEALTH="$(text 46): $(wget -qO- http://localhost:$(ps -ef | awk -F '0.0.0.0:' '/cloudflared.*:3010/{print $2}' | awk 'NR==1 {print $1}')/healthcheck | sed "s/OK/$(text 37)/")"
    fi
    [ -s $WORK_DIR/sing-box ] && SING_BOX_VERSION=$($WORK_DIR/sing-box version | awk '/version/{print $NF}' | sed "s@^@Version: &@g")
    [ "$SYSTEM" = 'Alpine' ] && PS_LIST=$(ps -ef) || PS_LIST=$(ps -ef | grep -E 'sing-box|cloudflared' | awk '{ $1=""; sub(/^ */, ""); print $0 }')

    OPTION[1]="1.  $(text 29)"
    [ ${STATUS[0]} = "$(text 28)" ] && AEGO_MEMORY="$(text 52): $(awk '/VmRSS/{printf "%.1f\n", $2/1024}' /proc/$(awk '/\/etc\/sba\/cloudflared/{print $1}' <<< "$PS_LIST")/status) MB" && OPTION[2]="2.  $(text 27) Argo (sb -a)" || OPTION[2]="2.  $(text 28) Argo (sb -a)"
    [ ${STATUS[1]} = "$(text 28)" ] && SING_BOX_MEMORY="$(text 52): $(awk '/VmRSS/{printf "%.1f\n", $2/1024}' /proc/$(awk '/\/etc\/sba\/sing-box.*\/etc\/sba/{print $1}' <<< "$PS_LIST")/status) MB" && OPTION[3]="3.  $(text 27) Sing-box (sb -s)" || OPTION[3]="3.  $(text 28) Sing-box (sb -s)"
    OPTION[4]="4.  $(text 30)"
    OPTION[5]="5.  $(text 31)"
    OPTION[6]="6.  $(text 32)"
    OPTION[7]="7.  $(text 33)"
    OPTION[8]="8.  $(text 51)"
    OPTION[9]="9.  $(text 58)"

    ACTION[1]() { export_list; }
    [[ ${STATUS[0]} = "$(text 28)" ]] && ACTION[2]() { cmd_systemctl disable argo; [ "$(systemctl is-active argo)" = 'inactive' ] && info "\n Argo $(text 27) $(text 37)" || error " Argo $(text 27) $(text 38) "; } || ACTION[2]() { cmd_systemctl enable argo && [ "$(systemctl is-active argo)" = 'active' ] && info "\n Argo $(text 28) $(text 37)" || error " Argo $(text 28) $(text 38) "; }
    [[ ${STATUS[1]} = "$(text 28)" ]] && ACTION[3]() { cmd_systemctl disable sing-box; [ "$(systemctl is-active sing-box)" = 'inactive' ] && info "\n Sing-box $(text 27) $(text 37)" || error " Sing-box $(text 27) $(text 38) "; } || ACTION[3]() { cmd_systemctl enable sing-box && [ "$(systemctl is-active sing-box)" = 'active' ] && info "\n Sing-box $(text 28) $(text 37)" || error " Sing-box $(text 28) $(text 38) "; }
    ACTION[4]() { change_argo; exit; }
    ACTION[5]() { version; }
    ACTION[6]() { bash <(wget -qO- --no-check-certificate "https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcp.sh"); exit; }
    ACTION[7]() { uninstall; exit 0; }
    ACTION[8]() { bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/sing-box/main/sing-box.sh) -$L; exit; }
    ACTION[9]() { bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/argox/main/argox.sh) -$L; exit; }

  else
    OPTION[1]="1.  $(text 34)"
    OPTION[2]="2.  $(text 32)"
    OPTION[3]="3.  $(text 51)"
    OPTION[4]="4.  $(text 58)"

    ACTION[1]() { install_sba; export_list; create_shortcut; exit; }
    ACTION[2]() { bash <(wget -qO- --no-check-certificate "https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcp.sh"); exit; }
    ACTION[3]() { bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/sing-box/main/sing-box.sh) -$L; exit; }
    ACTION[4]() { bash <(wget -qO- https://raw.githubusercontent.com/fscarmen/argox/main/argox.sh) -$L; exit; }
  fi
}

menu() {
  clear
  hint " $(text 2) "
  echo -e "======================================================================================================================\n"
  info " $(text 17):$VERSION\n $(text 18):$(text 1)\n $(text 19):\n\t $(text 20):$SYS\n\t $(text 21):$(uname -r)\n\t $(text 22):$ARCHITECTURE\n\t $(text 23):$VIRT "
  info "\t IPv4: $WAN4 $WARPSTATUS4 $COUNTRY4  $ASNORG4 "
  info "\t IPv6: $WAN6 $WARPSTATUS6 $COUNTRY6  $ASNORG6 "
  info "\t Argo: ${STATUS[0]}\t $ARGO_VERSION\t $AEGO_MEMORY\t $ARGO_CHECKHEALTH\n\t Sing-box: ${STATUS[1]}\t $SING_BOX_VERSION\t\t $SING_BOX_MEMORY "
  echo -e "\n======================================================================================================================\n"
  for ((b=1;b<${#OPTION[*]};b++)); do hint " ${OPTION[b]} "; done
  hint " ${OPTION[0]} "
  reading "\n $(text 24) " CHOOSE

  # 输入必须是数字且少于等于最大可选项
  if grep -qE "^[0-9]$" <<< "$CHOOSE" && [ "$CHOOSE" -lt "${#OPTION[*]}" ]; then
    ACTION[$CHOOSE]
  else
    warning " $(text 36) [0-$((${#OPTION[*]}-1))] " && sleep 1 && menu
  fi
}

statistics_of_run-times

# 传参
[[ "$*" =~ -[Ee] ]] && L=E
[[ "$*" =~ -[Cc] ]] && L=C

while getopts ":AaSsUuVvNnBbF:f:" OPTNAME; do
  case "$OPTNAME" in
    'A'|'a' ) select_language; check_system_info; [ "$(systemctl is-active argo)" = 'inactive' ] && { cmd_systemctl enable argo; [ "$(systemctl is-active argo)" = 'active' ] && info "\n Argo $(text 28) $(text 37)" || error " Argo $(text 28) $(text 38) "; } || { cmd_systemctl disable argo; [ "$(systemctl is-active argo)" = 'inactive' ] && info "\n Argo $(text 27) $(text 37)" || error " Argo $(text 27) $(text 38) "; } ;  exit 0 ;;
    'S'|'s' ) select_language; check_system_info; [ "$(systemctl is-active sing-box)" = 'inactive' ] && { cmd_systemctl enable sing-box; [ "$(systemctl is-active sing-box)" = 'active' ] && info "\n Sing-box $(text 28) $(text 37)" || error " Sing-box $(text 28) $(text 38) "; } || { cmd_systemctl disable sing-box; [ "$(systemctl is-active sing-box)" = 'inactive' ] && info "\n Sing-box $(text 27) $(text 37)" || error " Sing-box $(text 27) $(text 38) "; } ;  exit 0 ;;
    'U'|'u' ) select_language; check_system_info; uninstall; exit 0 ;;
    'N'|'n' ) select_language; export_list; exit 0 ;;
    'V'|'v' ) select_language; check_arch; version; exit 0;;
    'B'|'b' ) select_language; bash <(wget -qO- --no-check-certificate "https://raw.githubusercontent.com/ylx2016/Linux-NetSpeed/master/tcp.sh"); exit ;;
    'F'|'f' ) VARIABLE_FILE=$OPTARG; . $VARIABLE_FILE ;;
  esac
done

select_language
check_root
check_arch
check_system_info
check_dependencies
check_system_ip
check_install
menu_setting
[ -z "$VARIABLE_FILE" ] && menu || ACTION[1]