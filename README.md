# Vim Commander

This simple shell script solves the problem for having to swap out vim configs
on the fly.

## Install

__Root__:

```
sudo mv vim-commander.sh /usr/bin/vim-commander
```

__Regular User__:

```
chmod +x install.sh; ./install.sh
```

## Usage

```
vim-commander [command] [arg]*
   commands:
    - install name [vimrc]: installs a vimrc (defaults ~/.vimrc)
    - list                : lists installed vimrc's
    - remove name         : removes installed vimrc
    - use name            : switches vimrc's
```
