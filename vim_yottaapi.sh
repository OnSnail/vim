if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/yottaapi
    rm ~/.vim_viminfos/yottaapi
    touch ~/.vim_viminfos/yottaapi
    touch ~/.vim_sessions/yottaapi
  fi
fi

cd ~/yottaapi
./ctags.sh
vim -c "set tags=~/yottaapi/tags" \
  -c "set path+=~/yottaapi" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/async:!<CR>" \
  -c "nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:~/yottaapi:--python" \
  -c "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/yottaapi" \
  -c "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/yottaapi" \
  -c "autocmd VimEnter * :rviminfo ~/.vim_viminfos/yottaapi" \
  -S "~/.vim_sessions/yottaapi"
