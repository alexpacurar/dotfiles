#!/usr/bine/env bash

function check_line () {
    # Test if the line number is an integer and that the file is that long
    [[ "$1" =~ [0-9]+$ ]] && [ "`cat $2 | wc -l`" -ge "$1" ] || return 1
}

function sort_array () {
    # Reverse soring the arguments to avoid stepping on our feet when deleting from the file
    echo "$(
        for element in $@
        do
            echo ${element}
        done | sort -nr)"
}

function clear_known_hosts () {
    local known_hosts="${HOME}/.ssh/known_hosts"
    for line in $(sort_array $@)
    do
        if check_line ${line} ${known_hosts}
        then 
            sed -ri "${1}d" ${known_hosts}
            echo "Removed line ${line} from ${known_hosts}" 
        else
            echo "Line ${line} not valid"
            return 1
        fi
    done
}

alias clkh='clear_known_hosts $@'
