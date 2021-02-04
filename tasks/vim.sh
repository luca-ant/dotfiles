#!/bin/bash

BOLD=$(tput bold)
NORMAL=$(tput sgr0)
ECHO_RED='echo -en \033[31m'
ECHO_GREEN='echo -en \033[32m'
ECHO_BLUE='echo -en \033[36m'
ECHO_WHITE='echo -en \033[37m'

WD=$(dirname $(realpath $0))
WD=$(dirname "$WD")

source "$WD/utils/check_user.sh"
source "$WD/utils/os.sh"
#source "$WD/utils/check_args.sh"

$ECHO_BLUE
echo "[-] RUNNING TASK $0..."
$ECHO_WHITE

usage(){
    $ECHO_BLUE
    echo "Usage: $0 [ install | remove ]"
    $ECHO_WHITE
}

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
    install_packet wget vim

    run_command rm -rf ~/.vim
    run_command mkdir -p ~/.vim/autoload
    run_command mkdir -p ~/.vim/bundle
    run_command mkdir -p ~/.vim/undodir

    run_command wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -O ~/.vim/autoload/plug.vim
    run_command wget https://tpo.pe/pathogen.vim -O ~/.vim/autoload/pathogen.vim

    run_command ln -sf "$WD/home/vimrc" ~/.vimrc
    run_command ln -sf "$WD/home/vim/ultisnips" ~/.vim/ultisnips

    echo | vim +PlugInstall +qa


elif [ $1 == "remove" ]
then

    remove_packet vim

    run_command rm -rf ~/.vim
    run_command rm -rf ~/.vimrc

else
    usage
    exit 3
fi

$ECHO_BLUE
echo "[+] RUNNING TASK $0... DONE!"
$ECHO_WHITE


