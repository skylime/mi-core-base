if [ "$PS1" ]; then
        shopt -s checkwinsize cdspell extglob histappend
        alias ll='ls -lF'
        alias ls='ls --color=auto'
        LC_CTYPE="en_US.UTF-8"
        LC_COLLATE="en_US.UTF-8"
        HISTCONTROL=ignoreboth
        HISTIGNORE="[bf]g:exit:quit"
        PS1="[\u@\H \w]\\$ "
        if [ -n "$SSH_CLIENT" ]; then
                PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME%%\.*} \007" && history -a'
        fi
        export LC_CTYPE LC_COLLATE
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
