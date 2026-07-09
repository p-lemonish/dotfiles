# ==========================
# EXPORTS START
# ==========================

export EDITOR=nvim
export VISUAL=nvim
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/sbin
export PATH="$HOME/.local/nvim/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"

# ==========================
# EXPORTS END
# ==========================
#
# ==========================
# ALIASES START
# ==========================

alias python="/usr/bin/python3"
alias vim=nvim
alias f='cd "$(fd --type d -I \
  --exclude node_modules \
  --exclude Android \
  --exclude pt \
  --exclude go \
  --exclude snap \
  "" \
  ~/dotfiles \
  ~/ctfs \
  ~/htb \
  ~/Documents/proggis \
  ~/Documents/project \
  ~/Documents/notes \
  2>/dev/null \
  | fzf)"'
alias oc=opencode
alias thetime='date +"%Y-%m-%d_w%V_%H:%M:%S"'
alias theweek='date +"w%V"'
alias binja="$HOME/Documents/binja/binaryninja/binaryninja > /dev/null 2>&1 & disown"
alias vlist='virsh -c qemu:///system list --all'
alias vstart='virsh -c qemu:///system start'
alias vsave='virsh -c qemu:///system managedsave'

# ==========================
# ALIASES END
# ==========================

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="sunaku"
ZSH_THEME="lemonish"

HIST_STAMPS="yyyy-mm-dd"
export HISTSIZE=100000000
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.zsh_history"
setopt APPEND_HISTORY
setopt SHARE_HISTORY

plugins=(git zsh-autosuggestions zsh-syntax-highlighting shrink-path)
source $ZSH/oh-my-zsh.sh
setopt prompt_subst

export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

# fzf default key bindings
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


export PATH="$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"

. "$HOME/.local/bin/env"

# Lazyload nvm due to slow shell startup
export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  nvm "$@"
}
node() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  node "$@"
}
npm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  npm "$@"
}
npx() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  npx "$@"
}
