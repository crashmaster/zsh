typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Update terminal title {{{
# When directory is changed set term title to host:dir
update_terminal_title() {
    [[ -t 1 ]] || return
    case $TERM in
        sun-cmd) print -Pn "\e]l%~\e\\";;
        *xterm*|*rxvt*|(dt|k|E)term) print -Pn "\e]2;%m:%~\a";;
    esac

    precmd_functions=(${precmd_functions##update_terminal_title})
}

precmd_functions+="update_terminal_title"
chpwd_functions+="update_terminal_title"
# }}}

# Handle PYTHONPATH settings {{{
typeset -gA DIR_TO_PYTHONPATH

# Example:
#   cat .zsh/config/misc.site.zsh
#   DIR_TO_PYTHONPATH+=(
#       "/home/user/work/project" "./project/common:./project/server:./project/cli"
#   )

pythonpath_handler() {
    [[ ${#DIR_TO_PYTHONPATH} -eq 0 ]] && {
        return
    }

    local pythonpath_for_pwd=""
    for k in ${(@k)DIR_TO_PYTHONPATH}
    do
        pythonpath_for_pwd=${(M)${PWD}##${k}}
        [[ -n "${pythonpath_for_pwd}" ]] && break
    done

    [[ -n "${pythonpath_for_pwd}" ]] && {
        export PYTHONPATH="${DIR_TO_PYTHONPATH[${pythonpath_for_pwd}]}"
    } || {
        unset PYTHONPATH
    }

    precmd_functions=(${precmd_functions##pythonpath_handler})
}

precmd_functions+="pythonpath_handler"
chpwd_functions+="pythonpath_handler"
# }}}

# Handle Python virtual environments {{{
typeset -g ACTIVE_VIRTUAL_ENV=""
typeset -gA DIR_TO_VIRTUAL_ENV

# Example:
#   cat .zsh/config/misc.site.zsh
#   DIR_TO_VIRTUAL_ENV+=(
#       "/home/user/work/project" "/home/user/tmp/virtual_envs/project"
#   )

python_virtual_env_handler() {
    [[ ${#DIR_TO_VIRTUAL_ENV} -eq 0 ]] && {
        return
    }

    local virtual_env_for_pwd=""
    for k in ${(@k)DIR_TO_VIRTUAL_ENV}
    do
        virtual_env_for_pwd=${(M)${PWD}##${k}}
        [[ -n "${virtual_env_for_pwd}" ]] && break
    done

    [[ -n "${virtual_env_for_pwd}" ]] && {
        [[ -n "${ACTIVE_VIRTUAL_ENV}" && \
           "${virtual_env_for_pwd}" != "${ACTIVE_VIRTUAL_ENV}" ]] && {
            . ${DIR_TO_VIRTUAL_ENV[${virtual_env_for_pwd}]}/bin/activate
            ACTIVE_VIRTUAL_ENV="${virtual_env_for_pwd}"
            return
        }
        [[ -z ${ACTIVE_VIRTUAL_ENV} ]] && {
            . ${DIR_TO_VIRTUAL_ENV[${virtual_env_for_pwd}]}/bin/activate
            ACTIVE_VIRTUAL_ENV="${virtual_env_for_pwd}"
            return
        }
    }

    [[ -z "${virtual_env_for_pwd}" && -n ${ACTIVE_VIRTUAL_ENV} ]] && {
        deactivate
        ACTIVE_VIRTUAL_ENV=""
        return
    }

    precmd_functions=(${precmd_functions##python_virtual_env_handler})
}

precmd_functions+="python_virtual_env_handler"
chpwd_functions+="python_virtual_env_handler"
# }}}

# Handle Git repository configurations {{{
typeset -g ACTIVE_GIT_REPO=""
typeset -gA CONFIG_FOR_GIT_REPO

# Example:
#   cat .zsh/config/misc.site.zsh
#   CONFIG_FOR_GIT_REPO+=(
#       "/home/user/git/moo" "user.email='foo.bar@boo.com' user.name='Foo Bar'"
#   )
#   NOTE: formatting is very important, user "-s and '-s as above.

git_repository_config_handler() {
    local cwd=$(readlink -e ${PWD})
    local repo_to_reconf=""
    for k in ${(@k)CONFIG_FOR_GIT_REPO}
    do
        repo_to_reconf=${(M)${cwd}##${k}}
        [[ -n "${repo_to_reconf}" ]] && break
    done

    [[ -n "${repo_to_reconf}" ]] && {
        [[ "${repo_to_reconf}" == "${ACTIVE_GIT_REPO}" ]] && {
            return
        }
        [[ -d "${repo_to_reconf}" ]] && {
            for i in ${CONFIG_FOR_GIT_REPO[${repo_to_reconf}]}
            do
                for j in ${${${(s:+:)${i//\' /+}}//\'/}}
                do
                    local option="${${(s:=:)j}[1]}"
                    local actual="$(git config --get ${option})"
                    local expected="${${(s:=:)j}[2]}"
                    [[ -z "${expected}" ]] && {
                        print "Invalid configuration for: ${repo_to_reconf}"
                        return
                    }
                    [[ "${expected}" != "${actual}" ]] && {
                        git config --local ${option} ${expected}
                    }
                done
            done
            ACTIVE_GIT_REPO=${repo_to_reconf}
        }
    }
    [[ -z "${repo_to_reconf}" && -n ${ACTIVE_GIT_REPO} ]] && {
        ACTIVE_GIT_REPO=""
        return
    }
}

chpwd_functions+="git_repository_config_handler"
# }}}

# Execution time of the last (full) command line {{{
set_timer() {
    TIMER=${TIMER:-${SECONDS}}
}

preexec_functions+="set_timer"

update_timer() {
    [ ${TIMER} ] && {
        timer_show=$((${SECONDS} - ${TIMER}))
        FORMATTED_TIME=$(date --utc --date="@${timer_show}" +"%H:%M:%S")
        unset TIMER
    }
}

precmd_functions+="update_timer"
# }}}

# vim:fdm=marker
