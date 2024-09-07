function cdd() {
	cd "$(ls -d -- */ | fzf)" || echo "Invalid directory"
}

function z() {
	fname=$(declare -f -F _z)

	[ -n "$fname" ] || source "$DOTLY_PATH/modules/z/z.sh"

	_z "$1"
}


function pubkey() {
    file=$(ls -1 --sort=modified  ~/.ssh | grep .pub | fzf --layout=reverse --header="Selecciona la clave publica que quieres copiar")
    cat ~/.ssh/$file | pbcopy | echo '=> Public key copied to pasteboard.'
}



function recent_dirs() {
	# This script depends on pushd. It works better with autopush enabled in ZSH
	escaped_home=$(echo $HOME | sed 's/\//\\\//g')
	selected=$(dirs -p | sort -u | fzf)

	cd "$(echo "$selected" | sed "s/\~/$escaped_home/")" || echo "Invalid directory"
}


cecho () {
 
    declare -A colors;
    colors=(\
        ['red']='\033[31m'\
        ['green']='\033[32m'\
        ['yellow']='\033[0;33m'\
        ['blue']='\033[34m'\
        ['magenta']='\033[35m'\
        ['cyan']='\033[36m'\
        ['white']='\033[0;37m'\
		['orange']='\033[33m'\
		['default']='\033[39m'\
    );
 
    local defaultMSG="No message passed.";
    local defaultColor="default";
    local defaultNewLine=true;
 
    while [[ $# -gt 1 ]];
    do
    key="$1";
 
    case $key in
        -c|--color)
            color="$2";
            shift;
        ;;
    esac
    shift;
    done
 
    message=${1:-$defaultMSG};   # Defaults to default message.
    color=${color:-$defaultColor};   # Defaults to default color, if not specified.
	
    echo -e "${colors[$color]}" "$@";
    tput sgr0; #  Reset text attributes to normal without clearing screen.
 
    return;
}
 
warning () {
 
    cecho -c 'yellow' "$@";
}
 
error () {
 
    cecho -c 'red' "$@";
}
 
information () {
 
    cecho -c 'blue' "$@";
}