RED='\033[0;31m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
LBLUE='\033[1;34m'
NC='\033[0m'


git_part(){
	GIT_STATUS_OUTPUT=$(git status 2>&1)
	if [ "${GIT_STATUS_OUTPUT:7:20}" != "Not a git repository" ]
	then
		GIT_BRANCH=$(git branch | grep -E "^\*")
		GIT_BRANCH=${GIT_BRANCH:2}
		STAGED=$(git status -s | grep -E "^(M|D)" | wc -l)
                UNSTAGED=$(git status -s | grep -E "^( M| D)" | wc -l)
		UNTRACKED=$(git status -s | grep -E "^\?\?" | wc -l)
		COUNTS=""
		if [ $UNTRACKED -gt 0 ]
		then
			COUNTS=":$UNTRACKED"
		fi
		if [ $UNSTAGED -gt 0 ]
		then
			COUNTS="$COUNTS:$UNSTAGED"
		fi
		if [ $STAGED -gt 0 ]
		then
			COUNTS="$COUNTS:$STAGED"
		fi
		echo "[$GIT_BRANCH$COUNTS]"
	fi
}

export PS1="${LBLUE}\u@\h${NC}:\w\$(git_part)\$ "

