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
bash ~/github/wuranbo/vim/ctags_yottaweb.sh
vim --cmd "set tags=~/yottaweb/tags" \
  --cmd "set path+=~/yottaweb" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/git:/Users/wrb/yottabyte/src/YottaWeb/:<CR>" \
  -c "nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:/Users/wrb/yottabyte/src/YottaWeb/:--python<CR>" \
  -c "nnoremap <silent> <Leader>gjs  :<C-u>Unite -smartcase -start-insert grep:/Users/wrb/yottabyte/src/yottaweb/yottaweb/static/scripts:--js<CR>" \
  -c "nnoremap <silent> <Leader>ghm  :<C-u>Unite -smartcase -start-insert grep:/Users/wrb/yottabyte/src/yottaweb/yottaweb/templates:--html<CR>" \
  -c "nnoremap <silent> <Leader>gcs  :<C-u>Unite -smartcase -start-insert grep:/Users/wrb/yottabyte/src/yottaweb/yottaweb/static/less/:--less<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/yottaweb" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/yottaweb" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/yottaweb" \
  -S "~/.vim_sessions/yottaweb"
