#!/bin/bash
###################
# .install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
###################
# homebrew install line
 ######## Variables
dir=~/dotfiles
olddir=~/dotfiles_old
files=".bashrc .vimrc .tmux.conf" # list of files/folders to symlink in homedir

########

# # create dotfiles_old in homedir
# echo "Creating $olddir for backup of any existing dotfiles in ~"
# mkdir -p $olddir
# echo "...done"

# # change to the dotfiles directory
# echo "Changing to the $dir directory"
# cd $dir
# echo "...done"

# #move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks

# for file in $files; do
	# echo "Moving any existing dotfiles from ~ to $olddir"
	# mv ~/$file ~/dotfiles_old/
	# echo "Creating symlink to $file in home directory."
	# ln -s $dir/$file ~/$file
# done

while getopts ":l" opt; do
    case $opt in
        l)
            echo "Installing homebrew..." >&2
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 

            echo "Installation complete." >&2
            ;;
        \?)
            echo "Invalid option; -$OPTARG" >&2
            ;;
    esac
done
