echo "This is a script ran by the restoration process. You can add yours inside '$DOTFILES_PATH/restoration_scripts'"
echo
echo "Self install scripts must have chmod u+x to run"
echo
function install_tools(){
    cargo install eza
    sudo apt install glances
    sudo apt install fd-find
    sudo apt install bat
    sudo apt install xclip
    # Install tldr
    sudo apt install tldr
    tldr -u
}

# Install fail2ban
function install_fail2ban(){
    sudo apt install fail2ban
    sudo fail2ban-client start
    sudo cp fail2ban/jail.local etc/fail2ban/jail.local
}


function install_docker(){
    sudo curl -fsSL https://get.docker.com/ -o get-docker.sh
    sudo sh get-docker.sh    
    sudo usermod -aG docker ${USER}
}


install_docker
install_fail2ban
install_tools

# Install Fuck
sudo apt update
sudo apt install python3-dev python3-pip python3-setuptools
pip3 install thefuck --user

# Download Oh My Posh
sudo apt install unzip
curl -s https://ohmyposh.dev/install.sh | bash -s
