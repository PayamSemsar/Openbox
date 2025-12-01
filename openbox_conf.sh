#!/bin/bash

# پاک کردن تمام بسته‌های نصب شده توسط اسکریپت
echo "پاک کردن بسته‌ها..."
sudo pacman -Rns --noconfirm openbox obconf nitrogen lxappearance tint2 plank pcmanfm xfce4-terminal gedit git xorg-server xorg-xinit volumeicon network-manager-applet gtk-engine-murrine numix-themes-archblue lightdm lightdm-gtk-greeter

# پاک کردن فایل‌های پیکربندی
echo "پاک کردن فایل‌های پیکربندی..."
rm -rf ~/.config/openbox
rm -rf ~/.config/tint2
rm -rf ~/.config/plank
rm -rf ~/.config/gtk-3.0
rm -f ~/.xinitrc

# پاک کردن تنظیمات lightdm
echo "پاک کردن تنظیمات lightdm..."
sudo rm -f /etc/lightdm/lightdm.conf

# غیرفعال کردن سرویس lightdm
echo "غیرفعال کردن سرویس lightdm..."
sudo systemctl disable lightdm.service

# پاک کردن کش pacman (اختیاری)
echo "پاک کردن کش pacman..."
sudo pacman -Scc

# راه‌اندازی مجدد سیستم (اختیاری)
echo "راه‌اندازی مجدد سیستم..."
read -p "برای راه‌اندازی مجدد سیستم، کلید Enter را فشار دهید..."
reboot