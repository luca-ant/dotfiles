#!/bin/bash

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
ECHO_RED='echo -en \033[31m'
ECHO_GREEN='echo -en \033[32m'
ECHO_BLUE='echo -en \033[36m'
ECHO_WHITE='echo -en \033[37m'
ECHO_RESET='echo -en \033[m'

BYE='Have a nice day! Bye 😉'

if [ $EUID == 0 ] ; then
    echo "${BOLD}You are root! Please, run me as normal user.${NORMAL}"
    exit 1
fi

FLAG_FILE="/tmp/.upgrade_check_done"

if [ -f "$FLAG_FILE" ]
then
    exit 0
fi

$ECHO_BLUE
echo -en "\n🛠️ ${BOLD}Would you like to upgrade system?${NORMAL} [yN] "; read A ; if [ -z $A ] || [ $A != 'y' ] ; then  $ECHO_GREEN; echo "$BYE" ; $ECHO_RESET ; exit 0 ; fi
$ECHO_RESET

UBUNTU=$(grep -e "^NAME" /etc/os-release 2>/dev/null | grep -io Ubuntu | head -1)
DEBIAN=$(grep -e "^NAME" /etc/os-release 2>/dev/null | grep -io Debian | head -1)
MANJARO=$(grep -e "^NAME" /etc/os-release 2>/dev/null | grep -io Manjaro | head -1)
ARCH=$(grep -e "^NAME" /etc/os-release 2>/dev/null | grep -io Arch | head -1)


if [ $MANJARO ] || [ $ARCH ]
then
    sudo pacman --noconfirm -Syu
    touch "$FLAG_FILE"
fi

if [ $UBUNTU ] || [ $DEBIAN ]
then
    sudo apt update && sudo apt -y upgrade
    touch "$FLAG_FILE"
fi

$ECHO_BLUE
echo -e "\n✅ ${BOLD}All up to date!${NORMAL}"
$ECHO_GREEN
echo "$BYE"
$ECHO_RESET


