FBlack="\\[$(tput setaf 0)\\]"
FRed="\\[$(tput setaf 1)\\]"
FGreen="\\[$(tput setaf 2)\\]"
FYellow="\\[$(tput setaf 3)\\]"
FBlue="\\[$(tput setaf 4)\\]"
FMagenta="\\[$(tput setaf 5)\\]"
FCyan="\\[$(tput setaf 6)\\]"
FWhite="\\[$(tput setaf 7)\\]"

NOH="\\[$(tput sgr0)\\]"

NC='\033[0m'

alias ll="ls -lh --color"

git_test(){
    GIT_BRANCH_OUTPUT=$(git branch -v 2>&1)
    GIT_STATUS_OUTPUT=$(git status -s -b --ahead-behind 2>&1)
    if [ $? -ne 0 ]
    then
        return
    fi

    printf "["

    AHEAD=$(echo "$GIT_BRANCH_OUTPUT" | grep -E "^\*" | grep -ohE "ahead\s[0-9]+")
    AHEAD=${AHEAD:6}
    if [[ $AHEAD ]]
    then
        if [ $AHEAD -gt 0 ]
        then
            printf "A$AHEAD "
        fi
    fi

    BEHIND=$(echo "$GIT_BRANCH_OUTPUT" | grep -E "^\*" | grep -ohE "behind\s[0-9]+")
    BEHIND=${BEHIND:7}
    if [[ $BEHIND ]]
    then
        if [ $BEHIND -gt 0 ]
        then
            printf "B$BEHIND "
        fi
    fi

    CURRENT_BRANCH=$(echo "$GIT_BRANCH_OUTPUT" | grep -E "^\*" | cut -d " " -f 2)

    printf "$CURRENT_BRANCH"

    UNTRACKED=$(echo "$GIT_STATUS_OUTPUT" | grep -E "^\?\?" | wc -l)
    if [ $UNTRACKED -gt 0 ]
    then
        printf " ?$UNTRACKED"
    fi

    UNSTAGED=$(echo "$GIT_STATUS_OUTPUT" | grep -E "^(.M|.D|.A)" | wc -l)
    if [ $UNSTAGED -gt 0 ]
    then
        printf " U$UNSTAGED"
    fi

    STAGED=$(echo "$GIT_STATUS_OUTPUT" | grep -E "^(M|D|A)" | wc -l)
    if [ $STAGED -gt 0 ]
    then
        printf " S$STAGED"
    fi

	printf "]"
}

export PS1="$FGreen\u@\h$NOH:$FCyan\w$NOH$FBlue\$(git_test)$NOH\$ "

