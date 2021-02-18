"======================================================================
"
" init.vim - initialize config
"
"======================================================================

" " 防止重复加载
if get(s:, 'loaded', 0) != 0
    finish
else
    let s:loaded = 1
endif

" " 取得本文件所在的目录
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')


" " 定义一个命令用来加载文件
command! -nargs=1 LoadScript exec 'so '.s:home.'/'.'<args>'

" " 将 vim-init 目录加入 runtimepath
exec 'set rtp+='.s:home

"----------------------------------------------------------------------
" 模块加载
"----------------------------------------------------------------------

" 插件加载
LoadScript init/init-plugins.vim

" 加载基础配置
LoadScript init/init-basic.vim

" 自定义按键
LoadScript init/init-keymaps.vim

" 加载扩展配置
" LoadScript init/init-config.vim

" 设定 tabsize
" LoadScript init/init-tabsize.vim


" 界面样式
" LoadScript init/init-styles.vim

" load secret company vim setting
if filereadable(s:home . '/init/init-company.vim')
    LoadScript init/init-company.vim
else
    echo 'no company setting'
endif
