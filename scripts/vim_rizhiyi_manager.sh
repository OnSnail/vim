if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/rizhiyi_manager
    rm ~/.vim_viminfos/rizhiyi_manager
    touch ~/.vim_viminfos/rizhiyi_manager
    touch ~/.vim_sessions/rizhiyi_manager
  fi
fi
# <buffer> in map is import!!!make a key bind only work for the current buffer filetype
cd /Users/wrb/goworkspace/src/yottabyte.cn/rizhiyi_manager
bash ~/github/wuranbo/vim/scripts/ctags_rizhiyi_manager.sh
vim --cmd "set path+=~/goworkspace/src/yottabyte.cn/rizhiyi_manager" \
  --cmd "set path+=~/goworkspace/src" \
  --cmd "autocmd BufNewFile,BufRead *.html set filetype=htmlgo" \
  --cmd "autocmd BufNewFile,BufRead *.sample set filetype=dosini" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/git:/Users/wrb/goworkspace/src/yottabyte.cn/rizhiyi_manager:<CR>" \
  -c "au FileType go nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:/Users/wrb/goworkspace/src/yottabyte.cn/rizhiyi_manager:--go<CR>" \
  -c "au FileType htmlgo nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:/Users/wrb/goworkspace/src/yottabyte.cn/rizhiyi_manager/server/views:--html<CR>" \
  -c "au FileType sass nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:/Users/wrb/goworkspace/src/yottabyte.cn/rizhiyi_manager/server/sass:--sass<CR>" \
  -c "au FileType javascript <buffer> nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:/Users/wrb/goworkspace/src/yottabyte.cn/rizhiyi_manager/server/js:--js<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/rizhiyi_manager" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/rizhiyi_manager" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/rizhiyi_manager" \
  --cmd "autocmd FileType go set tags=~/rizhiyi_manager/tags" \
  --cmd "autocmd FileType javascript set tags=~/rizhiyi_manager/js_tags" \
  -S "~/.vim_sessions/rizhiyi_manager"
