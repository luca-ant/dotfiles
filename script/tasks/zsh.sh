#!/bin/bash

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
ECHO_RED='echo -en \033[31m'
ECHO_GREEN='echo -en \033[32m'
ECHO_BLUE='echo -en \033[36m'
ECHO_WHITE='echo -en \033[37m'
ECHO_RESET='echo -en \033[m'

WD=$(dirname $(realpath $0))
WD=$(dirname "$WD")
BD=$(dirname "$WD")

source "$WD/utils/check.sh"
source "$WD/utils/os.sh"

check_user

$ECHO_BLUE
echo "[-] RUNNING TASK $0..."
$ECHO_WHITE

if [ $# != 1 ]
then
    usage
    exit 1
fi
if [ $1 != "install" ] && [ $1 != "remove" ]
then
    usage
    exit 2
fi

if [ $1 == "install" ]

then
    install_packet zsh curl git
    color_command rm -rf ~/.oh-my-zsh

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | grep -v 'exec zsh -l')"

    color_command ln -sf "$BD/home/zshrc" ~/.zshrc
    color_command ln -sf "$BD/home/zprofile" ~/.zprofile
    color_command ln -sf "$BD/home/zshenv" ~/.zshenv
    color_command ln -sf "$BD/home/my_zsh" ~/.my_zsh

    color_command chsh -s /usr/bin/zsh


elif [ $1 == "remove" ]
then

    color_command chsh -s /bin/bash

    remove_packet zsh

    color_command rm -rf ~/.zshrc*
    color_command rm -rf ~/.zprofile
    color_command rm -rf ~/.zshenv
    color_command rm -rf ~/.my_zsh

else
    usage
    exit 3
fi

$ECHO_BLUE
echo "[+] RUNNING TASK $0... DONE!"
$ECHO_RESET

