#!/bin/sh
# depends xmodmap xcape
# https://github.com/alols/xcape

# clear all mappings
setxkbmap -option ''
setxkbmap -option ctrl:nocaps

# assign capslock to control on press, escape on release
xmodmap -e 'clear Lock'
xmodmap -e 'keycode 66 = Control_L'
xmodmap -e 'add Control = Control_L'
# make a fake escape key (so we can map it with xcape)
xmodmap -e 'keycode 999 = Escape'
xcape -e 'Control_L=Escape'

# assign return to control on press, return on release
xmodmap -e 'keycode 36 = 0x1234'
xmodmap -e 'add Control = 0x1234'
# make a fake return key (so we can map it with xcape)
xmodmap -e 'keycode any = Return'
xcape -e '0x1234=Return'
