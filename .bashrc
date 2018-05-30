LRED='\[\033[1;31m\]'
LPURPLE='\[\033[1;35m\]'
YELLOW='\[\033[1;33m\]'
GREEN='\[\033[0;32m\]'
LGREEN='\[\033[1;32m\]'
TURQ='\[\033[1;36m\]'
LBLUE='\[\033[1;34m\]'
BLUE='\[\033[0;34m\]'

NC='\[\033[0m\]'

alias ll="ls -lh --color"

git_ahead(){
        GIT_STATUS_OUTPUT=$(git status 2>&1)
	if [ "${GIT_STATUS_OUTPUT:7:20}" != "Not a git repository" ]
	then
		AHEAD=$(git branch -v | grep -E "^*" | grep -ohE "ahead\s[0-9]+")
		AHEAD=${AHEAD:6}
		if [[ $AHEAD ]]
		then
			if [ $AHEAD -gt 0 ]
			then
				printf "$AHEAD"
			fi
		fi
	fi
}


git_behind(){
        GIT_STATUS_OUTPUT=$(git status 2>&1)
	if [ "${GIT_STATUS_OUTPUT:7:20}" != "Not a git repository" ]
	then
		BEHIND=$(git branch -v | grep -E "^*" | grep -ohE "behind\s[0-9]+")
		BEHIND=${BEHIND:7}
		echo $BEHIND
		if [[ $BEHIND ]]
		then
			if [ $BEHIND -gt 0 ]
			then
				printf "$BEHIND"
			fi
		fi
	fi
}

git_branch(){
	GIT_STATUS_OUTPUT=$(git status 2>&1)
	if [ "${GIT_STATUS_OUTPUT:7:20}" != "Not a git repository" ]
	then
		GIT_BRANCH=$(git branch | grep -E "^\*")
		GIT_BRANCH=${GIT_BRANCH:2}
		printf $GIT_BRANCH
	fi
}

git_untracked(){
	GIT_STATUS_OUTPUT=$(git status 2>&1)
	if [ "${GIT_STATUS_OUTPUT:7:20}" != "Not a git repository" ]
	then
		UNTRACKED=$(git status -s | grep -E "^\?\?" | wc -l)
		if [ $UNTRACKED -gt 0 ]
		then
			printf "$UNTRACKED"
		fi
	fi
}


git_unstaged(){
	GIT_STATUS_OUTPUT=$(git status 2>&1)
	if [ "${GIT_STATUS_OUTPUT:7:20}" != "Not a git repository" ]
	then
		UNSTAGED=$(git status -s | grep -E "^( M| D| A)" | wc -l)
		if [ $UNSTAGED -gt 0 ]
		then
			printf "$UNSTAGED"
		fi
	fi
}


git_staged(){
	GIT_STATUS_OUTPUT=$(git status 2>&1)
	if [ "${GIT_STATUS_OUTPUT:7:20}" != "Not a git repository" ]
	then
		STAGED=$(git status -s | grep -E "^(M|D|A)" | wc -l)
		if [ $STAGED -gt 0 ]
		then
			printf "$STAGED"
		fi
	fi
}


export PS1="${LGREEN}\u@\h${NC}:${LBLUE}\w${NC}${BLUE}[${NC}${TURQ}\$(git_ahead)${NC}${LRED}\$(git_behind)${NC}${BLUE}\$(git_branch)${NC}${LRED}\$(git_untracked)${NC}${LPURPLE}\$(git_unstaged)${NC}${YELLOW}\$(git_staged)${NC}${BLUE}]${NC}\$ "

shopt -s checkwinsize
