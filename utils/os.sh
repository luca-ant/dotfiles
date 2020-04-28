#!/bin/bash

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
ECHO_RED='echo -en \033[31m'
ECHO_GREEN='echo -en \033[32m'
ECHO_BLUE='echo -en \033[36m'
ECHO_WHITE='echo -en \033[37m'

UBUNTU=$(grep -e "^NAME" /etc/os-release 2>/dev/null| grep -io Ubuntu | head -1)
DEBIAN=$(grep -e "^NAME" /etc/os-release 2>/dev/null| grep -io Debian | head -1)
MANJARO=$(grep -e "^NAME" /etc/os-release 2>/dev/null| grep -io Manjaro | head -1)
ARCH=$(grep -e "^NAME" /etc/os-release 2>/dev/null| grep -io Arch | head -1)

DOTFILES_URL="https://github.com/luca-ant/_dotfiles.git"
DOTFILES_ROOT="/home/$USER/_dotfiles"

run_command(){
    $ECHO_BLUE
    echo [-] Running \'$*\'
    $ECHO_RED
    $* | while read L; do
        $ECHO_GREEN
        echo $L
        $ECHO_RED
    done
    $ECHO_BLUE
    echo [+] \'$*\' Done!
    $ECHO_WHITE
}


update_packet(){

    if [ $MANJARO ] || [ $ARCH ]
    then

        run_command sudo pacman --noconfirm -Syu
    fi

    if [ $UBUNTU ] || [ $DEBIAN ]
    then

        run_command sudo apt update
        run_command sudo apt upgrade -y
    fi

}

install_packet(){

    if [ $MANJARO ] || [ $ARCH ]
    then

        run_command sudo pacman --noconfirm -S $*
    fi

    if [ $UBUNTU ] || [ $DEBIAN ]
    then

        run_command sudo apt install -y $*
    fi

}
install_packet(){

    if [ $MANJARO ] || [ $ARCH ]
    then

        run_command sudo pacman --noconfirm -S $*
    fi

    if [ $UBUNTU ] || [ $DEBIAN ]
    then

        run_command sudo apt install -y $*
    fi

}


remove_packet(){

    if [ $MANJARO ] || [ $ARCH ]
    then

        run_command sudo pacman --noconfirm -Rs $*
    fi

    if [ $UBUNTU ] || [ $DEBIAN ]
    then

        run_command sudo apt purge -y $*
    fi

}


install_aur_packet(){

    if [ $MANJARO ] || [ $ARCH ]
    then

        run_command yay --noconfirm -S $*
    fi

    if [ $UBUNTU ] || [ $DEBIAN ]
    then

        run_command echo "AUR is not availabe" 2>&1
    fi

}


remove_aur_packet(){

    if [ $MANJARO ] || [ $ARCH ]
    then

        run_command yay --noconfirm -R $*
    fi

    if [ $UBUNTU ] || [ $DEBIAN ]
    then

        run_command echo "AUR is not availabe" 2>&1
    fi

}


