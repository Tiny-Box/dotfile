#!/usr/bin/env bash

source "$(cd -P "$(dirname "$0")" && pwd -P)/../base.sh"

do_install() {
    link_file "$src_conf/zshrc" "${ZDOTDIR:-$HOME}/.zshrc"

    if [[ ! $SHELL =~ zsh ]]; then
        user "zsh is not your default shell, do you make it default?\n [y]es, [n]o?"
        read -r -n 1 action
        if [[ $action == y ]]; then
            chsh -s "$(command -v zsh)"
        fi
    fi
}

install
