echo "This is a script ran by the restoration process. You can add yours inside '$DOTFILES_PATH/restoration_scripts'"
echo
echo "Self install scripts must have chmod u+x to run"
echo
cargo install eza
sudo apt install glances
sudo apt install fd-find
# Download Oh My Posh
sudo apt install unzip
curl -s https://ohmyposh.dev/install.sh | sudo bash -s
# Install tldr
sudo apt install tldr
tldr -u
# Install fail2ban
sudo apt install fail2ban
# Install Fuck
sudo apt update
sudo apt install python3-dev python3-pip python3-setuptools
pip3 install thefuck --user