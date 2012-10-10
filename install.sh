#! /bin/sh

INSTALL_PATH=$HOME/bin

if [ ! -e $INSTALL_PATH ]
then
  mkdir $INSTALL_PATH
fi

chmod +x vim-commander.sh
cp vim-commander.sh $INSTALL_PATH/vim-commander

ADD_IT="export PATH=$PATH:$INSTALL_PATH"

if [ -z `which vim-commander` ]
then
  if [ -e ~/.bashrc ]
  then
    echo $ADD_IT >> ~/.bashrc
  elif [ -e ~/.bash_profile ]
  then
    echo $ADD_IT >> ~/.bash_profile
  fi

  $ADD_IT
fi

echo "Installed!"
echo "----------"
vim-commander
