if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/rizhiyi_manager
    rm ~/.vim_viminfos/rizhiyi_manager
    touch ~/.vim_viminfos/rizhiyi_manager
    touch ~/.vim_sessions/rizhiyi_manager
  fi
  if [ $1 = rebuild ]; then
    go install yottabyte.cn/rizhiyi_manager/server
  fi
  if [ $1 = rebuildall ]; then
    # 当保存文件自动synstatic太慢时候使用
    go install -a yottabyte.cn/rizhiyi_manager/server
    rm ~/.vim_sessions/rizhiyi_manager
    rm ~/.vim_viminfos/rizhiyi_manager
    touch ~/.vim_viminfos/rizhiyi_manager
    touch ~/.vim_sessions/rizhiyi_manager
  fi
fi
# <buffer> in map is import!!!make a key bind only work for the current buffer filetype
cd /src/rizhiyi_manager
bash ~/github/wuranbo/vim/scripts/ctags_rizhiyi_manager.sh
# 需要看html的snippet怎么导入htmlgo
vim --cmd "set path+=~/rizhiyi_manager" \
  --cmd "autocmd BufNewFile,BufRead *.html set filetype=htmlgo.html" \
  --cmd "autocmd BufNewFile,BufRead *.sample set filetype=dosini" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/git:/src/rizhiyi_manager:--full-name<CR>" \
  -c "au FileType go nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:/src/rizhiyi_manager:--go<CR>" \
  -c "au FileType htmlgo.html nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:/src/rizhiyi_manager/server/views:--html<CR>" \
  -c "au FileType scss nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:/src/rizhiyi_manager/server/sass:--sass<CR>" \
  -c "au FileType javascript nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:/src/rizhiyi_manager/server/js:--js<CR>" \
  -c "au FileType json nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:/src/rizhiyi_manager/server/conf/avro/:<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/rizhiyi_manager" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/rizhiyi_manager" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/rizhiyi_manager" \
  --cmd "autocmd FileType go set tags=~/rizhiyi_manager/tags" \
  --cmd "autocmd FileType javascript set tags=~/rizhiyi_manager/js_tags" \
  -S "~/.vim_sessions/rizhiyi_manager"
