" Vim global plugin for hexo 
" version : 1.0
" Author : WiZero(<ywlbupt@163.com>)
" LastUpdate : 2016-09-20 23:05:12
" Description : Description

" Option List
" g:loaded_hexovim
" g:hexo_blogpath

"""""""""""""""""""""""
"  Test Option Macro  "
"""""""""""""""""""""""
let g:hexo_blogpath = '/home/ywl/hexo_blog'


if exists("g:loaded_vim_hexo")
" User doesn't want this plugin or compatible is set, let's get out!
    finish
endif
let g:loaded_vim_hexo = 1

" 配置hexo 路径
if !exists("g:hexo_blogpath") 
    let g:hexo_blogpath = ""
endif

" 定义命令
if !exists(":Newblog")
  command -nargs=?  Newblog call s:NewPost(<f-args>)
endif
if !exists(":Pushpost")
  command -nargs=?  Pushpost call s:Pushpost(<f-args>)
endif

" Transform string to functions
" We cannot use `:e filename` so make it a function
function! s:Trans()
    let s:filename = g:hexo_blogpath . "/source/_posts/" . s:title . ".md"
    return s:filename
endfunction

" Run command that build new blog
function! s:Runcmd()
    " 启动 Bash , -c
    " 启动完Bash后从后面的字符串中读取命令并执行，然后退出，各命令以分号隔开
    let s:cmd = "!bash -c 'cd " . g:hexo_blogpath . "; hexo n \'". s:title ."\' | cut -f3- -dt\'"
    execute s:cmd
endfunction

" Create a New post
function! s:NewPost(...)
    if g:hexo_blogpath != ""
        if a:0 ==""
            let s:title = input("Input the blog title: ")
        else
            let s:title = a:000[0]
        endif
        call s:Runcmd()
        edit `=s:Trans()`
    else
        echo "Not set hexo_blogpath, use `let g:hexo_blogpath=` to set"
    endif
endfunction

" Update blog command
function! s:Update()
    let s:cmd = "!bash -c 'cd " . g:hexo_blogpath . "; hexo g; hexo d;'"
    execute s:cmd
endfunction


" Pust post to website
function! s:Pushpost(...)
    call s:Update()
endfunction
    




" For test

" Future to add
" if !exists(":NewPost")
  " command -nargs=?  NewPost call s:show(<f-args>)
" endif

" let g:aa = ""

" function! s:show(...)
    " if g:aa != ""
        " if a:0 ==""
            " echo g:aa . " is NULL"
        " else
            " echo g:aa . " is ".a:000[0]
        " endif
    " else
        " echo "Not set aa"
    " endif
" endfunction
" call s:NewPost()

" vim:foldmethod=marker:foldcolumn=4:ts=2:sw=2
