"======================================================================
"
" init-plugins.vim -
"
"======================================================================

" group setting
if !exists('g:bundle_group')
	let g:bundle_group = ['basic', 'filetypes', 'enhanced', 'linter', 'fileManager', 'search', 'move']
"     let g:bundle_group += ['vim-lsp']
"     let g:bundle_group += ['vim-go']
    let g:bundle_group += ['lsp:coc']
endif

call plug#begin('~/.config/nvim/plugged')

if index(g:bundle_group, 'basic') >= 0
    " colorscheme
    Plug 'NLKNguyen/papercolor-theme'

    " statusline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    let g:airline_powerline_fonts = 1
    let g:airline_theme='papercolor'
    function! AirlineInit()
      let g:airline_section_a = airline#section#create(['mode'])
      let g:airline_section_b = airline#section#create(["%{get(g:,'coc_git_status','')}"])
      let g:airline_section_z = airline#section#create(["%{get(b:,'coc_git_blame','')}"])
    endfunction
    autocmd User AirlineAfterInit call AirlineInit()

    " asynctasks
    Plug 'skywind3000/asynctasks.vim'
    Plug 'skywind3000/asyncrun.vim'

    " asynctasks setting
    let g:asyncrun_open = 6
    let g:asynctasks_extra_config = [
        \ '~/.config/task/task.ini',
        \ ]

    " float windows
    Plug 'voldikss/vim-floaterm'

    " vim-float setting
    nnoremap <silent> <F10> :FloatermToggle<CR>
    tnoremap <silent> <F10> <C-\><C-n>:FloatermToggle<CR>
endif

if index(g:bundle_group, 'filetypes') >= 0
    "all
"     Plug 'sheerun/vim-polyglot'

    " Python
    Plug 'tell-k/vim-autopep8', {'for': 'python'}
    autocmd FileType python noremap <buffer> <C-=> :call Autopep8()<CR>
    let g:autopep8_ignore="E731"
    let g:autopep8_max_line_length=120
    let g:autopep8_disable_show_diff=1

    Plug 'nvie/vim-flake8', {'for': 'python'}
    Plug 'vim-python/python-syntax', {'for': 'python'}
    Plug 'davidhalter/jedi-vim', {'for': 'python'}
    let g:jedi#goto_command = ""
    let g:jedi#goto_assignments_command = "<leader>g"
    let g:jedi#goto_stubs_command = "<leader>s"
    let g:jedi#goto_definitions_command = "<leader>d"
    let g:jedi#documentation_command = "K"
    let g:jedi#usages_command = "<leader>n"
    let g:jedi#completions_command = "<C-Space>"
    let g:jedi#rename_command = ""
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins', 'for': 'python'}
    "

    " PHP
    Plug 'StanAngeloff/php.vim', {'for': 'php'}
    Plug 'beanworks/vim-phpfmt', {'for': 'php'}
    autocmd FileType php nnoremap <buffer> <Leader>= :PhpFmt<CR>
    let g:phpfmt_autosave = 0
    let g:phpfmt_standard = '/Users/tinybox/workplace/code_style/phpcs_ruleset.xml'

    " Thrift
    Plug 'solarnz/thrift.vim', {'for': 'thrift'}

    " Front
    Plug 'digitaltoad/vim-pug', {'for': 'pug'}
    Plug 'ruanyl/vim-fixmyjs', {'for': 'javascript'}
    autocmd FileType javascript noremap <Leader>= :Fixmyjs<CR>
    autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
    autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 1
    autocmd BufReadPre *.js let b:javascript_lib_use_backbone = 1
    autocmd BufReadPre *.js let b:javascript_lib_use_prelude = 0
    autocmd BufReadPre *.js let b:javascript_lib_use_angularjs = 0

    Plug 'hail2u/vim-css3-syntax', {'for': 'css'}
    Plug 'groenewege/vim-less', {'for': 'less'}
    Plug 'tpope/vim-haml', {'for': 'haml'}

    Plug 'pangloss/vim-javascript', {'for': 'javascript'}
    Plug 'kchmck/vim-coffee-script', {'for': 'javascript'}
    Plug 'leafgarland/typescript-vim', {'for': 'typescript'}

    " 补充一个 Vue 模板的
    Plug 'posva/vim-vue', {'for': 'vue'}

    " HTML 助手
    "   Plug 'mattn/emmet-vim'

    " JavaScript 补全
    "   Plug 'ternjs/tern_for_vim'
endif

if index(g:bundle_group, 'enhanced') >= 0
    " move
    Plug 'easymotion/vim-easymotion'

    Plug 'terryma/vim-smooth-scroll'
    noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 4)<CR>
    noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 4)<CR>
    noremap <silent> <Leader>k :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
    noremap <silent> <Leader>j :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

    Plug 'terryma/vim-expand-region'
    vmap v <Plug>(expand_region_expand)
    vmap V <Plug>(expand_region_shrink)

    " comment
    Plug 'scrooloose/nerdcommenter'
    let g:NERDSpaceDelims=1
    let g:NERDDefaultAlign='start'
    let g:NERDCustomDelimiters = { 'vue': { 'left': '//' } }

    " bookmarks
    Plug 'MattesGroeger/vim-bookmarks'
    highlight BookmarkSign ctermbg=NONE ctermfg=125
    let g:bookmark_sign = '♥'
    nmap ml <Plug>BookmarkShowAll

    " 色彩高亮，例子: #66CCFF
    Plug 'gorodinskiy/vim-coloresque'

    Plug 'ryanoasis/vim-devicons'

    " auto-completion for quotes, parens, brackets, etc
    Plug 'Raimondi/delimitMate'

    " git
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
endif

if index(g:bundle_group, 'linter') > 0
    Plug 'w0rp/ale'

    let g:ale_linters = {
                \   'sh' : ['shellcheck'],
                \   'go' : ['gobuild', 'golint'],
                \   'cpp' : ['clangd'],
                \   'vim' : ['vint'],
                \   'html' : ['tidy'],
                \   'python' : ['flake8'],
                \   'markdown' : ['mdl'],
                \   'javascript' : ['eslint'],
                \   'typescript': ['tslint', 'tsserver'],
                \}
    " python standard
    let g:ale_python_flake8_executable = 'python3'
    let g:ale_python_flake8_options = '-m flake8'
    " php standard
    let g:ale_php_phpcs_standard="/Users/tinybox/workplace/code_style/phpcs_ruleset.xml"
    " go standard
    let g:ale_go_revive_options = '-config ~/revive.toml'

    " just inappropriate way to format
    " although ale can do, but I don't like a plugins to do too much things
    let g:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'go': ['gofmt', 'goimports'],
    \}
    " Set this variable to 1 to fix files when you save them.
    let g:ale_fix_on_save = 1

    " If emoji not loaded, use default sign
    let g:ale_sign_error = '•'
    let g:ale_sign_warning = '•'

    let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
    let g:ale_statusline_format = ['E•%d', 'W•%d', 'OK']

    let g:ale_echo_msg_error_str = '✹ Error'
    let g:ale_echo_msg_warning_str = '⚠ Warning'
endif

if index(g:bundle_group, 'fileManager') >= 0
    " menu
    Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'}
    Plug 'kristijanhusak/defx-icons',
    Plug 'kristijanhusak/defx-git',

    nmap <silent> <C-n> :Defx <CR>
    autocmd FileType defx call s:defx_my_settings()

    function! s:defx_my_settings() abort
          " Define mappings
          nnoremap <silent><buffer><expr> <CR>
          \ <SID>defx_toggle_tree()
          nnoremap <silent><buffer><expr> c
          \ defx#do_action('copy')
          nnoremap <silent><buffer><expr> m
          \ defx#do_action('move')
          nnoremap <silent><buffer><expr> p
          \ defx#do_action('paste')
          nnoremap <silent><buffer><expr> E
          \ defx#do_action('open', 'vsplit')
          nnoremap <silent><buffer><expr> P
          \ defx#do_action('preview')
          nnoremap <silent><buffer><expr> K
          \ defx#do_action('new_directory')
          nnoremap <silent><buffer><expr> N
          \ defx#do_action('new_file')
          nnoremap <silent><buffer><expr> C
          \ defx#do_action('toggle_columns',
          \                'mark:indent:icon:filename:type:size:time')
          nnoremap <silent><buffer><expr> d
          \ defx#do_action('remove')
          nnoremap <silent><buffer><expr> r
          \ defx#do_action('rename')
          nnoremap <silent><buffer><expr> !
          \ defx#do_action('execute_command')
          nnoremap <silent><buffer><expr> yy
          \ defx#do_action('yank_path')
          nnoremap <silent><buffer><expr> .
          \ defx#do_action('toggle_ignored_files')
          nnoremap <silent><buffer><expr> q
          \ defx#do_action('quit')
          nnoremap <silent><buffer><expr> l
          \ defx#do_action('redraw')
          nnoremap <silent><buffer><expr> <Space>
          \ defx#do_action('toggle_select') . 'j'
          nnoremap <silent><buffer><expr> j
          \ line('.') == line('$') ? 'gg' : 'j'
          nnoremap <silent><buffer><expr> k
          \ line('.') == 1 ? 'G' : 'k'
    endfunction

    function! s:defx_toggle_tree() abort
        " Open current file, or toggle directory expand/collapse
        if defx#is_directory()
            return defx#do_action('open_or_close_tree')
        endif
        return defx#do_action('multi', ['drop'])
    endfunction

    let g:defx_icons_enable_syntax_highlight = 1
    let g:defx_icons_column_length = 1
    let g:defx_icons_directory_icon = ''
    let g:defx_icons_mark_icon = '*'
    let g:defx_icons_copy_icon = ''
    let g:defx_icons_move_icon = ''
    let g:defx_icons_parent_icon = ''
    let g:defx_icons_default_icon = ''
    let g:defx_icons_directory_symlink_icon = ''
    " Options below are applicable only when using "tree" feature
    let g:defx_icons_root_opened_tree_icon = ''
    let g:defx_icons_nested_opened_tree_icon = ''
    let g:defx_icons_nested_closed_tree_icon = ''
    let g:defx_icons_term_colors = {
    \ 'red': 2
    \ }
    hi default link DefxIconsMarkIcon Statement
    hi default link DefxIconsCopyIcon WarningMsg
    hi default link DefxIconsMoveIcon ErrorMsg
    hi default link DefxIconsDirectory Directory
    hi default link DefxIconsParentDirectory Directory
    hi default link DefxIconsSymlinkDirectory Directory
    hi default link DefxIconsOpenedTreeIcon Directory
    hi default link DefxIconsNestedTreeIcon Directory
    hi default link DefxIconsClosedTreeIcon Directory
    hi link DefxIconsOpenedTreeIcon Error
endif

if index(g:bundle_group, 'search') >= 0
    Plug 'Yggdroot/LeaderF'
    " sort search result from bottom to top
    let g:Lf_ReverseOrder = 1

    " CTRL+p 打开文件模糊匹配
    let g:Lf_ShortcutF = '<c-p>'

    " ALT+n 打开 buffer 模糊匹配
    let g:Lf_ShortcutB = '<c-m>'
    " CTRL+n 打开最近使用的文件 MRU，进行模糊匹配
    noremap <c-m> :LeaderfBuffer<cr>

    " rg搜索文本
    noremap <c-f> :Leaderf rg --wd-mode=ac -e

    " ALT+p 打开函数列表，按 i 进入模糊匹配，ESC 退出
    " π is for mac alt+p
    noremap π :LeaderfFunction!<cr>
    noremap <m-p> :LeaderfFunction!<cr>

    " 最大历史文件保存 2048 个
    let g:Lf_MruMaxFiles = 2048

    " ui 定制
    let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

    " 如何识别项目目录，从当前文件目录向父目录递归知道碰到下面的文件/目录
    let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
    let g:Lf_WorkingDirectoryMode = 'Ac'
    let g:Lf_WindowHeight = 0.30
    let g:Lf_CacheDirectory = expand('~/.config/nvim/cache')

    " 显示绝对路径
    let g:Lf_ShowRelativePath = 0

    " 隐藏帮助
    let g:Lf_HideHelp = 1

    " 模糊匹配忽略扩展名
    let g:Lf_WildIgnore = {
                \ 'dir': ['.svn','.git','.hg'],
                \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
                \ }

    " MRU 文件忽略扩展名
    let g:Lf_MruFileExclude = ['*.so', '*.exe', '*.py[co]', '*.sw?', '~$*', '*.bak', '*.tmp', '*.dll']
    let g:Lf_StlColorscheme = 'powerline'

    " 禁用 function/buftag 的预览功能，可以手动用 p 预览
    let g:Lf_PreviewResult = {'Function':0, 'BufTag':0, 'Rg': 1}
    let g:Lf_AutoResize = 0
    let g:Lf_WindowHeight = 0.3

    " 使用 ESC 键可以直接退出 leaderf 的 normal 模式
    let g:Lf_NormalMap = {
            \ "File":   [["<ESC>", ':exec g:Lf_py "fileExplManager.quit()"<CR>']],
            \ "Buffer": [["<ESC>", ':exec g:Lf_py "bufExplManager.quit()"<cr>']],
            \ "Mru": [["<ESC>", ':exec g:Lf_py "mruExplManager.quit()"<cr>']],
            \ "Tag": [["<ESC>", ':exec g:Lf_py "tagExplManager.quit()"<cr>']],
            \ "BufTag": [["<ESC>", ':exec g:Lf_py "bufTagExplManager.quit()"<cr>']],
            \ "Function": [["<ESC>", ':exec g:Lf_py "functionExplManager.quit()"<cr>']],
            \ }

    Plug 'liuchengxu/vista.vim'
    let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
    nnoremap <space>l :Vista coc<cr>
endif

if index(g:bundle_group, 'vim-lsp') >= 0 && has('nvim-0.5')
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/completion-nvim'
    command! LspHover lua vim.lsp.buf.hover()<CR>
    command! LspDisable lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>

    nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
    nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> <A-r>    <cmd>lua vim.lsp.buf.rename()<CR>
    nnoremap <silent> gh     <cmd>lua vim.lsp.buf.hover()<CR>
    nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
    nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
    nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
    nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

    " Completion
    " Use <Tab> and <S-Tab> to navigate through popup menu
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    " Set completeopt to have a better completion experience
    set completeopt=menuone,noinsert,noselect

    " Avoid showing message extra message when using completion
    set shortmess+=c

    let g:completion_enable_auto_signature = 1
    let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

    " Show errors after 1 second
    set updatetime=1000

    let g:diagnostic_insert_delay =1
    let g:diagnostic_enable_ale = 1
endif

if index(g:bundle_group, 'lsp:coc') >= 0
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " coc for lsp

    augroup CocGroup
      autocmd!
      autocmd BufNew,BufEnter *.py execute "silent! CocDisable"
    "   autocmd BufNew,BufEnter *.go execute "silent! CocDisable"
    augroup end

    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    if has('nvim')
      inoremap <silent><expr> <c-m> coc#refresh()
    else
      inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " Make <CR> auto-select the first completion item and notify coc.nvim to
    " format on enter, <cr> could be remapped by other vim plugin
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    " Open coclist
    nmap <silent> <C-c> :CocList<CR>

    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    " coc has some wrong in module nvim setting, dirty fix
    nmap <silent> gr <Plug>(coc-references)
    autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR> :lclose<CR>

    " nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
      else
        execute '!' . &keywordprg . " " . expand('<cword>')
      endif
    endfunction


    " Highlight the symbol and its references when holding the cursor.
"     autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <A-r> <Plug>(coc-rename)

    " Formatting selected code.
    " xmap <leader>f  <Plug>(coc-format-selected)
    " nmap <leader>f  <Plug>(coc-format-selected)

    augroup mycocgroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Git status refreshed as expected
    " autocmd CursorHold * :CocCommand git.refresh

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
    " }}}
    " deoplete {{{
    "     let g:deoplete#enable_at_startup = 1
endif


  " GO
if index(g:bundle_group, 'vim-go') >= 0
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' , 'for': 'go'}

    let g:go_highlight_fields = 1
    let g:go_highlight_build_constraints = 1
    let g:go_highlight_generate_tag = 1
    let g:go_highlight_format_strings = 1
    let g:go_highlight_functions = 1
    " let g:go_highlight_function_calls = 1
    let g:go_highlight_function_parameters = 1
    let g:go_highlight_operators = 1
    let g:go_highlight_types = 1
    let g:go_highlight_fuck = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_variable_declarations = 1
    let g:go_highlight_variable_assignments = 1
    let g:go_highlight_variable_declarations = 1

    let g:go_fmt_command = "gofumpt"
    let g:go_fmt_autosave = 1

    nmap <silent> gd :GoDef<CR>
"     nmap <silent> gy <Plug>(coc-type-definition)
"     nmap <silent> gi <Plug>(coc-implementation)
    " coc has some wrong in module nvim setting, dirty fix
    nmap <silent> gr :GoReferrers<CR>

    " let g:go_def_mode='gopls'
    " let g:go_info_mode='gopls'
    " au filetype go inoremap <buffer> . .<C-x><C-o>
    " Status line types/signatures
    " let g:go_auto_type_info = 1
endif

call plug#end()


if index(g:bundle_group, 'fileManager')
    " after plug setting
    call defx#custom#option('_', {
          \ 'columns': 'git:indent:icons:filename',
          \ 'winwidth': 30,
          \ 'split': 'vertical',
          \ 'direction': 'topleft',
          \ 'show_ignored_files': 0,
          \ 'buffer_name': '',
          \ 'toggle': 1,
          \ 'resume': 1
          \ })

    call defx#custom#column('git', 'indicators', {
      \ 'Modified'  : '✹',
      \ 'Staged'    : '✚',
      \ 'Untracked' : '✭',
      \ 'Renamed'   : '➜',
      \ 'Unmerged'  : '═',
      \ 'Ignored'   : '☒',
      \ 'Deleted'   : '✖',
      \ 'Unknown'   : '?'
      \ })
endif
