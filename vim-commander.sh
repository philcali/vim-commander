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

vimrc_file () {
  if [ -z $1 ]
  then
    INSTALL_FILE=$VIM_CURRENT
  elif [ -e $1]
  then
    INSTALL_FILE=$1
  else
    INSTALL_FILE=''
  fi
}

case "$1" in
  "list" )
    echo "[Commander]: Current configs"
    for config in $VIM_CONFIGS/*; do
      NAME=`echo $config | grep -oE "[^/]+$"`
      echo " - $NAME"
    done
    ;;
  "master" )
    vimrc_file $2
    MASTER_FILE=$INSTALL_FILE
    echo "[Commander]: Making $MASTER_FILE master vimrc file"
    cp $MASTER_FILE $VIM_CONFIGS/vim-master
    ;;
  "wipe" )
    echo "[Commander]: Wiping all configs"
    rm $VIM_CONFIGS/*
    ;;
  "diff" )
    if [ -e $VIM_CONFIGS/vim-master ]
    then
      if [ ! -e $VIM_CONFIGS/vim-$2 ]
      then
        cp $3 $VIM_CONFIGS/vim-$2
      fi
      TO_FILE=$VIM_CONFIGS/vim-$2
      DIFF_FILE=$VIM_CONFIGS/vim-diff-$2
      echo "[Commander]: Creating a diff patch from vim-master"
      diff $VIM_CONFIGS/vim-master $TO_FILE > $DIFF_FILE
    else
      echo "[Commander]: Nothing to do."
    fi
    ;;
  "patch" )
    if [ -e $VIM_CONFIGS/vim-diff-$2 ]
    then
      echo "[Commander]: Attempting to patch master"
      patch -p0 < $VIM_CONFIGS/vim-diff-$2
    else
      echo "[Commander]: Nothing to do"
    fi
    ;;
  "install" )
    if [ -z $INSTALL_FILE ]
    then
      echo "[Commander]: Nothing to install."
    else
      echo "[Commander]: Installing $INSTALL_FILE as $2"
      cp $INSTALL_FILE $VIM_CONFIGS/vim-$2

      if [ ! -e $VIM_CONFIGS/vim-master ]
      then
        echo "[Commander]: This config is master by default"
        cp $VIM_CONFIGS/vim-$2 $VIM_CONFIGS/vim-master
      fi
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
    echo "    - master [vimrc]      : makes a vimrc master (defaults ~/.vimrc)"
    echo "    - diff [name] [file]  : stores a vimrc patch"
    echo "    - patch [name]        : patches vim-master"
    echo "    - wipe                : clears configs"
    echo ""
    ;;
esac
