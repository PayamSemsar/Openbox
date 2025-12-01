#!/bin/bash

# پاک کردن بسته‌های قبلی
echo "پاک کردن بسته‌های قبلی..."
sudo pacman -Rns --noconfirm openbox obconf nitrogen lxappearance tint2 plank pcmanfm xfce4-terminal gedit git xorg-server xorg-xinit volumeicon network-manager-applet gtk-engine-murrine numix-themes-archblue lightdm lightdm-gtk-greeter

# پاک کردن فایل‌های پیکربندی قبلی
echo "پاک کردن فایل‌های پیکربندی قبلی..."
rm -rf ~/.config/openbox
rm -rf ~/.config/tint2
rm -rf ~/.xinitrc
rm -rf ~/.config/plank
rm -rf ~/.config/gtk-3.0

# نصب بسته‌های جدید
echo "نصب بسته‌های جدید..."
sudo pacman -S --needed --noconfirm openbox obconf nitrogen lxappearance tint2 plank pcmanfm xfce4-terminal gedit git xorg-server xorg-xinit volumeicon network-manager-applet gtk-engine-murrine numix-themes-archblue lightdm lightdm-gtk-greeter

# کپی فایل‌های پیکربندی Openbox
echo "کپی فایل‌های پیکربندی Openbox..."
cp -r /etc/xdg/openbox ~/.config/

# ایجاد فایل autostart برای Openbox
echo "ایجاد فایل autostart..."
touch ~/.config/openbox/autostart
chmod +x ~/.config/openbox/autostart

# اضافه کردن برنامه‌ها به فایل autostart
echo "اضافه کردن برنامه‌ها به فایل autostart..."
cat > ~/.config/openbox/autostart <<EOF
#!/bin/sh

# اجرای نوار وظیفه tint2
tint2 &

# اجرای داک plank
plank &

# تنظیم تصویر زمینه با nitrogen
nitrogen --restore &

# اجرای کنترلر صدا
volumeicon &

# اجرای مدیر شبکه
nm-applet &
EOF

# تنظیم Openbox به عنوان مدیر پنجره پیش‌فرض
echo "تنظیم Openbox به عنوان مدیر پنجره پیش‌فرض..."
echo "exec openbox-session" > ~/.xinitrc

# اعمال تم
echo "اعمال تم..."
obconf --set --theme /usr/share/themes/Numix-archblue/openbox-3/themerc

# پیکربندی lightdm
echo "پیکربندی lightdm..."
sudo sed -i 's/^greeter-session=.*/greeter-session=lightdm-gtk-greeter/' /etc/lightdm/lightdm.conf
sudo systemctl enable lightdm.service

# راه‌اندازی مجدد سیستم
echo "راه‌اندازی مجدد سیستم..."
read -p "برای راه‌اندازی مجدد سیستم، کلید Enter را فشار دهید..."
reboot