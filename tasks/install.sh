#!/usr/bin/env bash

source "$(cd -P "$(dirname "$0")" && pwd -P)/../base.sh"

do_install() {
    echo $dst_conf
#     link_file "$src_conf/tmux.conf" "$HOME/.tmux.conf"
}

install
