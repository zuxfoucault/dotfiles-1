#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${RED}Beginning installation${NC}"

cd ~/

# check if Homebrew is installed
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    echo -e "${RED}******* Installing Homebrew *******${NC}"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"
else
    # update homebrew
    echo -e "${RED}******* Updating Homebrew *******${NC}"
    brew update
fi

# install vim, tmux and zsh on the system on top of any current exist files
# if any are already installed then nothing happens here
brew install vim
brew install tmux
brew install zsh

# install  oh-my-zsh
echo -e "${RED}******* Installing oh-my-zsh *******${NC}"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo -e "${RED}******* Downloading dotfiles for vim, tmux and zsh *******${NC}"
cd ~
mkdir Github-Projects
cd Github-Projects
git clone https://github.com/sbernheim4/dotfiles.git
cd ~

if [ -e "${HOME}/.vimrc" ] ; then
	echo -e "${HOME}/.vimrc"
else
	touch .vimrc
fi

if [ -e "${HOME}/.tmux.conf" ] ; then
	echo -e "${HOME}/.tmux.conf"
else
	touch .tmux.conf
fi


if [ -e "${HOME}/.zshrc" ] ; then
	echo -e "${HOME}/.zshrc"
else
	touch .zshrc
fi

echo -e "${RED}******* Changing default shell to ZSH *******${NC}"
chsh -s $(which zsh)

echo -e "${RED}******* Moving honukai theme to ~/.oh-my-zsh/themes *******${NC}"
cp ~/Github-Projects/dotfiles/honukai.zsh-theme ~/.oh-my-zsh/themes

echo -e "${RED}******* Creating soft links for dotfiles (.vimrc, .tmux.conf, .zshrc) *******${NC}"
ln -sf ~/Github-Projects/dotfiles/.vimrc ~/.vimrc
ln -sf ~/Github-Projects/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/Github-Projects/dotfiles/.zshrc ~/.zshrc

echo
echo -e "Please quit and reopen your terminal application"
