FBlack="\[\033[38;5;0m\]"
FRed="\[\033[38;5;9m\]"
FGreen="\[\033[38;5;46m\]"
FYellow="\[\033[38;5;226\]"
FBlue="\[\033[38;5;27m\]"
FMagenta="\[\033[38;5;196m\]"
FCyan="\[\033[38;5;87m\]"
NOH="\[\033[00m\]"

alias ll="ls -lh --color"



_fancy_prompt(){
    GIT_BRANCH_OUTPUT=$(git branch -v 2>&1)
    GIT_STATUS_OUTPUT=$(git status -s -b --ahead-behind 2>&1)
    STATUS_EXIT_VALUE=$?
    PROMPT="$FGreen\u@\h$NOH:$FCyan\w$NOH"

    if [ $STATUS_EXIT_VALUE -ne 0 ]
    then
        export PS1=$PROMPT"$ "
        return
    fi

    PROMPT=$PROMPT"$FBlue[$NOH"

    AHEAD=$(echo "$GIT_BRANCH_OUTPUT" | grep -E "^\*" | grep -ohE "ahead\s[0-9]+")
    AHEAD=${AHEAD:6}
    if [[ $AHEAD ]]
    then
        if [ $AHEAD -gt 0 ]
        then
            PROMPT=$PROMPT"$FCyan$AHEAD$NOH"
        fi
    fi

    BEHIND=$(echo "$GIT_BRANCH_OUTPUT" | grep -E "^\*" | grep -ohE "behind\s[0-9]+")
    BEHIND=${BEHIND:7}
    if [[ $BEHIND ]]
    then
        if [ $BEHIND -gt 0 ]
        then
            PROMPT=$PROMPT"$FRed$BEHIND$NOH"
        fi
    fi

    CURRENT_BRANCH=$(echo "$GIT_BRANCH_OUTPUT" | grep -E "^\*" | cut -d " " -f 2)

    PROMPT=$PROMPT"$FBlue$CURRENT_BRANCH$NOH"

    UNTRACKED=$(echo "$GIT_STATUS_OUTPUT" | grep -E "^\?\?" | wc -l)
    if [ $UNTRACKED -gt 0 ]
    then
        PROMPT=$PROMPT"$FYellow$UNTRACKED$NOH"
    fi

    UNSTAGED=$(echo "$GIT_STATUS_OUTPUT" | grep -E "^(.M|.D|.A)" | wc -l)
    if [ $UNSTAGED -gt 0 ]
    then
        PROMPT=$PROMPT"$FRed$UNSTAGED$NOH"
    fi

    STAGED=$(echo "$GIT_STATUS_OUTPUT" | grep -E "^(M|D|A)" | wc -l)
    if [ $STAGED -gt 0 ]
    then
        PROMPT=$PROMPT"$FGreen$STAGED$NOH"
    fi

	PROMPT=$PROMPT"$FBlue]$NOH"
	export PS1=$PROMPT"$ "
}

export PROMPT_COMMAND="_fancy_prompt"

