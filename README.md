Personal VIM Configuration

To use in *nix
Hint: run the below line by putting the cursor on it, then in vim :.w !bash

ln -s ~/vimfiles ~/.vim && echo "source ~/vimfiles/_vimrc" > ~/.vimrc && mkdir ~/vimfiles/swapfiles && mkdir ~/vimfiles/undofiles && mkdir ~/vimfiles/backups

When first run, run
:PluginClean
:PluginInstall
