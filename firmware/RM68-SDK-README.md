# RM68

#### 介绍


#### SDK压缩包链接地址

20250621：
    通过网盘分享的文件：20250621
    链接: https://pan.baidu.com/s/10omz47I9bUNruT9euDZYHQ?pwd=a9pu 提取码: a9pu
#### 编译环境搭建

### 系统

SDK 编译环境 使用ubuntu16.04 其他版本不支持
ubuntu16.04下载地址：
    https://releases.ubuntu.com/16.04/ubuntu-16.04.7-desktop-amd64.iso
使用 virtualbox 安装
### 安装编译环境

sudo apt-get install gcc g++ binutils patch bzip2 flex make gettext pkg-config unzip zlib1g-dev libc6-dev subversion libncurses5-dev gawk sharutils curl libxml-parser-perl python-yaml ocaml-nox ocaml ocaml-findlib libssl-dev libfdt-dev  device-tree-compiler u-boot-tools autoconf libc6-i386  libgl1-mesa-dri:i386 mtd-utils libfdt-dev vim samba openssh-server git subversion flex make cmake quilt

### 编译
    tar xvf rm68-master.tar.gz     #默认解压到rm68-master目录下
    cd rm68-master/qsdk
    make V=s -j5
### 生成固件
    编译完成后， 需要使用命令 生成固件

    cd rm68-master/    #注意 执行命令前 需要进入到 SDK的根目录下
    mkdir -p common/build/ipq
    mkdir -p apss_proc/out/meta-scripts
    cp qsdk/qca/src/u-boot-2016/tools/pack.py apss_proc/out/meta-scripts/pack_hk.py
    sed -i 's#</linux_root_path>#/</linux_root_path>#' contents.xml
    sed -i 's#</windows_root_path>#\\</windows_root_path>#' contents.xml
    cp qsdk/bin/ipq/openwrt* common/build/ipq
    cp -r apss_proc/out/proprietary/QSDK-Base/meta-tools apss_proc/out/
    cp -rf qsdk/bin/ipq/dtbs/* common/build/ipq/
    cp -rf skales/* common/build/ipq
    cp -rf wlan_proc/build/ms/bin/5018.wlanfw.eval/* common/build/ipq/
    cp -rf wlan_proc/build/ms/bin/5018.wlanfw2.map_spruce_eval/* common/build/ipq/
    cp -rf wlan_proc/build/ms/bin/5018.wlanfw2.map_spr_spr_eval_cs/* common/build/ipq/
    cp -rf btfw_proc/out/IPQ5018/bin/FW_IMAGES/bt_fw_patch_* common/build/ipq
    cp qsdk/staging_dir/host/bin/ubinize common/build/ipq/
    cd common/build/
    sed "s/'''$/\n'''/g" -i update_common_info.py
    sed -i "s/os.chdir(ipq_dir)//" update_common_info.py
    sed -i -e '/update_common_info.py: 16M debug/,+5d' update_common_info.py
    sed '/packages/d;/"ipq5018_64"/d;/t32/d;/ret_prep_64image/d;/Required/d;/skales/d; /nosmmu/d;/os.system(cmd)/d;/os.chdir(ipq_dir)/d;/atfdir/d;/noac/d;/singleatf/d;/bl31.mbn/d;/bin_atf/d;/ret_pack_64image/d;/list_out_64_single/d;/list_out_64_apps/d;/dict_64_bit_single/d;/dict_64_bit_apps/d;/list_out_debug/d' -i update_common_info.py
    export BLD_ENV_BUILD_ID=LM256;python update_common_info.py

    执行完成后，会在common/build/bin 目录下生成几个文件
    其中nand-ipq5018-single.img 是匹配我们的硬件的固件
      
    
### 升级
    升级有两种方式
## 通过uboot升级
    在uboot下升级
    环境准备：
        电脑需要设置静态IP ： 192.168.16.112
        电脑的网口接RM68底板的WAN口
        电脑打开tftpd软件，目录选择文件nand-ipq5018-single.img所在目录
    RM68底板的调试串口位置：
![底板串口位置](image/RM68底板调试串口位置.png)
    默认串口波特率 ： 115200

    这里通过mobaxterm 终端工具演示：
    上电启动 在 串口输出 Hit any key to stop autoboot 倒计时时 按任意键 进入到uboot命令行
![uboot启动信息](image/uboot启动信息.png)
    输入命令：
        #下载固件：
        setenv ipaddr 192.168.16.123
        setenv serverip 192.168.16.112
        setenv bootargs console=ttyMSM0,115200n8
        tftpboot nand-ipq5018-single.img
        固件下载过程：
![uboot下固件下载过程](image/uboot固件下载过程.png)
        更新固件：
        imgaddr=$fileaddr && source $imgaddr:script
![uboot下固件更新过程](image/uboot固件更新过程.png)

## 通过固件升级
    固件启动成功后
    通过scp上传固件
    这里使用mobaxterm 的scp功能
    使用ssh 连接到 设备 
    用户名: root
    密码: admin
    连接成功后 修改scp的目录到/tmp下
    拖拽固件到设备上
![scp上传固件](image/使用scp上传固件到设备.png)

    固件上传成功后，使用sysupgrade命令 升级固件
    cd /tmp/
    sysupgrade nand-ipq5018-single.img


### 功能描述
## web
    默认管理地址：192.168.1.1
    web 默认密码：admin
![版本号显示](image/web显示版本号.png)