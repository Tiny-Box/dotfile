"======================================================================
"
" init-basic.vim - basic
"
"======================================================================
" vim: set ts=4 sw=4 tw=78 noet :

" Required:
filetype plugin indent on
syntax enable


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Environment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Basics  options {{{

set nocompatible               " must be first line

" General
" set fencs=utf-8,gb2312,gbk     " Sets the default encoding
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1
" set autochdir                  " always switch to the current file directory.
set encoding=utf-8

set nospell                    " spell checking off
set shortmess+=filmnrxoOtT     " abbrev. of messages (avoids 'hit enter')
set shortmess+=c               " Don't pass messages to |ins-completion-menu|.
set virtualedit=onemore        " allow for cursor beyond last character
set history=1000               " Store a ton of history (default is 20)

set noswapfile
set nobackup                     " backups are nice ... but some servers have issues in coc
set nowritebackup
" set backupdir=~/.vim/backup

set cmdheight=2                " Give more space for displaying messages.
set updatetime=300             " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable

" When vimrc is edited, reload it
autocmd! BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim

" set clipboard
set clipboard+=unnamed

" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim UI
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Colorscheme {{{

syntax enable                  " enable the syntax highlight
set background=light            " set a dark background
set t_Co=256                   " 256 colors for the terminal
if has('gui_running')
    colorscheme PaperColor
else
    colorscheme PaperColor
    let g:termguicolors=1
endif

" }}}


" Font {{{

set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12

" }}}


" Basic config {{{

set tabpagemax=15             " only show 15 tabs
set showmode                  " display the current mode

set cursorline                " highlight current line
set cursorcolumn              " highlight current column

set laststatus=2
set backspace=indent,eol,start " Backspace for dummys
set linespace=0                " No extra spaces between rows
set nu                         " Line numbers on
set showmatch                  " Show matching brackets/parenthesis
set incsearch                  " Find as you type search
set hlsearch                   " Highlight search terms
set winminheight=0             " Windows can be 0 line high
set ignorecase                 " Case insensitive search
set smartcase                  " Case sensitive when uc present
set wildmenu                   " Show list instead of just completing
set wildmode=list:longest,full " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]  " Backspace and cursor keys wrap to
set scrolljump=5               " Lines to scroll when cursor leaves screen
set scrolloff=3                " Minimum lines to keep above and below cursor
set nofoldenable               " Disable fold code
set gdefault                   " The /g flag on :s substitutions by default
set hidden                     " Change buffer - without saving
set magic                      " Set magic on, for regular expressions
set autoread                   " Auto reload file on change
set list
set listchars=tab:>\ ,trail:\ ,extends:#,nbsp:\  " Highlight problematic whitespace
set cc=100

" }}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tabs, space and wrapping {{{

set expandtab                  " spaces instead of tabs
set tabstop=4                  " a tab = four spaces
set shiftwidth=4               " number of spaces for auto-indent
set softtabstop=4              " a soft-tab of four spaces
set autoindent                 " set on the auto-indent

autocmd FileType php setl shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab
autocmd BufEnter *.jade setl shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab
autocmd BufEnter *.vue setl shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 noexpandtab


" set formatoptions=qrn1ct
set textwidth=120
set colorcolumn=120

" }}}


" Basic Config {{{

set wrap            " wrap long lines
set linebreak       " set linebreak
set textwidth=0     " sets the text width

" }}}

"----------------------------------------------------------------------
" Fold setting
"----------------------------------------------------------------------
if has('folding')
	" allow fold
	set foldenable

	" default indent
	set fdm=indent

	" default turn on all level
	set foldlevel=99

    augroup remember_folds
      autocmd!
      au BufWinLeave ?* mkview 1
      au BufWinEnter ?* silent! loadview 1
    augroup END
endif
