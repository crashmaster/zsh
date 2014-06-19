typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# When directory is changed set term title to host:dir
update_terminal_title() {
    [[ -t 1 ]] || return
    case $TERM in
        sun-cmd) print -Pn "\e]l%~\e\\";;
        *xterm*|*rxvt*|(dt|k|E)term) print -Pn "\e]2;%m:%~\a";;
    esac
}

precmd_update_terminal_title() {
    update_terminal_title
}

precmd_functions+="precmd_update_terminal_title"

chpwd_update_terminal_title() {
    update_terminal_title
}

chpwd_functions+="chpwd_update_terminal_title"

typeset -g ACTIVE_VIRTUAL_ENV=""
typeset -gA DIR_TO_VIRTUAL_ENV

chpwd_python_virtual_env_handler() {
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
}

chpwd_functions+="chpwd_python_virtual_env_handler"
