# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# Path
export PATH="$HOME/.local/bin:$PATH"

# Histroy record setting
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
# setopt SHARE_HISTORY

# Editor
export EDITOR='nvim'
export VISUAL='nvim'

# Alias
alias nv='neovide &disown'

alias ls='eza --icons=always --group-directories-first'
alias ll='eza -la --icons=always --group-directories-first --git'
alias lt='eza --tree --level=2 --icons=always --group-directories-first'
alias la='eza -a --icons=always --group-directories-first'

alias cat='bat'
alias ff='clear && fastfetch'
alias lgit='lazygit'

alias spotify='spotify &disown'
alias discord='discord &> /dev/null &disown'
