#!/bin/bash
# Install Openbox
pacman -S openbox obconf nitrogen lxappearance --noconfirm

# Install panel and dock, file manager, and terminal
pacman -S tint2 plank pcmanfm xfce4-terminal gedit git --noconfirm

# Install X SERVER
pacman -S --needed xorg-server xorg-xinit --noconfirm

# Install volume controller
pacman -S volumeicon --noconfirm

# Install WiFi manager
pacman -S network-manager-applet --noconfirm

# Install some popular Openbox themes
pacman -S gtk-engine-murrine numix-themes-archblue --noconfirm 

# Copy Openbox configuration files
cp -r /etc/xdg/openbox ~/.config/

# Create Openbox autostart file
touch ~/.config/openbox/autostart
chmod +x ~/.config/openbox/autostart

# Add panel, dock, wallpaper manager, volume controller, and WiFi manager to Openbox autostart file

echo "tint2 &" >> ~/.config/openbox/autostart
echo "plank &" >> ~/.config/openbox/autostart
echo "nitrogen --restore &" >> ~/.config/openbox/autostart
echo "volumeicon &" >> ~/.config/openbox/autostart
echo "nm-applet &" >> ~/.config/openbox/autostart

# Set Openbox as default window manager
echo "exec openbox-session" > ~/.xinitrc

# Apply a theme

obconf --set --theme /usr/share/themes/Numix-archblue/openbox-3/themerc

pacman -S lightdm lightdm-gtk-greeter --noconfirm

sed -i 's/^greeter-session=.*/greeter-session=lightdm-gtk-greeter/' /etc/lightdm/lightdm.conf

systemctl enable lightdm.service

reboot now