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


# Install quarto
# Puede que no identifique bien la version, en cuyo caso hay que ponerla manualmente
# La ultima version la puedes obtener de aqui: https://github.com/quarto-dev/quarto-cli/releases/
function install_quarto(){
    cd ~
    sudo mkdir -p /opt/quarto/${QUARTO_VERSION}
    sudo curl -o quarto.tar.gz -L \
    "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz"

    sudo tar -zxvf quarto.tar.gz \
    -C "/opt/quarto/${QUARTO_VERSION}" \
    --strip-components=1
    
    sudo rm quarto.tar.gz

    # Verify the installation
    /opt/quarto/"${QUARTO_VERSION}"/bin/quarto check

    # if not worthing the symlink, try this:
    # sudo ln -s /opt/quarto/${QUARTO_VERSION}/bin/quarto /usr/local/bin/quarto
}

function install_docker(){
    sudo curl -fsSL https://get.docker.com/ -o get-docker.sh
    sudo sh get-docker.sh    
    sudo usermod -aG docker ${USER}
}


install_docker
install_fail2ban
install_tools
install_quarto

# Install Fuck
sudo apt update
sudo apt install python3-dev python3-pip python3-setuptools
pip3 install thefuck --user

# Download Oh My Posh
sudo apt install unzip
curl -s https://ohmyposh.dev/install.sh | bash -s
