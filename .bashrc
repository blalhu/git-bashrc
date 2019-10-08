COLOR_USER_HOST="\[\033[38;5;40m\]"
COLOR_PATH="\[\033[38;5;26m\]"
COLOR_GIT_BASE="\[\033[38;5;39m\]"
COLOR_BRANCH_AHEAD="\[\033[38;5;200m\]"
COLOR_BRANCH_BEHIND="\[\033[38;5;196m\]"
COLOR_FILE_UNTRACKED="\[\033[38;5;226m\]"
COLOR_FILE_UNSTAGED="\[\033[38;5;9m\]"
COLOR_FILE_STAGED="\[\033[38;5;40m\]"
COLOR_UNSTAGED="\[\033[38;5;9m\]"
COLOR_NO="\[\033[00m\]"

alias ll="ls -lh --color"



_fancy_prompt(){
    GIT_BRANCH_OUTPUT=$(git branch -v 2>&1)
    GIT_STATUS_OUTPUT=$(git status -s -b --ahead-behind 2>&1)
    STATUS_EXIT_VALUE=$?
    PROMPT="$COLOR_USER_HOST\u@\h$COLOR_NO:$COLOR_PATH\w$COLOR_NO"

    if [ $STATUS_EXIT_VALUE -ne 0 ]
    then
        export PS1=$PROMPT"$ "
        return
    fi

    PROMPT=$PROMPT"$COLOR_GIT_BASE[$COLOR_NO"

    AHEAD=$(echo "$GIT_BRANCH_OUTPUT" | grep -E "^\*" | grep -ohE "ahead\s[0-9]+")
    AHEAD=${AHEAD:6}
    if [[ $AHEAD ]]
    then
        if [ $AHEAD -gt 0 ]
        then
            PROMPT=$PROMPT"$COLOR_BRANCH_AHEAD$AHEAD$COLOR_NO"
        fi
    fi

    BEHIND=$(echo "$GIT_BRANCH_OUTPUT" | grep -E "^\*" | grep -ohE "behind\s[0-9]+")
    BEHIND=${BEHIND:7}
    if [[ $BEHIND ]]
    then
        if [ $BEHIND -gt 0 ]
        then
            PROMPT=$PROMPT"$COLOR_BRANCH_BEHIND$BEHIND$COLOR_NO"
        fi
    fi

    CURRENT_BRANCH=$(echo "$GIT_BRANCH_OUTPUT" | grep -E "^\*" | cut -d " " -f 2)

    PROMPT=$PROMPT"$COLOR_GIT_BASE$CURRENT_BRANCH$COLOR_NO"

    UNTRACKED=$(echo "$GIT_STATUS_OUTPUT" | grep -E "^\?\?" | wc -l)
    if [ $UNTRACKED -gt 0 ]
    then
        PROMPT=$PROMPT"$COLOR_FILE_UNTRACKED$UNTRACKED$COLOR_NO"
    fi

    UNSTAGED=$(echo "$GIT_STATUS_OUTPUT" | grep -E "^(.M|.D|.A)" | wc -l)
    if [ $UNSTAGED -gt 0 ]
    then
        PROMPT=$PROMPT"$COLOR_FILE_UNSTAGED$UNSTAGED$COLOR_NO"
    fi

    STAGED=$(echo "$GIT_STATUS_OUTPUT" | grep -E "^(M|D|A)" | wc -l)
    if [ $STAGED -gt 0 ]
    then
        PROMPT=$PROMPT"$COLOR_FILE_STAGED$STAGED$COLOR_NO"
    fi

	PROMPT=$PROMPT"$COLOR_GIT_BASE]$COLOR_NO"
	export PS1=$PROMPT"$ "
}

export PROMPT_COMMAND="_fancy_prompt"

