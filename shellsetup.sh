#!/usr/bin/env bash

# let's do this first
sudo apt-get install git
git clone git@github.com:flazz/vim-colorschemes.git ~/.vim
rm -rf $HOME/.vim/.git

sudo su -c '
apt-get install aptitude
aptitude update
aptitude upgrade
aptitude install zsh zlib1g-dev cmake vim python python-pip python3 cargo vim vim-gtk emacs terminator
'

my_dot_zsh='https://gist.githubusercontent.com/TvrtkoM/0904a88778a7dfdb2bc9816f03db30f3/raw/072509485796d1c7d614831b397705f9e866e6af/.zshrc_home';
my_dot_vimrc='https://gist.githubusercontent.com/TvrtkoM/79328746f59926d820e288fa68f41ac6/raw/cbff5cee9f5190eae7a5135ba93d314818fc9805/.vimrc_home';
my_dot_spacemacs='https://gist.githubusercontent.com/TvrtkoM/7a0098ce408569cd200acaa7d766/raw/617ae1dd04a22ae3d35bbe973fc2a8b5fc0e2670/.spacemacs';

src_dir="$HOME/src"
virtualenv_dir="$HOME/pyvenvs";
def_virtualenv_dir="$virtualenv_dir/py3"

# create usual dirs
if [[ ! -d $src_dir ]]; then
    mkdir $src_dir
fi

if [[ ! -d $virtualenv_dir ]]; then
    mkdir $virtualenv_dir
fi

# oh-my-zsh
wget -qO- https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh | bash

# nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
nvm install stable

# download dotfiles to home
wget $my_dot_zsh -O $HOME/.zshrc
wget $my_dot_vimrc -O $HOME/.vimrc
wget $my_doc_spacemacs -O $HOME/.spacemacs

# set up python3 virtualenv
sudo python -m pip install virtualenv
virtualenv -p python3 $def_virtualenv_dir

source $def_virtualenv_dir/bin/activate
pip install ipython requests
deactivate # deactivate virtual env py3

# exa
cargo install exa

# fuzzy finder
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install

# spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

vim +PluginInstall +qa
