"======================================================================
"
" init-keymaps.vim - 按键设置，按你喜欢更改
"
"   - 快速移动
"   - 标签切换
"   - 窗口切换
"   - 终端支持
"   - 编译运行
"   - 符号搜索
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Basic Config {{{

" The default leader is '\', but many people prefer ',' as it's in a standard
" location, BUT I LOVE SPACE!!!!
let mapleader = ' '

" Fast editing of the .vimrc
" map <leader>v :e ~/.vimrc<cr>
map <leader>v :e ~/.config/nvim/init.vim<cr>

" Don't lazy to map : to ;, ; has it's own usage in search
nnoremap <Leader>w :w<CR>
noremap <Leader>q :q<CR>
nnoremap <Leader>x :bd<CR>

" Quickly esc in insert mode
inoremap jk <Esc>

" Quickly insert :=
iabbrev ;; :=

" Quickly insert , in end
nnoremap ,, $a,<Esc>

" Quickly reload buffer
nnoremap <Leader>r :e!<CR>

" }}}


" split windows {{{

nnoremap <Leader>- :sp<CR>
nnoremap <Leader>+ :vsp<CR>

" }}}


" move windows {{{

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" }}}


" Remap VIM 0 and 9 {{{

map 9 ^
map 0 $

" }}}


" Use the arrows to something usefull {{{

nnoremap <right> :bn!<cr>
nnoremap <left> :bp!<cr>

" }}}


" Cut / Paste {{{

" to/from the clipboard
map <Leader>y "*y
map <Leader>p "*p

" toggle paste mode
map <Leader>P :set invpaste<CR>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" }}}

" clearing highlighted search {{{

nmap <silent> <leader>/ :nohlsearch<CR>

" }}}

" Change Working Directory to that of the current file {{{

cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" }}}
