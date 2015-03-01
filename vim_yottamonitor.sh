if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/yottamonitor
    rm ~/.vim_viminfos/yottamonitor
    touch ~/.vim_viminfos/yottamonitor
    touch ~/.vim_sessions/yottamonitor
  fi
fi

cd ~/yottamonitor
bash ~/github/wuranbo/vim/ctags_yottamonitor.sh
vim --cmd "set tags=~/yottamonitor/tags" \
  --cmd "set path+=~/yottamonitor" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/async:!<CR>" \
  -c "nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:~/yottamonitor:--python<CR>" \
  -c "nnoremap <silent> <Leader>gjs  :<C-u>Unite -smartcase -start-insert grep:~/yottamonitor/static/scripts:--js<CR>" \
  -c "nnoremap <silent> <Leader>ghm  :<C-u>Unite -smartcase -start-insert grep:~/yottamonitor/templates:--html<CR>" \
  -c "nnoremap <silent> <Leader>gcs  :<C-u>Unite -smartcase -start-insert grep:~/yottamonitor/static/less/:--less<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/yottamonitor" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/yottamonitor" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/yottamonitor" \
  -S "~/.vim_sessions/yottamonitor"
