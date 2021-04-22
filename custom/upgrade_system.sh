#!/bin/bash

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
ECHO_RED='echo -en \033[31m'
ECHO_GREEN='echo -en \033[32m'
ECHO_BLUE='echo -en \033[36m'
ECHO_WHITE='echo -en \033[37m'
ECHO_RESET='echo -en \033[m'

BYE="${BOLD}Have a nice day! Bye ${NORMAL}😉"
SKIP="${BOLD}Skipping upgrade!${NORMAL}"

if [ $EUID == 0 ] ; then
    echo "${BOLD}You are root! Please, run me as normal user.${NORMAL}"
    exit 1
fi

FLAG_FILE="/tmp/.upgrade_done"

if [ -f "$FLAG_FILE" ]
then
    exit 0
fi

$ECHO_BLUE
echo -en "\n🛠️ ${BOLD}Would you like to upgrade system?${NORMAL} [y|N|s] "
read A
if [ -n $A ] && [ $A == 's' ]
then
    touch "$FLAG_FILE"
    $ECHO_RED ;  echo "$SKIP" ; $ECHO_GREEN ; echo "$BYE" ; $ECHO_RESET
    exit 0
elif [ -z $A ] || [ $A != 'y' ]
then
    $ECHO_GREEN; echo "$BYE" ; $ECHO_RESET
    exit 0
fi
$ECHO_RESET

UBUNTU=$(grep -e "^NAME" /etc/os-release 2>/dev/null | grep -io Ubuntu | head -1)
DEBIAN=$(grep -e "^NAME" /etc/os-release 2>/dev/null | grep -io Debian | head -1)
MANJARO=$(grep -e "^NAME" /etc/os-release 2>/dev/null | grep -io Manjaro | head -1)
ARCH=$(grep -e "^NAME" /etc/os-release 2>/dev/null | grep -io Arch | head -1)


if [ $MANJARO ] || [ $ARCH ]
then
    sudo pacman -Syu 2>&1
    touch "$FLAG_FILE"
fi

if [ $UBUNTU ] || [ $DEBIAN ]
then
    sudo apt update 2>&1 && sudo apt upgrade 2>&1
    touch "$FLAG_FILE"
fi

$ECHO_BLUE
echo -e "\n✅ ${BOLD}All up to date!${NORMAL}"
$ECHO_GREEN
echo "$BYE"
$ECHO_RESET


