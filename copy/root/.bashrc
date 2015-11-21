if [ "$PS1" ]; then
        shopt -s checkwinsize cdspell extglob histappend
        alias ll='ls -lF'
        alias ls='ls --color=auto'
        HISTCONTROL=ignoreboth
        HISTIGNORE="[bf]g:exit:quit"
        PS1="[\u@\H \w]\\$ "
        if [ -n "$SSH_CLIENT" ]; then
                PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%\.*} \007" && history -a'
        fi
fi

# bash svc log functions
svclog() {
        if [[ -z "$PAGER" ]]; then
                PAGER=less
        fi
        $PAGER `svcs -L $1`
}

svclogf() {
        /usr/bin/tail -f `svcs -L $1`
}
