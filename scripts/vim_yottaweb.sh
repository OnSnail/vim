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
bash ~/github/wuranbo/vim/scripts/ctags_yottaweb.sh
vim --cmd "set path+=~/yottaweb" \
  --cmd "set wrap" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/git:/src/YottaWeb/:--full-name<CR>" \
  -c "au FileType python nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:/src/YottaWeb/:--python<CR>" \
  -c "au FileType javascript nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:/src/yottaweb/yottaweb/static/scripts:--js<CR>" \
  -c "au FileType html nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:/src/yottaweb/yottaweb/templates:--html<CR>" \
  -c "au FileType less nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:/src/yottaweb/yottaweb/static/less/:--less<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/yottaweb" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/yottaweb" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/yottaweb" \
  --cmd "autocmd FileType python set tags=~/yottaweb/tags" \
  --cmd "autocmd FileType javascript set tags=~/yottaweb/js_tags" \
  -S "~/.vim_sessions/yottaweb"
