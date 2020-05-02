#!/bin/bash

WD=$(dirname $(realpath $0))
WD=$(dirname "$WD")

source "$WD/utils/check_user.sh"
source "$WD/utils/os.sh"
#source "$WD/utils/check_args.sh"

run_command echo "[-] RUNNING TASK $0..."

usage(){
    run_command echo "Usage: $0 [ install | remove ]"
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
    install_packet zsh curl
    run_command rm -rf ~/.oh-my-zsh

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | grep -v 'exec zsh -l')"

    run_command ln -sf "$WD/zsh/zshrc" ~/.zshrc
    run_command ln -sf "$WD/zsh/zprofile" ~/.zprofile

    run_command chsh -s /usr/bin/zsh


elif [ $1 == "remove" ]
then

    remove_packet zsh

    run_command rm -rf ~/.zshrc*
    run_command rm -rf ~/.zprofile

#    run_command chsh -s /bin/bash

else
    usage
    exit 3
fi

run_command echo "[+] RUNNING TASK $0... DONE!"




