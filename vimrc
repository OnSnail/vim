" ============== START for pathogen ======
execute pathogen#infect()
syntax on
syntax enable
filetype plugin on
filetype plugin indent on
" ============== End for pathogen ======

"
"=========My Configuration=========================
"===================================================================================
"===read 'Seven habits of effective text editing' http://www.moolenaar.net/habits.html===

"设置leader
let mapleader=","

set nu
"set tags=tags;
set autochdir

if version < 700
  echo "~/.vimrc: Vim 7.0+ is required!, you should upgrade your vim to latest version."
  finish
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" common settings section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

" 取消所有代码折叠
set nofoldenable
" json可以用syntax作fold。
" 快捷键zA,za(toggle all or one level),
" zO,zo(open),zC,zc(close)
"set foldmethod=syntax

"@note:solarized see the commit under ranbo about colorscheme and terminal
"== start scheme solarized
set t_Co=256
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
"== end scheme solarized

" input settings
set backspace=2
set tabstop=2
set shiftwidth=2
set smarttab
" set softtabstop=4
set expandtab " expand tab to spaces

" indent settiongs
set autoindent
set smartindent
set cindent
set cinoptions=:0,g0,t0,(0,Ws,m1

" search settings
set hlsearch
set incsearch
set smartcase
set ignorecase " Do case insensitive matching 添加\c可忽略大小写

" quickfix settings
compiler gcc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display settings section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ruler
set showmatch
set showmode
set wildmenu
set wildmode=longest:full,full

" status line
set statusline=%<%f\ %h%m%r%=CODE[%b\ ,0x%B\ ]\ %k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-4.(%l,%c%V%)\ %P

" auto encoding detecting
set encoding=utf-8
set fileencodings=utf-8,gbk,cp936,big5,gb18030,ucs,ucs-bom,utf-8-bom
"set fileencoding=utf-8
let g:fencview_autodetect = 1

" set term encoding according to system locale
let &termencoding = substitute($LANG, "[a-zA-Z_-]*\.", "", "")

" support gnu syntaxt
let c_gnu = 1

" show error for mixed tab-space
let c_space_errors = 1
"let c_no_tab_space_error = 1

" don't show gcc statement expression ({x, y;}) as error
let c_no_curly_error = 1

" hilight characters over 101 columns
set colorcolumn=80

" hilight extra spaces at end of line
match Error '\s\+$'

" fix vim quick fix
set errorformat^=%-GIn\ file\ included\ %.%#

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key mappings section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <Leader>sp :set paste<CR>
nnoremap <Leader>snp :set nopaste<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto commands section
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" remove trailing spaces
function! RemoveTrailingSpace()
  if $VIM_HATE_SPACE_ERRORS != '0'
    normal m`
    silent! :%s/\s\+$//e
    normal ``
  endif
endfunction

" apply gnu indent rule for system headers
function! GnuIndent()
  setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
  setlocal shiftwidth=2
  setlocal tabstop=8
endfunction

" fix inconsist line ending
function! FixInconsistFileFormat()
  if &fileformat == 'unix'
    silent! :%s/\r$//e
  endif
endfunction
autocmd BufWritePre * nested call FixInconsistFileFormat()

" custom indent: no namespace indent, fix template indent errors
function! CppNoNamespaceAndTemplateIndent()
  let l:cline_num = line('.')
  let l:cline = getline(l:cline_num)
  let l:pline_num = prevnonblank(l:cline_num - 1)
  let l:pline = getline(l:pline_num)
  while l:pline =~# '\(^\s*{\s*\|^\s*//\|^\s*/\*\|\*/\s*$\)'
    let l:pline_num = prevnonblank(l:pline_num - 1)
    let l:pline = getline(l:pline_num)
  endwhile
  let l:retv = cindent('.')
  let l:pindent = indent(l:pline_num)
  if l:pline =~# '^\s*template\s*<\s*$'
    let l:retv = l:pindent + &shiftwidth
  elseif l:pline =~# '^\s*template\s*<.*>\s*$'
    let l:retv = l:pindent
  elseif l:pline =~# '\s*typename\s*.*,\s*$'
    let l:retv = l:pindent
  elseif l:pline =~# '\s*typename\s*.*>\s*$'
    let l:retv = l:pindent - &shiftwidth
  elseif l:cline =~# '^\s*>\s*$'
    let l:retv = l:pindent - &shiftwidth
  elseif l:pline =~# '^\s\+: \S.*' " C++ initialize list
    let l:retv = l:pindent + 2
  elseif l:pline =~# '^\s*namespace.*'
    let l:retv = 0
  endif
  return l:retv
endfunction
autocmd FileType cpp nested setlocal indentexpr=CppNoNamespaceAndTemplateIndent()

augroup filetype
  autocmd! BufRead,BufNewFile *.proto set filetype=proto
  autocmd! BufRead,BufNewFile *.thrift set filetype=thrift
  autocmd! BufRead,BufNewFile *.pump set filetype=pump
  autocmd! BufRead,BufNewFile BUILD set filetype=blade
  autocmd! BufRead,BufNewFile *.avsc set filetype=json
augroup end

" When editing a file, always jump to the last cursor position
autocmd BufReadPost * nested
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \ exe "normal g'\"" |
      \ endif

autocmd BufEnter /usr/include/c++/* nested setfiletype cpp
autocmd BufEnter /usr/include/* nested call GnuIndent()
autocmd BufWritePre * nested call RemoveTrailingSpace()

function SetLogHighLight()
  highlight LogFatal ctermbg=red guifg=red
  highlight LogError ctermfg=red guifg=red
  highlight LogWarning ctermfg=yellow guifg=yellow
  highlight LogInfo ctermfg=green guifg=green
  syntax match LogFatal "^F\d\+ .*$"
  syntax match LogError "^E\d\+ .*$"
  syntax match LogWarning "^W\d\+ .*$"
  " syntax match LogInfo "^I\d\+ .*$"
endfunction
autocmd BufEnter *.{log,INFO,WARNING,ERROR,FATAL} nested call SetLogHighLight()

" auto insert gtest header inclusion for test source file
function! s:InsertHeaderGuard()
  let fullname = expand("%:p")
  let rootdir = FindProjectRootDir()
  if rootdir != ""
    let path = substitute(fullname, "^" . rootdir . "/", "", "")
  else
    let path = expand("%")
  endif
  let varname = toupper(substitute(path, "[^a-zA-Z0-9]", "_", "g")) . "_"
  exec 'norm O#ifndef ' . varname
  exec 'norm o#define ' . varname
  "   exec 'norm o#pragma once'
  exec '$norm o#endif // ' . varname
endfunction
autocmd BufNewFile *.{h,hh.hxx,hpp} nested call <SID>InsertHeaderGuard()

autocmd QuickFixCmdPost * :QFix

autocmd FileType python syn keyword Function self

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom commands sections
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"======xmllint======
"au 导致会删除
function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
command! PrettyJSON call JsBeautify()
"==json==%!python -m json.tool
"===== curosor operate in the QUICKFIX, the location-list 要用nnoremap
nnoremap <Leader>cn :cn<CR>
nnoremap <Leader>ln :lne<CR>
nnoremap <Leader>cp :cp<CR>
nnoremap <Leader>lp :lp<CR>
"popup setting
nnoremap <Leader>w :w<CR>
set completeopt=menuone,menu,longest
" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd " Show (partial) command in status line.
set autowrite " Automatically save before commands like :next and :make
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
" Use visual bell instead of beeping when doing something wrong
set visualbell
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
" Always display the status line, even if only one window is displayed
set laststatus=2
"命令行高度
set cmdheight=2
" Better command-line completion
set wildmenu
"否则切换buff会提示必须保存
set hidden
"下划线
set cursorline
set cursorcolumn
"不折行
"set nowrap
"折行
set wrap

"定义edit
nnoremap <Leader>e :e
"定义quit
noremap <Leader>q :q<CR><Esc>
" nohl
nnoremap <Leader>nh :nohl<CR><ESC>
"设置快捷键将选中文本块复制至系统剪贴板
vnoremap<Leader>y "+y
vnoremap<Leader>1y "1y
vnoremap<Leader>2y "2y
vnoremap<Leader>3y "3y
vnoremap<Leader>4y "4y
vnoremap<Leader>5y "5y
vnoremap<Leader>6y "6y
vnoremap<Leader>7y "7y
vnoremap<Leader>8y "8y
vnoremap<Leader>9y "9y
"设置快捷键将系统y剪贴板内容粘贴至vim
vnoremap<Leader>p "+p
vnoremap<Leader>1p "1p
vnoremap<Leader>2p "2p
vnoremap<Leader>3p "3p
vnoremap<Leader>4p "4p
vnoremap<Leader>5p "5p
vnoremap<Leader>6p "6p
vnoremap<Leader>7p "7p
vnoremap<Leader>8p "8p
vnoremap<Leader>9p "9p


nmap <Leader>bp :bp<cr>
nmap <Leader>bn :bn<cr>
nmap <Leader>b1 :b1<cr>
nmap <Leader>b2 :b2<cr>
nmap <Leader>b3 :b3<cr>
nmap <Leader>b4 :b4<cr>
nmap <Leader>b5 :b5<cr>
nmap <Leader>b6 :b6<cr>
nmap <Leader>b7 :b7<cr>
nmap <Leader>b8 :b8<cr>
nmap <Leader>b9 :b9<cr>
nmap <Leader>b0 :b0<cr>

nmap <silent> <Leader>cll :ccl<CR>
" Automatically read a file that has changed on disk
set autoread

"cd to the pwd of the curent file
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" use ,F to jump to tag in a vertical split. !!See below rope .
nnoremap <silent> <C-]> :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>

" use ,gf to go to file in a vertical split
nnoremap <silent> gf :vertical botright wincmd f<CR>

"-----------------START Plugins-------------------------------------------------------
"=====ctasgs---
"ctags 跳转
nmap <Leader>ts :tselect
"======indent-guide---
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
augroup EditVim
  autocmd!
  autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=darkgrey ctermbg=236
  autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=black ctermbg=236
  autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
  autocmd BufNewFile,BufRead *.html.erb set filetype=eruby.html

augroup END

"=======surround.vim====for eruby====

"=======unite.vim======
let g:unite_source_history_yank_enable = 1
" 'matcher_project_ignore_files' not work
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('tag,file_rec,file_mru,file,file_rec/git,grep', 'matchers', 'matcher_fuzzy')

" 1. 注意匹配尽量写好，之前出过'login'查不到因为过滤 *.log
" 2. 出现过rizhiyi_manager/.gitignore
" 里写了etcd导致含有etcd这个字串的都被ignore，应指定到具体的文件etcd/etcd就好了。
" TODO: 当git时候因是通过git
" ls-files应可改unite插件使得不从.gitignore中找parttern加入ignore_pattern
" 3. 这些应该可以通过.gitignore过滤的，不放在这里。但就当没有git的查找文件累些
     "\ '\.git/',
     "\ 'bootstrap/',
     "\ '\.sass-cache',
     "\ 'node_modules/',
     "\ 'app/storage',
     "\ '\.cache/',
     "\ '\.atom/',
     "\ '\.codeintel/',
     "\ '\.gitignore',
     "\ '.*\.swp',
     "\ 'tags',
     "\ '\.arcconfig',
     "\ '\.ropeproject/',
     "\ '/.*\.log',
     "\ '.*\.bak',
     "\ '.*\.gz',
     "\ '.*\.tar',
     "\ '.*\.jar',
     "\ '.*\.tar\.gz',
call unite#custom_source('file_rec,file_mru,file,file_rec/git,grep',
      \ 'ignore_pattern', join([
      \ '^/src/rizhiyi_manager/Godeps/_workspace/src/',
      \ '^/src/rizhiyi_manager_agent/rizhiyi/java/',
      \ '^/src/rizhiyi_manager_agent/rizhiyi/license/',
      \ '^/src/rizhiyi_manager_agent/rizhiyi_manager_agent/python',
      \ '^/src/YottaMonitor/influxdb',
      \ '^/src/YottaMonitor/pymysql',
      \ '^/src/YottaMonitor/requests',
      \ '^/src/YottaMonitor/web',
      \ '^/src/YottaMonitor/static/assets',
      \ ], '\|'))

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--line-numbers --nogroup --nocolor -S'
  let g:unite_source_grep_recursive_opt = ''
endif
" grep and file_rec will be in vim_yotta**.sh use ! to rec to git
nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:.:--depth=3
nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file:.<CR>

nnoremap <silent> <Leader>fb  :<C-u>Unite -smartcase -buffer-name=mru -start-insert buffer file_mru<CR>
nnoremap <silent> <Leader>ff  :cd %:p:h<CR>:<C-u>Unite -smartcase -buffer-name=files -start-insert file:.<CR>
nnoremap <silent> <Leader>ft  :<C-u>Unite tag<CR>
nnoremap <silent> <Leader>fr  :<C-u>Unite register<CR>
nnoremap <silent> <Leader>fy  :<C-u>Unite -buffer-name=yank history/yank<CR>

let g:unite_enable_start_insert = 1
function! s:unite_my_settings()"{{{
  " Overwrite settings.

  nmap <buffer> <ESC>      <Plug>(unite_exit)
  imap <buffer> jj      <Plug>(unite_insert_leave)
  "imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)

  " <C-l>: manual neocomplcache completion.
  inoremap <buffer> <C-l>  <C-x><C-u><C-p><Down>

  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction"}}}
autocmd FileType unite call s:unite_my_settings()

let g:unite_source_file_mru_limit = 2048
let g:unite_source_file_mru_filename_format = ''

let g:unite_source_tag_max_fname_length = 83
"======end unite.vim

"==========python-mode=====
" Override go-to.definition key shortcut to Ctrl-]
" use custom map
let g:pymode_rope_goto_definition_bind = "<C-]>"
let g:pymode_rope_goto_definition_cmd = "vsplit"
"
let g:pymode_options_max_line_length = 80
let g:pymode_lint_options_pep8 = {'max_line_length': 120}
let g:pymode_lint_options_pylint = {'max-line-length': 120}
let g:pymode_lint_ignore = "E101,E302,E301,E701,E111,E114,E501"
" no nesseary: .vim/bundle/python-mode/pymode/libs/pylama/lint/pylama_pylint/pylint.rc
" no nesseary: ~/pylama.ini

let g:pymode_rope_lookup_project = 1
"let g:pymode_rope_lookup_project = 0
" lint
let g:pymode_rope_completion = 1
let g:pymode_rope_complete_on_dot = 1
let g:pymode_rope_autoimport = 1
"let g:pymode_rope_autoimport = 0
let g:pymode_rope_autoimport_modules = ['os', 'datetime']
let g:pymode_rope_autoimport_import_after_complete = 0
"===end python-mode
"

"==========neocomplete=====
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use echodoc,which is simple prview at the command line.disable the preview.
" which relay one the setting 'set completeopt=menuone,menu,longest'
let g:echodoc_enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_fuzzy_completion = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 1
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" == python-mode has autocomplete
"let g:neocomplete#sources#omni#input_patterns.go = '[^.[:digit:] *\t]\.\w*'
let g:neocomplete#sources#omni#input_patterns.go = '\h\w*'
let g:neocomplete#sources#omni#input_patterns.python = '\h\w*'
" autocmd FileType python NeoCompleteDisable
" call neocomplete#custom#source('dictionary',
        "\ 'disabled_filetypes', {'python' : 1})
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"=======end neocomplete=====
"=======start neosnippet====
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/custom/snippets,~/.vim/bundle/vim-go/gosnippets/snippets,~/.vim/bundle/vim-snippets/snippets'
"=======end neosnippet====

"=======start tarbar=======
let g:tagbar_type_javascript = {
    \ 'ctagstype' : 'JavaScript',
    \ 'ctagsbin' : 'ctags',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 'm:methods',
        \ 'p:properties',
        \ 'v:global variables',
        \ 'o:objects',
        \ 'f:functions'
    \ ]
\ }
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
function _TagbarToggleLeft()
  let g:tagbar_left = 1
  execute "TagbarToggle"
endfunction
nmap <Leader>tl :call _TagbarToggleLeft()<CR>

function _TagbarToggleRight()
  let g:tagbar_left = 0
  execute "TagbarToggle"
endfunction
nmap <Leader>trl :call _TagbarToggleRight()<CR>
"=======end tarbar=======
"
"=======syntastic=======
"tips: 用:x退出vim可以不触发syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting=1
let g:syntastic_enable_signs=1
" let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
" python already working with python-mode, vim-go also but not good enough
let g:syntastic_mode_map={ 'mode': 'active',
      \ 'active_filetypes': ['javascript', 'scala', 'go'],
      \ 'passive_filetypes': ['slim', 'haml', 'scss', 'css', 'html', 'less'] }
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_jshint_args = "--verbose"
let g:syntastic_scala_checkers = ['fsc', 'scalastyle']
let g:syntastic_scala_scalastyle_jar = '~/github/wuranbo/vim/thirdparty/scalastyle_2.10-0.6.0-batch.jar'
let g:syntastic_scala_scalastyle_config_file = '~/github/wuranbo/vim/thirdparty/scalastyle_config.xml'
"=======end syntastic=====
"
"=======nerdtree======
map <Leader>fl :NERDTreeToggle<CR>
"=======end nerdtree======
"
"======vim-go=====
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_functions = 1
let g:go_highlight_build_constraints = 1
au FileType go nmap <C-]> <Plug>(go-def-vertical)
au FileType go nmap <Leader>grn <Plug>(go-rename)
au FileType go nmap <Leader>gbr <Plug>(go-doc-browser)
au FileType go nmap <Leader>gim <Plug>(go-implements)
au FileType go nmap <Leader>gclr <Plug>(go-callers)
au FileType go nmap <Leader>gcle <Plug>(go-callees)
au FileType go nmap <Leader>gcls <Plug>(go-callstack)
au FileType go nmap <Leader>gclg <Plug>(go-callgraph)
"let g:go_orcale_scope = "yottabyte.cn/rizhiyi_manager/server"
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_auto_type_info = 1
let g:go_fmt_fail_silently = 1 " for syntastic
"======end vim-go======
"
"======http://www.vim.org/scripts/script.php?script_id=102=======
"======DirDiff====
let g:DirDiffIgnoreCase = 0
"======FileDiff====
":vertical diffsplit
":difthis  "比较已经打开的两个buf

" tips
" 1. '&' can use to repeat the last :%s
" 2. <C-a> on a number make it increase
" 3. zA, za 两个命令flod和unflod当前
" 4. 当expandtab打开，我们默认打开tab都转换为空格的情况下输入tab:
"    在insert模式下<C-v><TAB>
"    或者:set expandtab! 输入后:set expandtab
" 5. CRLF
"    :set ff=dos
"    :set ff=unix
"syntax off
