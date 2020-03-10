

xrandr --output DP-2 --primary --right-of DVI-D-0
setxkbmap dvp -option ctrl:swapcaps
xrdb -merge .Xresources
wmname LG3D
slstatus &
firefox &
exec dwm
