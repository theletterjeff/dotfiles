# ls
alias ll='ls -alF'
alias la='la -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# basic vim invocation
alias vim='nvim'
alias vim-config="vim $HOME/.config/nvim/init.vim"

# dotfile config repo
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# toggl
alias toggl-break='toggl start Break -o Break'
alias toggl-su='toggl start "Stand Up" -o Meetings'
alias toggl-lunch='toggl start Lunch -o Break'
alias toggl-inbox='toggl start "Inbox Maintenance" -o "Inbox Maintenance"'
alias toggl-chores='toggl start Chores -o Break'
alias toggl-parent='toggl start Parenting -o Break'
alias toggl-demos='toggl start Demos -o Meetings'

# Pass in the ticket name
toggl-t ()
{
    toggl start "$1" -o Ticket
}

# ubuntu config
if [ "$(uname)" == "$UBUNTU_UNAME" ]; then

    # databases
    alias psql-stop='sudo systemctl stop postgresql'
    alias psql-start='sudo service postgresql start'
    alias dc-up-d="$HOME/docker-compose/dc up -d"
    alias dc-up="$HOME/docker-compose/dc up"
    alias dc-down="$HOME/docker-compose/dc down"
    alias psql-geo='psql -h localhost -p 5432 -U vistar geo'
    alias psql-traf='psql -h localhost -p 5432 -U vistar api-development'
    alias psql-dmp='psql -h localhost -p 5432 -U vistar production'
    
    # codebase
    alias dewr="$HOME/tools/dewr/dewr.sh sh"

# macos config
elif [ "$(uname)" == "$MACOS_UNAME" ]; then
    :

else
    echo "Unrecognized machine; uname $(uname), expected $UBUNTU_UNAME or $MACOS_UNAME"

fi
