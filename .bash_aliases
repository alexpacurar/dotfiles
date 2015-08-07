#!/usr/bine/env bash

function check_line () {
    [ "`cat $2 | wc -l`" -gt "$1" ]
}

function clear_line () {
    local known_hosts="${HOME}/.ssh/known_hosts"
    local line_no="$1"
    if check_line ${line_no} ${known_hosts}
    then
        sed -ri "${line_no}d" ${known_hosts}
    else
        echo "Line does not exist"
    fi
}

function clear_known_hosts () {
    if [ $# -eq 1 ]
    then
        clear_line $1
    else
        echo "Not implemented"
    fi
}

#Need a better name
alias clkh='clear_known_hosts'
