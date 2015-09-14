if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/rizhiyi_manager
    rm ~/.vim_viminfos/rizhiyi_manager
    touch ~/.vim_viminfos/rizhiyi_manager
    touch ~/.vim_sessions/rizhiyi_manager
  fi
  if [ $1 = rebuild ]; then
    go get -a yottabyte.cn/rizhiyi_manager/server
    go install -a yottabyte.cn/rizhiyi_manager/server
  fi
fi
# <buffer> in map is import!!!make a key bind only work for the current buffer filetype
SRCDIR=/src/rizhiyi_manager
# SRCDIR=/Users/wrb/goworkspace/src/yottabyte.cn/rizhiyi_manager
cd $SRCDIR
bash ~/github/wuranbo/vim/scripts/ctags_rizhiyi_manager.sh
# 需要看html的snippet怎么导入htmlgo
vim --cmd "set path+=/src/rizhiyi_manager" \
  --cmd "autocmd BufNewFile,BufRead *.html set filetype=htmlgo.html" \
  --cmd "autocmd BufNewFile,BufRead *.sample set filetype=dosini" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/git:${SRCDIR}:--full-name<CR>" \
  -c "au FileType go nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:${SRCDIR}:--go<CR>" \
  -c "au FileType htmlgo.html nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:${SRCDIR}/server/views:--html<CR>" \
  -c "au FileType scss nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:${SRCDIR}/server/sass:--sass<CR>" \
  -c "au FileType javascript nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:${SRCDIR}/server/js:--js<CR>" \
  -c "au FileType json nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:${SRCDIR}/server/conf/avro/:<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/rizhiyi_manager" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/rizhiyi_manager" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/rizhiyi_manager" \
  --cmd "autocmd FileType go set tags=~/rizhiyi_manager/tags" \
  --cmd "autocmd FileType javascript set tags=~/rizhiyi_manager/js_tags" \
  --cmd 'command! Go silent exec "!go install yottabyte.cn/rizhiyi_manager/server > /dev/null 2>&1 &" | execute ":redraw!"' \
  -S "~/.vim_sessions/rizhiyi_manager"
# NOTE:
# --cmd 'command! Go silent exec "!go install yottabyte.cn/rizhiyi_manager/server > /dev/null 2>&1 &" | execute ":redraw!"' \
# 是为了install一次，go install 不加-a不会全重编，只编变动部分。
# 而synstatic插件如果不利用install过的库来加速就太慢，所以如没有这样就跨模块的synx错误检查不出来。
