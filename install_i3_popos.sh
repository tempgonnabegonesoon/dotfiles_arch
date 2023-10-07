#!/bin/bash
SCRIPT_PATH=$PWD
echo "Updating system and reference before starting"
sudo apt update -y

echo "installing tools..."

sudo apt install i3-wm kitty neofetch rofi wget curl lsb-release plocate git man dosfstools picom vi vim zsh procs lsd noto-fonts noto-fonts-emoji noto-fonts-cjk cargo thefuck fd discord firefox xorg-xrandr neovim go timeshift ffmpeg yt-dlp ripgrep bat htop ncdu dust jq python python-pipx fzf lazygit docker virt-manager vlc ffmpeg yt-dlp flameshot obsidian breeze-cursor-theme ttf-symbola spotify spotdl polychromatic playerctl btop tldr bitwarden remmina freerdp libvncserver -y
# for i3wm
sudo apt install i3-wm 

# IN theme.conf
echo "Backuping current config"
if ! [ -d $HOME/.config ]; then
	cp -r -p $HOME/.config $HOME/.config.bak
fi

echo "Installing configs/themes..."
cp -r $SCRIPT_PATH/.config $HOME

# Install font
echo "Installing font..."

sudo mkdir -p /usr/share/fonts/TTF/
sudo cp -r $SCRIPT_PATH/fonts/Caskaydia /usr/share/fonts/TTF/
fc-cache

echo "Installing rofi..."
mkdir -p $HOME/.local/share/rofi
cp -r $SCRIPT_PATH/rofi/themes $HOME/.local/share/rofi

# Install oh-my-zsh
echo "Installing omz..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp $SCRIPT_PATH/zsh_config/.zshrc $HOME
cp $SCRIPT_PATH/zsh_config/.bash_aliases $HOME
cp $SCRIPT_PATH/zsh_config/okiban-nosobi.zsh-theme $HOME/.oh-my-zsh/themes

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "Removing useless desktop files for rofi"
cd /usr/share/applications/
sudo find . -name "in.lsp_plug.*" -exec mv {} {}.old \;

# add user to plugdev group
echo "Add $USER to plugdev group"
sudo usermod -aG plugdev $USER
systemctl --user enable openrazer-daemon

