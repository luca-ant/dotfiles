
alias ll='ls -alFh'
alias l='ls -lhF'
alias lll='ls -lhFSr'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias pacman_autoremove='sudo pacman -R $(pacman -Qdtq)'

alias vim='vim -p'
alias vims='vim $(fzf --height 50% --reverse)'




# cmd
alias run='run(){ setsid $* >/dev/null 2>&1 }; run'
alias size='du -d1 -h'
alias cpv='rsync -ah --info=progress2'

alias rn='rn_fn(){N=$(echo "$1" | tr "[:punct:]" "_" | tr "[:blank:]" "_" | tr -s "_") ;  mv "$1" "$N"}; rn_fn'
#alias rn='rn_fn() {N=$(echo "$1" | tr " \\":;\\|/*!@#$%^&*,()[]{}" "_" | tr -s "_") ;  mv "$1" "$N"}; rn_fn'
alias rn_all='rn_all_fn() {for F in * ; do if [ -f "$F" ] ; then rn "$F" ; fi ; done }; rn_all_fn'

alias ip_pub="curl -s https://ipinfo.io/ip"
alias weather='weather_fn(){echo "$*" | tr " " "_" | xargs -I{} curl -s "https://v2.wttr.in/{}" }; weather_fn'


# systemd
alias sc='systemctl'
alias scu='systemctl --user'

alias scst='sudo systemctl start'
alias scsp='sudo systemctl stop'
alias scrl='sudo systemctl reload'
alias scrst='sudo systemctl restart'
alias sce='sudo systemctl enable'
alias scd='sudo systemctl disable'

alias scs='systemctl status'
