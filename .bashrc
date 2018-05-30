RED='\033[0;31m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
LGREEN='\033[1;32m'
TURQ='\033[0;36m'
LBLUE='\033[1;34m'

NC='\033[0m'

alias ll="ls -lh --color"

git_part(){
	GIT_STATUS_OUTPUT=$(git status 2>&1)
	if [ "${GIT_STATUS_OUTPUT:7:20}" != "Not a git repository" ]
	then
		GIT_BRANCH=$(git branch | grep -E "^\*")
		GIT_BRANCH=${GIT_BRANCH:2}
		STAGED=$(git status -s | grep -E "^(M|D)" | wc -l)
                UNSTAGED=$(git status -s | grep -E "^( M| D)" | wc -l)
		UNTRACKED=$(git status -s | grep -E "^\?\?" | wc -l)
		printf "["
		printf $GIT_BRANCH
		if [ $UNTRACKED -gt 0 ]
		then
			printf "!$UNTRACKED"
		fi
		if [ $UNSTAGED -gt 0 ]
		then
			printf "U$UNSTAGED"
		fi
		if [ $STAGED -gt 0 ]
		then
			printf "S$STAGED"
		fi
		printf "]\n"
	fi
}

export PS1="\[${LGREEN}\]\u@\h\[${NC}\]:\[${LBLUE}\]\w\[${NC}\]\$(git_part)\$ "

shopt -s checkwinsize
