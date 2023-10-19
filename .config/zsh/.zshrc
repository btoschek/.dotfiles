export EDITOR='nvim'
export TERMINAL='kitty'
export BROWSER='firefox'

# XDG paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

alias ls='exa --icons -l'       # Improved ls written in Rust
alias vim='nvim'                # Shorter keymap for Neovim

GPG_TTY=$(tty)
export GPG_TTY

# Dotfile management
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias lg='lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# =======================================================================
#  Prompt settings
# =======================================================================

# Enable branches to be displayed in the prompt
autoload -Uz vcs_info
precmd () { vcs_info }

zstyle ':vcs_info:git:*' formats '(%F{green} %b%f) '

setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f ${vcs_info_msg_0_}$ '

# =======================================================================
#  Useful features
# =======================================================================

# Command completion
autoload -Uz compinit
compinit

# Automatically cd
setopt autocd

# TODO: Find out what these do
setopt extendedglob nomatch menucomplete
setopt interactive_comments

stty stop undef

zle_highlight=('paste:none')

unsetopt BEEP
