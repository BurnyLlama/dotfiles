# BurnyLlama's dotfiles

These are my dotfiles. I keep them here mostly as a backup for myself, but feel free to look around if you wish!

## Restoring the dotfiles

To restore the dotfiels run the following:

```sh
mkdir -p $HOME/.local/dotfiles
git clone --bare https://github.com/BurnyLlama/dotfiles --git-dir=$HOME/.local/dotfiles --work-tree=$HOME
```
