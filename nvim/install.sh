#!/usr/bin/env bash

source "$(cd -P "$(dirname "$0")" && pwd -P)/../base.sh"

do_install() {
    mkdir -p "$dst_conf/autoload" 2>/dev/null
    mkdir -p "$dst_conf/colors" 2>/dev/null

    if [[ ! -f "$dst_conf/autoload/plug.vim" ]]; then
        curl -fLo "$dst_conf/autoload/plug.vim" --create-dirs \
            'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    fi

    find "$src_conf/autoload" -iname '*.vim' -type f -maxdepth 1 | {
        while read -r file; do
            link_file "$file" "$dst_conf/autoload/$(basename $file)" </dev/tty
        done
    }

    find "$src_conf/colors" -iname '*.vim' -type f -maxdepth 1 | {
        while read -r file; do
            link_file "$file" "$dst_conf/colors/$(basename $file)" </dev/tty
        done
    }

    find "$src_conf" -iname '*.vim' -type f -maxdepth 1 | {
        while read -r file; do
            link_file "$file" "$dst_conf/$(basename $file)" </dev/tty
        done
    }

    nvim +PlugInstall +qa
}

install
