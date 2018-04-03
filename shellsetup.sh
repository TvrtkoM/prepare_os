#!/usr/bin/env bash

sudo su -c '
apt-get install aptitude
aptitude update
aptitude upgrade
aptitude install zsh git cmake vim python python-pip python3 cargo vim emacs
'

my_dot_zsh='https://gist.githubusercontent.com/TvrtkoM/0904a88778a7dfdb2bc9816f03db30f3/raw/072509485796d1c7d614831b397705f9e866e6af/.zshrc_home';
my_dot_vimrc='https://gist.githubusercontent.com/TvrtkoM/79328746f59926d820e288fa68f41ac6/raw/cbff5cee9f5190eae7a5135ba93d314818fc9805/.vimrc_home';
my_dot_spacemacs='https://gist.github.com/TvrtkoM/7a0098cfd3ae408569cd200acaa7d766';

# download dotfiles to home
wget $my_dot_zsh -O $HOME/.zshrc
wget $my_dot_vimrc -O $HOME/.vimrc
wget $my_doc_spacemacs -O $HOME/.spacemacs

src_dir="$HOME/src"
virtualenv_dir="$HOME/pyvenvs";
def_virtualenv_dir="$virtualenv_dir/py3"

# create usual dirs
if [ ! -d $src_dir]; then
    mkdir $src_dir
fi

if [ ! -d $virtualenv_dir]; then
    mkdir $virtualenv_dir
fi

# oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
nvm install stable

# set up python3 virtualenv
sudo python -m pip install virtualenv
virtualenv -p python3 $def_virtualenv_dir

source $def_virtualenv_dir/py3/bin/activate
pip install ipython
deactivate # deactivate virtual env py3

# exa
cargo install exa

# fuzzy finder
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
$HOME/.fzf/install

# spacemacs
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# vim plugins
vim +PluginInstall +qa