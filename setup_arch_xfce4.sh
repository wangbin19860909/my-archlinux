#dhcpcd
sudo pacman -S dhcpcd
sudo systemctl enable dhcpcd
# login manager
sudo pacman -S sddm
sudo systemctl enable sddm
# xfce4
sudo pacman -S xfce4 
# vm-tools
sudo pacman -S open-vm-tools xf86-input-vmmouse xf86-video-vmware mesa gtkmm3
sudo systemctl enable vmtoolsd
sudo systemctl enable vmware-vmblock-fuse
# share clipboard
echo "[Desktop Entry]
Encoding=UTF-8
Version=0.9.4
Type=Application
Name=vmware-user
Comment=
Exec=vmware-user
OnlyShowIn=XFCE;
RunHook=0
StartupNotify=false
Terminal=false
Hidden=false" > ~/.config/autostart/vmware-user.desktop
# shared folders
echo "[Unit]
Description=Load VMware shared folders
Requires=vmware-vmblock-fuse.service
After=vmware-vmblock-fuse.service
ConditionPathExists=.host:/Downloads
ConditionVirtualization=vmware

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/vmhgfs-fuse -o allow_other -o auto_unmount .host:/Downloads /home/benny/Downloads

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/hgfs-downloads.service
sudo systemctl enable hgfs-downloads

echo "[Unit]
Description=Load VMware shared folders
Requires=vmware-vmblock-fuse.service
After=vmware-vmblock-fuse.service
ConditionPathExists=.host:/Projects
ConditionVirtualization=vmware

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/vmhgfs-fuse -o allow_other -o auto_unmount .host:/Projects /home/benny/Projects

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/hgfs-projects.service
sudo systemctl enable hgfs-projects
# useful apps
sudo pacman -S plank vim fcitx5-im fcitx5-chinese-addons
echo "[Desktop Entry]
Encoding=UTF-8
Version=0.9.4
Type=Application
Name=Plank
Comment=
Exec=plank
OnlyShowIn=XFCE;
RunHook=0
StartupNotify=false
Terminal=false
Hidden=false" > ~/.config/autostart/Plank.desktop
#yay
sudo pacman -S base-devel git
cd /tmp
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
rm -rf yay-bin
#browsers
yay -S firefox google-chrome visual-studio-code-bin
# themes
cd /tmp
git clone https://github.com/vinceliuice/Vimix-gtk-themes.git
cd Vimix-gtk-themes
./install.sh -t all -s all
cd ..
rm -rf Vimix-gtk-themes

git clone https://github.com/vinceliuice/Vimix-icon-theme.git
cd Vimix-icon-theme
./install.sh -a
cd ..
rm -rf Vimix-icon-theme

#oh my zsh & p10k
sudo pacman -S zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
yay -S ttf-meslo-nerd-font-powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
echo zsh > ~/.bashrc
# chinese fonts


