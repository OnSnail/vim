if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/yottaweb
    rm ~/.vim_viminfos/yottaweb
    touch ~/.vim_viminfos/yottaweb
    touch ~/.vim_sessions/yottaweb
  fi
fi

cd ~/yottaweb
./ctags.sh
vim -c "set tags=~/yottaweb/tags" \
  -c "set path+=~/yottaweb" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/async:!<CR>" \
  -c "nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:~/yottaweb:--" \
  -c "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/yottaweb" \
  -c "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/yottaweb" \
  -c "autocmd VimEnter * :rviminfo ~/.vim_viminfos/yottaweb" \
  -S "~/.vim_sessions/yottaweb"
