LRED='\033[1;31m'
LPURPLE='\033[1;35m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
LGREEN='\033[1;32m'
TURQ='\033[1;36m'
LBLUE='\033[1;34m'
BLUE='\033[0;34m'

NC='\033[0m'

alias ll="ls -lh --color"

git_test(){
    GIT_BRANCH_OUTPUT=$(git branch -v 2>&1)
    GIT_STATUS_OUTPUT=$(git status -s -b --ahead-behind 2>&1)
    if [ $? -ne 0 ]
    then
        return
    fi

    printf "${BLUE}[${NC}"

    AHEAD=$(echo $GIT_BRANCH_OUTPUT | grep -E "^*" | grep -ohE "ahead\s[0-9]+")
    AHEAD=${AHEAD:6}
    if [[ $AHEAD ]]
    then
        if [ $AHEAD -gt 0 ]
        then
            printf "${YELLOW}$AHEAD${NC}"
        fi
    fi

    BEHIND=$(echo $GIT_BRANCH_OUTPUT | grep -E "^*" | grep -ohE "behind\s[0-9]+")
    BEHIND=${BEHIND:7}
    if [[ $BEHIND ]]
    then
        if [ $BEHIND -gt 0 ]
        then
            printf "${LRED}$BEHIND${NC}"
        fi
    fi

    CURRENT_BRANCH_LINE=$(echo $GIT_BRANCH_OUTPUT | grep -E "^*")
    CURRENT_BRANCH=($CURRENT_BRANCH_LINE)
    CURRENT_BRANCH=${CURRENT_BRANCH[1]}

    printf "${BLUE}$CURRENT_BRANCH${NC}"

    UNTRACKED=$(echo "$GIT_STATUS_OUTPUT" | grep -E "^\?\?" | wc -l)
    if [ $UNTRACKED -gt 0 ]
    then
        printf "${LPURPLE}$UNTRACKED${NC}"
    fi

    UNSTAGED=$(echo "$GIT_STATUS_OUTPUT" | grep -E "^(.M|.D|.A)" | wc -l)
    if [ $UNSTAGED -gt 0 ]
    then
        printf "${LRED}$UNSTAGED${NC}"
    fi

    STAGED=$(echo "$GIT_STATUS_OUTPUT" | grep -E "^(M|D|A)" | wc -l)
    if [ $STAGED -gt 0 ]
    then
        printf "${GREEN}$STAGED${NC}"
    fi

	printf "${BLUE}]${NC}"
}


export PS1="${LGREEN}\u@\h${NC}:${LBLUE}\w${NC}\$(git_test)${LGREEN}\$${NC} "

shopt -s checkwinsize
