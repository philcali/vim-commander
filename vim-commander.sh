#! /bin/sh

# Globals
VIM_CONFIGS=$HOME/.vim/configs
VIM_CURRENT=$HOME/.vimrc

if [ ! -e $VIM_CONFIGS ]
then
  echo "[Commander]: Creating $VIM_CONFIGS..."
  mkdir $VIM_CONFIGS;
fi

if [ -z $1 ]
then
  SWITCH="help"
else
  SWITCH=$1
fi

test_file () {
  FILE=$VIM_CONFIGS/vim-$1
  if [ ! -e $FILE ]
  then
    echo "[Commander]: $FILE not found... try list"
  else
     $2 $FILE $3
  fi
}

case "$1" in
  "list" )
    echo "[Commander]: Current configs"
    for config in $VIM_CONFIGS/*; do
      NAME=`echo $config | grep -oE "[^/]+$"`
      echo " - $NAME"
    done;;
  "install" )
    if [ "$3" != '' ]
    then
      INSTALL_FILE=$3
    elif [ -e $VIM_CURRENT ]
    then
      INSTALL_FILE=$VIM_CURRENT
    fi

    if [ -z $INSTALL_FILE ]
    then
      echo "[Commander]: Nothing to install."
    else
      echo "[Commander]: Installing $INSTALL_FILE as $2"
      cp $INSTALL_FILE $VIM_CONFIGS/vim-$2
    fi
    ;;
  "remove" )
    echo "[Commander]: Removing $2"
    rm $VIM_CONFIGS/vim-$2
    ;;
  "use" )
    test_file $2 "cp -v " $VIM_CURRENT
    ;;
  "cat" )
    test_file $2 "cat"
    ;;
  * )
    echo "vim-commander v0.1.0, Copyright 2012 Philip Cali"
    echo ""
    echo "[Commander]: usage: vim-commander [command] [arg]*"
    echo "   commands:"
    echo "    - install name [vimrc]: installs a vimrc (defaults ~/.vimrc)"
    echo "    - list                : lists installed vimrc's"
    echo "    - remove name         : removes installed vimrc"
    echo "    - use name            : switches vimrc's"
    echo ""
    ;;
esac
