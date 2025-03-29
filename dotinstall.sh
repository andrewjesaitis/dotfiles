#!/bin/zsh

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files=(gitconfig gitignore_global zshrc zprofile)   # list of files/folders to symlink in homedir

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p "$olddir"
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd "$dir" || exit
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in "${files[@]}"; do
    if [ -f "$HOME/.$file" ]; then
        echo "Moving existing $file from ~ to $olddir"
        mv "$HOME/.$file" "$olddir/"
    fi

    if [ -f "$dir/$file" ]; then
        echo "Creating symlink to $file in home directory."
        ln -sf "$dir/$file" "$HOME/.$file"
    else
        echo "Warning: Source file $dir/$file does not exist"
    fi
done

# Set global git exclude file
if [ -f "$HOME/.gitignore_global" ]; then
    git config --global core.excludesfile ~/.gitignore_global
else
    echo "Warning: .gitignore_global not found"
fi
