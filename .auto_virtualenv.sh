#!/usr/bin/env bash
# --- activate a virtualenv without the need of going through a series of
#     paths
function venv { source ${WORKON_HOME}/$1/bin/activate; }

# --- create a virtualenv
function mkenv { virtualenv ${WORKON_HOME}/$1; venv $1; echo "$1" > ./.venv; }

# --- automagically load virtualenvs, based on the ".venv" file in the directory

# -- search for the ".venv" from the current directory and, if it can't be found,
#    go through the parent directories all the way to the system root
function _upwards_search {
	venv=""
	curdir=`pwd`

	while [[ `pwd` != '/' ]]; do
		if [ -f ./.venv ]; then
			venv=`cat ./.venv`
            echo $venv
			break
		fi
		cd ..
	done

	cd $curdir
}

function workon_cwd {
    # Check that this is a Git repo
    GIT_DIR=`git rev-parse --git-dir 2> /dev/null`
    if [ $? == 0 ]; then
        # Find the repo root and check for virtualenv name override
        GIT_DIR=`\cd $GIT_DIR; pwd`
        PROJECT_ROOT=`dirname "$GIT_DIR"`
        ENV_NAME=`basename "$PROJECT_ROOT"`
        if [ -f "$PROJECT_ROOT/.venv" ]; then
            ENV_NAME=`cat "$PROJECT_ROOT/.venv"`
        fi
        # Activate the environment only if it is not already active
        if [ ${VIRTUAL_ENV} != "${WORKON_HOME}/$ENV_NAME" ]; then
            if [ -e "${WORKON_HOME}/$ENV_NAME/bin/activate" ]; then
                workon "$ENV_NAME" && export CD_VIRTUAL_ENV="$ENV_NAME"
            fi
        fi
    else
        ENV_NAME=$(_upwards_search)
        if [ -e "${WORKON_HOME}/$ENV_NAME/bin/activate" ]; then
            workon "$ENV_NAME" && export CD_VIRTUAL_ENV="$ENV_NAME"
        elif [ $CD_VIRTUAL_ENV ]; then
            deactivate && unset CD_VIRTUAL_ENV
        fi
        # We've just left the repo, deactivate the environment
        # Note: this only happens if the virtualenv was activated automatically
        #deactivate && unset CD_VIRTUAL_ENV
    fi
}


# -- replacement for "cd", which will check the virtualenv file
function _venv_cd { 
	#if [ ! -f $PWD/$1 -a "${VIRTUAL_ENV}." != "."  ]; then 
    #	deactivate
	#fi;
	cd "$@" && workon_cwd
}

# -- replace "cd" with our magical "cd"
alias cd=_venv_cd
