# dotfiles
My personal dotfiles when using tmux and nvim. The following instructions are
meant for my own future reference later if I forget what should be done when
setting up a new environment.

## Commands that should be run upon fresh clone
First, after installing tmux and neovim (currently using v10.4), `tpm` should
be cloned.
```bash
git clone https://github.com/tmux-plugins/tpm ~/dotfiles/tmux/plugins/tpm
```

I've downloaded the tmux-sessionizer -script from ThePrimeagen from [here](https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer)
and edited the directory structure and find depth to a way that suits me
and my environment best currently.

Once `tpm` is cloned you should next run the following commands to setup symlinks
from the dotfiles -directory. The links will point toward `~/.config/tmux` and
`~/.config/nvim`, and that's where they should typically be at. Also make sure
tmux-sessionizer has x rights.

```bash
ln -sf ~/dotfiles/nvim   ~/.config/nvim
ln -sf ~/dotfiles/tmux   ~/.config/tmux
ln -sf ~/dotfiles/bin/tmux-sessionizer ~/.local/bin/tmux-sessionizer
ln -sf ~/dotfiles/bin/toggleps ~/.local/bin/toggleps
ln -sf ~/dotfiles/bin/upgradeGo ~/.local/bin/upgradeGo
```

Open tmux and run `<C-a> I` to install plugins.

And that's it! Fastest way to find out if everything works is to open up tmux and nvim
and do C-f and see if it works by bringing up the find menu with tmux-sessionizer.

## Updating Neovim
Short steps to updating Neovim to a newer version
1. https://github.com/neovim/neovim/releases/latest
2. download tarball
3. untar -> tar xvzf nvimtarball
4. mkdir -p ~/.local/nvim
5. cp -r nvimtarball/* ~/.local/nvim

Add these into `.bashrc/.zshrc` if not there already
```bash
export PATH="$HOME/.local/nvim/bin:$PATH"
alias vim=nvim
```
