#!/bin/bash
###################
# .install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
###################

######## Variables
dir=~/dotfiles
olddir=~/dotfiles_old
files=".bashrc .vimrc .tmux.conf .fScripts" # list of files/folders to symlink in homedir
nonSudoFile=~/domars_apps
######## Functions
usage() { printf "%s" "\

Flags:

:[dotfiles]
  -n                      Install dotfiles on a [NEW] machine/ distro
  -l                      Install dotfiles on [NEW] devices with [no root access]

  -r                      Install & [backup existing] dotfiles
  -i                      Install & [remove existing] dotfiles

:[Extras]
  -m                      Install macOS specific software (atom, iTerm2, macvim)
  -z                      Install oh-my-zsh & E Corp terminal theme
  -x                      Remove the backup of existing dotfiles

  -h                      The help page you're looking at

"
}

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
    # just to make sure
    cd ~/

    # install Vundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

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

    # install homebrew w/o root access
    cd ~/
    mkdir homebrew
    curl -L https://github.com/Homebrew/brew/tarball/master
    tar xz --strip 1 -C homebrew

}

macOnlyItems() {

    # if root
    # install homebrew
    # echo "Installing homebrew..." >&2
    # /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # echo "Homebrew installation complete." >&2

    # install atom
    cd ~/Desktop
    git clone https://github.com/atom/atom.git
    cd atom
    script/build --install

    # install macvim
    cd ~/Desktop
    git clone https://github.com/macvim-dev/macvim.git ~/Desktop

    # install iTerm2
    cd ~/Desktop
    git clone https://github.com/gnachman/iTerm2.git

    # cd ~/Desktop/macvim
    # make install

    cd ~/Desktop/iTerm2
    echo "Installing iTerm2..."
    make install

}

# works with or w/o root access
setupZsh() {

    cd ~/
    echo "Installing oh-my-zsh..."
    # install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # install E Corp terminal theme
    git clone https://github.com/marcorosa/eterm.git
    cd eterm
    mkdir -p $ZSH/custom/themes
    cp eterm.zsh-theme $ZSH/custom/themes/

    echo "To setup the E Corp theme, add \"ZSH_THEME=\"eterm\"\" to your
    .zshrc file"

}

get_args() {
    while getopts ":lxhirnmz" opt; do
        case $opt in
            h) usage; exit 1 ;;
            l)
                nonSudoItems;
                basicInstall;
                exit 1
                ;;
            x)
                echo "Removing $olddir..." >&2
                rm -rf $olddir
                echo "Done." >&2
                ;;
            n)
                echo "" >&2
                basicInstall;
                exit 1
                ;;
            m)
                echo "" >&2
                echo "Installing macOS specific items..." >&2
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
            "z")
                echo "" >&2
                setupZsh;
                exit 1
                ;;
        esac
    done
}

main () {

    get_args "$@"

}

main "$@"
