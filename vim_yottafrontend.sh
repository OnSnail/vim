if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/yottafrontend
    rm ~/.vim_viminfos/yottafrontend
    touch ~/.vim_viminfos/yottafrontend
    touch ~/.vim_sessions/yottafrontend
  fi
fi

cd ~/yottafrontend
bash ~/github/wuranbo/vim/ctags_yottafrontend.sh
vim --cmd "set tags=~/yottafrontend/tags" \
  --cmd "set path+=~/yottafrontend" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/async:~/yottafrontend/src/<CR>" \
  -c "nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:~/yottafrontend:--scala<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/yottafrontend" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/yottafrontend" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/yottafrontend" \
  -S "~/.vim_sessions/yottafrontend"
