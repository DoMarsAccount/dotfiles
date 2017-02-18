#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

EDITOR=vim

export PATH=$PATH:$HOME/.fScripts

export VISUAL="vim"

export PATH

# Generate background
#wal -qt -i '/Wallpapers'

# Import colorscheme from 'wal'
#(wal -r &)
