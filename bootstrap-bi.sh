#!/bin/bash

# wget https://raw.githubusercontent.com/plan-net/appliance/master/bootstrap-bi.sh
# bash bootstrap-bi.sh

if (( $EUID != 0 )); then
    echo "restarting as root..."
    su -c "cd $PWD; /bin/bash $0"
    exit
fi

echo "
██████╗ ███╗   ██╗     ██████╗ ██╗    ██╗   ██╗██████╗
██╔══██╗████╗  ██║     ██╔══██╗██║    ██║   ██║██╔══██╗
██████╔╝██╔██╗ ██║     ██████╔╝██║    ██║   ██║██████╔╝
██╔═══╝ ██║╚██╗██║     ██╔══██╗██║    ╚██╗ ██╔╝██╔══██╗
██║     ██║ ╚████║ ██╗ ██████╔╝██║     ╚████╔╝ ██████╔╝
╚═╝     ╚═╝  ╚═══╝ ╚═╝ ╚═════╝ ╚═╝      ╚═══╝  ╚═════╝
VERSION 1.1

"

if [ -n "$SUDO_USER" ]; then
    USER="$SUDO_USER"
else
    USER="$USERNAME"
fi
USERHOME="/home/$USER"

test -d "$USERHOME/.pnbi_salt" || mkdir "$USERHOME/.pnbi_salt"
chown $USER:$USER "$USERHOME/.pnbi_salt"
cd "$USERHOME/.pnbi_salt"

if ! [ -x "$(command -v salt-minion)" ]; then
    echo "installing saltstack"
    wget -O bootstrap-salt.sh https://bootstrap.saltstack.com
    sh bootstrap-salt.sh -X stable
fi

if ! [ -x "$(command -v git)" ]; then
    echo "installing git"
    apt-get install git --yes
fi

if [ ! -d appliance ]; then
    git clone https://github.com/plan-net/appliance.git
    chown -R $USER:$USER appliance
else
    cd appliance
    git pull
    cd ..
fi

rm $USERHOME/.pnbi_salt/.update
salt-call --file-root $USERHOME/.pnbi_salt/appliance/devops -l info --local --state-output=changes state.apply setup 2>&1 | tee $USERHOME/salt_call.log
chown $USER:$USER $USERHOME/salt_call.log
chmod 777 $USERHOME/salt_call.log

echo
echo "system requires reboot"
echo "hit return to continue"
echo
read answer

reboot
