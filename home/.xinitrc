compton -b
gnome-keyring-daemon
setxkbmap us altgr-intl
parcellite&
xbindkeys&
xscreensaver&
xautolock -time 7 -locker "xscreensaver-command --lock"&
syncthing&
stalonetray --geometry "1x1+1900+1060"  -bg "#34322e"  -i 18&
feh --bg-max ~/snapshot/phraxismoon2HDfree.jpg
bash ~/.config/barmk.sh | lemonbar -b &
#exec dbus-run-session awesome
exec dbus-run-session bspwm
