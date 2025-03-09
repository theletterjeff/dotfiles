# $HOME/.bashrc: executed by bash(1) for non-login shells.

# load modular variable files
[ -f $HOME/.env_vars ] && . $HOME/.env_vars
[ -f $HOME/.env_vars_secret ] && . $HOME/.env_vars_secret
[ -f $HOME/.bash_aliases ] && . $HOME/.bash_aliases
[ -f $HOME/.path_extensions ] && . $HOME/.path_extensions

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Save bash history after each command
function save_history {
	history -a # apend history to the current file
	history -c # clear the runtime history
	history -r # reload the history file
}
PROMPT_COMMAND='save_history'

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# fzf, autocomplete
[ -f $HOME/.fzf.bash ] && source $HOME/.fzf.bash
[ -f /etc/profile.d/bash_completion.sh ] && source /etc/profile.d/bash_completion.sh

# Ubuntu config
if [ "$(uname)" = "$UBUNTU_UNAME" ]; then

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    export PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $ '

# MacOS config
elif [ "$(uname)" = "$MACOS_UNAME" ]; then

    [ -s $NVM_DIR/nvm.sh ] && . $NVM_DIR/nvm.sh
    [ -s $NVM_DIR/bash_completion ] && . $NVM_DIR/bash_completion

else
    echo "$0: Unrecognized machine; uname $(uname), expected $UBUNTU_UNAME or $MACOS_UNAME"

fi
