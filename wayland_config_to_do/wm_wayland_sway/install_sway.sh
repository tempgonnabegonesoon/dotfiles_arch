#!/bin/bash
SCRIPT_PATH=$PWD
echo "Updating system and reference before starting"

sudo pacman -Syu --noconfirm

echo "installing tools..."

# install stuffs
sudo pacman -S sway sddm kitty neofetch rofi swaync waybar wget curl lsb-release networkmanager network-manager-applet openvpn networkmanager-openvpn less nm-connection-editor wireless_tools wpa_supplicant bluez bluez-utils plocate git base-devel man dosfstools zsh procs xclip lsd thunar noto-fonts noto-fonts-emoji noto-fonts-cjk cargo thefuck fd discord firefox xorg-xrandr neovim go timeshift ffmpeg yt-dlp ripgrep bat htop ncdu dust jq python python-pipx wdisplays pavucontrol fzf lazygit docker virt-manager vlc ffmpeg yt-dlp flameshot feh obsidian --noconfirm

sudo pacman -S --needed git base-devel --noconfirm && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd ..

yay -S xcursor-breeze catppuccin-gtk-theme-mocha catppuccin-gtk-theme-macchiato brave-bin ttf-symbola visual-studio-code-bin spotify lazydocker pacseek spotdl nwg-look --noconfirm

# no idea why it has been installed
sudo pacman -R fontforge

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
cp $SCRIPT_PATH/zsh_config/.zsh_autocomplete $HOME
cp $SCRIPT_PATH/zsh_config/.bash_aliases $HOME
cp $SCRIPT_PATH/zsh_config/okiban-nosobi.zsh-theme $HOME/.oh-my-zsh/themes

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo "select rofi theme with rofi-theme-selector"
echo "select widget theme, cursor, ... with nwg-look"
echo "select Catpuccin-Macchiato-Standard-Lavender-dark, breeze dark, breeze cursor"

sleep 10
reboot
