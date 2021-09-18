#!/bin/bash

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
ECHO_RED='echo -en \033[31m'
ECHO_GREEN='echo -en \033[32m'
ECHO_BLUE='echo -en \033[36m'
ECHO_WHITE='echo -en \033[37m'
ECHO_RESET='echo -en \033[m'

usage(){
    echo "Usage: $0 [ install | remove ]"
}

check_user(){
    if [ $EUID == 0 ] ; then
        $ECHO_RED
        echo "${BOLD}You are root! Please, run me as normal user.${NORMAL}"
        $ECHO_RESET
        exit 1
    else
        $ECHO_BLUE
        echo "${BOLD}Hi, $USER${NORMAL}"
        $ECHO_RESET
    fi
}

check_args(){

    if [ $# != 1 ]
    then
        usage
        exit 1
    fi
    if [ $1 != install ] && [ $1 != remove ]
    then
        usage
        exit 2
    fi
}

check_cmd(){
    if [ $? -ne 0 ]
    then
        $ECHO_RED
        echo "OH NO! SOMETHING WENT WRONG... :("
        $ECHO_RESET
        exit 3
    fi
}
