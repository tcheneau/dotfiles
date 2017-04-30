compton -b
gnome-keyring-daemon
setxkbmap us altgr-intl
parcellite&
xbindkeys&
xscreensaver&
xautolock -time 7 -detectsleep -locker "xscreensaver-command --lock"&
syncthing&
xsetroot -cursor_name left_ptr
feh --bg-max ~/snapshot/phraxismoon2HDfree.jpg
#bash ~/.config/barmk.sh | lemonbar -b &
~/sources/yabar/yabar &
stalonetray --geometry "1x1+1900+1060"  -bg "#34322e"  -i 18 --kludges=force_icons_size&
#exec dbus-run-session awesome
exec dbus-run-session bspwm
