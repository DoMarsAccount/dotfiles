#!/bin/bash
###################
# .install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
###################

usage() { printf "%s" "\
Why?: Install the files I find most vital to working on any system.

Flags:
  -n                      Install on a new machine/ distro 
  -m                      Install macOS specific software
  -l                      Install w/ special options for 
                            the UT Learning Lab
  -x                      Remove the backup of existing dotfiles
  -i                      Install w/o backing up existing dotfiles
  -r                      Install & backup existing (responsible)
  -h                      You're looking at it
"
}

 ######## Variables
dir=~/dotfiles
olddir=~/dotfiles_old
files=".bashrc .vimrc .tmux.conf .fScripts" # list of files/folders to symlink in homedir

########
saveOldFiles() {
    # create dotfiles_old in homedir
    echo "=============================================="
    echo "Creating $olddir for backup of any existing dotfiles in ~"
    mkdir -p $olddir
    echo "...done"
    echo "----------"
    for file in $files; do
        echo "Moving any existing dotfiles from ~ to $olddir"
        mv ~/$file $olddir
    done
    echo "=============================================="
}

basicInstall() {

    # change to the dotfiles directory
    echo "Changing to the $dir directory"
    cd $dir
    echo "...done"
    echo "================"
    # move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks

    for file in $files; do
        echo "=============================================="
    	echo "Creating symlink to $file in home directory."
    	ln -s $dir/$file ~/$file
        echo "=============================================="
    done

    echo "dotfile installation complete."
}

nonSudoItems() {

    # install Vundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

}

macOnlyItems() {

    # install macvim
    git clone https://github.com/macvim-dev/macvim.git ~/Desktop

    # install iTerm2
    git clone https://github.com/gnachman/iTerm2.git

    # cd ~/Desktop/macvim
    # make install

    # cd ../iterm2
    # make install

}

get_args() {
    while getopts ":lxhirnm" opt; do
        case $opt in
            h) usage; exit 1 ;;
            l)
                echo "Installing homebrew..." >&2
                /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" 

                echo "Homebrew installation complete." >&2
                ;;
            x)
                echo "Removing $olddir..." >&2
                rm -rf $olddir
                echo "Done." >&2
                ;;
            n)
                echo "" >&2
                nonSudoItems;
                basicInstall;
                exit 1
                ;;
            m)
                echo "" >&2
                macOnlyItems;
                exit 1
                ;;
            i) 
                echo "" >&2
                basicInstall; 
                exit 1 
                ;;
            "?")
                echo "Invalid option: -$OPTARG" >&2
                ;;
            "r")
                echo "" >&2
                echo "Running responsible installation..." >&2
                saveOldFiles;
                basicInstall;
                exit 1
                ;;
        esac
    done
}

main () {

    get_args "$@"

}

main "$@"