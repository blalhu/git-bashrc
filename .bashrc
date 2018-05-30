RED='\[\033[0;31m\]'
PURPLE='\[\033[0;35m\]'
YELLOW='\[\033[1;33m\]'
GREEN='\[\033[0;32m\]'
LGREEN='\[\033[1;32m\]'
TURQ='\[\033[0;36m\]'
LBLUE='\[\033[1;34m\]'

NC='\[\033[0m\]'

alias ll="ls -lh --color"

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
		UNSTAGED=$(git status -s | grep -E "^( M| D)" | wc -l)
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
		STAGED=$(git status -s | grep -E "^(M|D)" | wc -l)
		if [ $STAGED -gt 0 ]
		then
			printf "$STAGED"
		fi
	fi
}


export PS1="${LGREEN}\u@\h${NC}:${LBLUE}\w${NC}[\$(git_branch)${RED}\$(git_untracked)${NC}${PURPLE}\$(git_unstaged)${NC}${YELLOW}\$(git_staged)${NC}] \$ "

shopt -s checkwinsize
