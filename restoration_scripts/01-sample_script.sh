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