# ls
alias ll='ls -la'
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

# dotfile config repo
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# toggl
alias toggl-b='toggl start Break -o Break'
alias toggl-cr='toggl start "Code Review" -o "Code Review"'
alias toggl-su='toggl start "Stand Up" -o Meetings'
alias toggl-l='toggl start Lunch -o Break'
alias toggl-i='toggl start "Inbox Maintenance" -o "Inbox Maintenance"'
alias toggl-c='toggl start Chores -o Break'
alias toggl-p='toggl start Parenting -o Break'
alias toggl-demos='toggl start Demos -o Meetings'
alias toggl-ls='toggl ls | awk -F '\''  +'\'' '\''{print $1}'\'' | sort | uniq'
alias toggl-v='toggl start Vim -o "Dev Env"'
alias toggl-e='toggl start Errand -o Break'
toggl-t ()
{
    toggl start "$1" -o Ticket
}

# chat gpt
alias gpt='chatgpt-cli --model=gpt-3.5-turbo'
alias gpt-4='chatgpt-cli --model=gpt-4o --multiline'
gpt-c ()
{
    chatgpt-cli --context="$1"
}

# ubuntu config
if [ "$(uname)" == "$UBUNTU_UNAME" ]; then

    # postgres
    alias psql-stop='sudo systemctl stop postgresql'
    alias psql-start='sudo service postgresql start'

    # docker
    alias dc-up-d="$DC_DIR/dc up -d"
    alias dc-up="$DC_DIR/dc up"
    alias dc-down="$DC_DIR/dc down"
    alias dc-up-filter="clear && dc-up | awk '/vistar_trafficking/ || \
        /vistar_geo_rest/ { gsub(/vistar_trafficking/, \"\033[31m&\033[39m\"); \
        gsub(/vistar_geo_rest/, \"\033[34m&\033[39m\"); print }'"

    # vistar DBs
    alias psql-geo='psql -h localhost -p 5432 -U vistar geo'
    alias psql-traf='psql -h localhost -p 5432 -U vistar api-development'
    alias psql-dmp='psql -h localhost -p 5432 -U vistar dmp'

    # db refreshes
    alias db-ref-traf="$DC_DIR/dc-run trafficking /db-refresh && \
        $DC_DIR/dc-run trafficking /db-refresh-change-history"
    alias db-ref-inv="$DC_DIR/dc-run inventory_api /db-refresh && \
        $DC_DIR/dc-run inventory_api /db-refresh-creative"
    alias db-ref-geo="$DC_DIR/dc-run trafficking /db-refresh-geo"
    alias db-ref-full="db-ref-traf && db-ref-inv && db-ref-geo"

    # codebase
    alias dewr="$VISTAR_DIR/tools/dewr/dewr.sh sh"

	# job svc (called in dewr)
	alias job-svc="bazel run //svc/behavioral/job/server/deploy:http-server-cmd \
		-- -c $PWD/local.json"

    # copies to clipboard so that i can paste & inspect without it showing up
    # in my bash history
    copy_ssm_value() {
        AWS_PROFILE=AdEngineerProduction aws ssm get-parameter \
            --name $1 \
            --with-decryption \
            --query Parameter.Value \
            --output text \
            | xclip -selection clipboard
    }

    # github
    # add reviewers to a PR. run this after pushing the PR. takes the PR
    # number as an argument
    add_github_reviewers() {
        gh pr edit $1 \
            --add-reviewer vistar-jadams \
            --add-reviewer dmansen \
            --add-reviewer vistar-klevin \
            --add-reviewer neskandary-vistar \
            --add-reviewer nick-vistar
    }
    alias gh-rev=add_github_reviewers

    # reset DNS
    alias cloudflare-dns="resolvectl dns wlp0s20f3 1.1.1.1 1.0.0.1"

# macos config
elif [ "$(uname)" == "$MACOS_UNAME" ]; then
    :

else
    echo "Unrecognized machine; uname $(uname), expected $UBUNTU_UNAME or $MACOS_UNAME"

fi
