# Enable aliases to be sudo’ed
alias sudo='sudo '

alias ..="cd .."
alias ...="cd ../.."
alias ls="eza --group-directories-first --modified --created --sort=type --sort=modified -r"
alias ll="eza --header -l --group-directories-first --modified --created --sort=type --sort=modified -r"
alias la="eza --header -la --group-directories-first --modified --created --sort=type --sort=modified -r"
alias ~="cd ~"
alias dotfiles='cd $DOTFILES_PATH'
alias htop='glances'
alias fd='fdfind'
alias grep='grep --color=auto'

alias bcat="batcat --paging never"
alias meme="echo '¯\_(ツ)_/¯' | pbcopy | echo '=> Copied meme to pasteboard.'"
# Git
alias gaa="git add -A"
alias gc='$DOTLY_PATH/bin/dot git commit'
alias gca="git add --all && git commit --amend --no-edit"
alias gco="git checkout"
alias gd='$DOTLY_PATH/bin/dot git pretty-diff'
alias gs="git status -sb"
alias gf="git fetch --all -p"
alias gps="git push"
alias gpsf="git push --force"
alias gpl="git pull --rebase --autostash"
alias gb="git branch"
alias gl='$DOTLY_PATH/bin/dot git pretty-log'

# Utils
alias k='kill -9'
alias i.='(idea $PWD &>/dev/null &)'
alias c.='(code $PWD &>/dev/null &)'
alias o.='open .'
alias up='dot package update_all'
