export EDITOR='nvim'
export TERMINAL='kitty'
export BROWSER='firefox'

# XDG paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# NOTE: Is this a good idea to export this here?
export TMPDIR=/tmp

alias ls='exa --icons -l'       # Improved ls written in Rust
alias vim='nvim'                # Shorter keymap for Neovim

GPG_TTY=$(tty)
export GPG_TTY

# Dotfile management
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias lg='lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# =======================================================================
#  NNN
# =======================================================================

export NNN_OPTS='dEio'
export NNN_BMS="c:$HOME/.config;d:$HOME/Downloads;m:$HOME/Music;p:$HOME/Pictures;v:$HOME/Videos"
export NNN_FIFO="$TMPDIR/nnn.fifo"
export NNN_PLUG='c:chksum;p:preview-tui;g:gpge;w:btwallpaper'

# Taken from: https://github.com/jarun/nnn/wiki/Themes#nord
# TODO: Actually switch to tokyonight
BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

# Open nnn instance with cd on quit
n () {

  if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
    echo "nnn is already running"
    return
  fi

  export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

  # Run actual command, clean up additional kitty window afterwards
  command nnn -Pp; kitty @ close-window -m 'title:preview-tui'

  if [ -f "$NNN_TMPFILE" ]; then
    . "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE" > /dev/null
  fi
}

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
