if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/rizhiyi_manager
    rm ~/.vim_viminfos/rizhiyi_manager
    touch ~/.vim_viminfos/rizhiyi_manager
    touch ~/.vim_sessions/rizhiyi_manager
  fi
fi

cd ~/rizhiyi_manager
bash ~/github/wuranbo/vim/ctags_rizhiyi_manager.sh
vim --cmd "set tags=~/rizhiyi_manager/tags" \
  --cmd "set path+=~/rizhiyi_manager/server" \
  --cmd "autocmd BufNewFile,BufRead *.tpl set filetype=html" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/async:~/rizhiyi_manager/server/:<CR>" \
  -c "nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:~/rizhiyi_manager/server/:--go<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/rizhiyi_manager" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/rizhiyi_manager" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/rizhiyi_manager" \
  -S "~/.vim_sessions/rizhiyi_manager"
