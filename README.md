# Dotify

Setup your dotfiles like a sane person. With a Dotfile:

```bash
ackrc     -> .ackrc
gitconfig -> .gitconfig
tmux.conf -> .tmux.conf

if [ "$(uname)" == "Darwin" ]; then
  powconfig -> .powconfig
fi
```

Dotfiles are basically fancy bash shell scripts which are executed via Dotify.

## Overview

### Setup

Let's say you've got a git repo somewhere in which you keep your dotfiles.
And lets say that repo looks something like this:

```
.
├── dotify
├── Dotfile
├── hosts
│   └── mordor
│       ├── Dotfile
│       └── gitconfig
├── irbrc
└── tmux.conf
```

The `dotify` file is Dotify's main executable, which is a small self-contained
bash script. It doesn't need to be included in your dotfiles, but it doesn't
hurt.

The `Dotfile` in the root looks like this:

```bash
irbrc     -> .irbrc
tmux.conf -> .tmux.conf

if [ -f "hosts/$(hostname)/Dotfile" ]; then
  include "hosts/$(hostname)"
fi
```

And `hosts/mordor/Dotfile` like this:

```bash
gitconfig -> .gitconfig
```

### Running

Now let's say your machine's hostname is `mordor`, and you've cloned your
dotfiles repo to `~/src/dotfiles`. If you were to cd into your dotfiles and
run `./dotify install`, you'll end up with a home folder like this:

```
.
├── .dotfiles -> /home/jimeh/src/dotfiles
├── .gitconfig -> .dotfiles/gitconfig
├── .irbrc -> .dotfiles/irbrc
├── .tmux.conf -> .dotfiles/tmux.conf
└── src
```
