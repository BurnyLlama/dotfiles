# BurnyLlama's dotfiles

These are my dotfiles. I keep them here mostly as a backup for myself, but feel free to look around if you wish!

## Restoring (or installing) the dotfiles

To restore the dotfiels run the following:

```sh
mkdir -p $HOME/.local/dotfiles
git clone --bare https://github.com/BurnyLlama/dotfiles $HOME/.local/dotfiles
git --git-dir=$HOME/.local/dotfiles --work-tree=$HOME checkout
git --git-dir=$HOME/.local/dotfiles --work-tree=$HOME submodule update --init --recursive
```

See https://www.atlassian.com/git/tutorials/dotfiles for more information, including ways to deal with errors if this would overwrite any of your existing files.

## dotfilectl

My dotfiles come with a script called `dotfilectl`, it can be used to check for dependencies (`dotfilectl check-dependencies`), check for updates (`dotfilectl sync-status`), and update the dotfiles (`dotfilectl update`).
