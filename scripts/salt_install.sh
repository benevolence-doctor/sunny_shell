#!/bin/bash

help() {
    cat <<'EOF'
This script functions:
1. Install epel repo
2. Setup hostname if provided -H argument
3. Install and start salt-minion

Options:

-m salt_master_ip   : assign salt master ip
-H hostname         : localhost's hostname
-h                  : display this help information
-v 

EOF
}

sethostname() {
    if [ -z "$1" ]; then
        echo "Usage: sethostname hostname";
        exit 2
    fi

    hostname $1

    sed -i '/^HOSTNAME/d'  /etc/sysconfig/network
    echo "HOSTNAME=$1" >>/etc/sysconfig/network

    sed -i "/^127\.0\.0\.1\s\+$1\s*$/d"  /etc/hosts
    sed -i "1i127.0.0.1 $1" /etc/hosts
}

installsaltminion() {
    if [ -z "$1" ]; then
        echo -e "You must provide salt master ip\n";
        help
        exit 1
    fi
    sed -i '/^[^#]\+\ssalt/d' /etc/hosts
    echo "$1 salt" >>/etc/hosts
    hostname=`hostname` 
    if [ "$hostname" = 'localhost.localdomain' ]; then
        echo -e "You must change the hostname\n";
        help
        exit 3
    fi
    yum -y install salt-minion
}

checkos() {
    if ! rpm -qa|grep -i -P "centos-release|redhat-release" &>/dev/null; then
        echo "The Operation must be Redhat family";
        exit 1
    fi
}

checkuser() {
    uid=`id -u`
    if [ $uid -ne 0 ]; then
        echo "`basename $0` must be run as root"
        exit 1
    fi
}

checkos;
checkuser;

# option handle
while getopts "hm:H:" arg; do
    case $arg in
        h)
            help;
            ;;
        m)
            master=$OPTARG
            ;;
        H)
            myhostname=$OPTARG
            ;;
        ?)
            echo
            help
            exit 1
            ;;
    esac
done

curl -o /etc/yum.repos.d/ownsource.repo http://www.comingchina.com:8080/testing/ownsource/ownsource.repo
yum -y install epel-release

# set hostname
sethostname $myhostname

# install salt-minion
if [ -z "$master" ]; then
        master='202.103.191.14'
fi
installsaltminion $master

echo "$myhostname" >/etc/salt/minion_id
rm -rf /etc/salt/pki/minion/
service salt-minion restart

sleep 3

salt-call saltutil.sync_all || exit 1
salt-call state.highstate

authkey=$(salt-call pillar.get mailsend:authkey|tr -d [:space:] |sed -r 's/.*://')
serverident=$(salt-call pillar.get mailsend:serverident|tr -d [:space:] |sed -r 's/.*://')
if [ -n "$authkey" -a -n "$serverident" ];then
    salt-call state.sls mailsend
fi
