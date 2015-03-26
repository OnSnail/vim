if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/rizhiyi_manager
    rm ~/.vim_viminfos/rizhiyi_manager
    touch ~/.vim_viminfos/rizhiyi_manager
    touch ~/.vim_sessions/rizhiyi_manager
  fi
fi

cd /Users/wrb/goworkspace/src/yottabyte.cn/rizhiyi_manager
bash ~/github/wuranbo/vim/ctags_rizhiyi_manager.sh
vim --cmd "set path+=~/rizhiyi_manager" \
  --cmd "set path+=~/goworkspace/src" \
  --cmd "autocmd BufNewFile,BufRead *.tpl set filetype=html" \
  --cmd "autocmd BufNewFile,BufRead *.sample set filetype=dosini" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/git:/Users/wrb/yottabyte/src/rizhiyi_manager/:<CR>" \
  -c "nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:/Users/wrb/yottabyte/src/rizhiyi_manager/server/:--go<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/rizhiyi_manager" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/rizhiyi_manager" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/rizhiyi_manager" \
  --cmd "autocmd FileType go set tags=~/rizhiyi_manager/tags" \
  --cmd "autocmd FileType javascript set tags=~/rizhiyi_manager/js_tags" \
  -S "~/.vim_sessions/rizhiyi_manager"
