if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/confd
    rm ~/.vim_viminfos/confd
    touch ~/.vim_viminfos/confd
    touch ~/.vim_sessions/confd
  fi
fi

cd /Users/wrb/goworkspace/src/github.com/wuranbo/confd
bash ~/github/wuranbo/vim/scripts/ctags_confd.sh
vim --cmd "set path+=~/goworkspace/src/github.com/wuranbo/confd" \
  --cmd "autocmd BufNewFile,BufRead *.tpl set filetype=html" \
  --cmd "autocmd BufNewFile,BufRead *.sample set filetype=dosini" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/git:/Users/wrb/github/wuranbo/confd/:--full-name<CR>" \
  -c "nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:/Users/wrb/github/wuranbo/confd/:--go<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/confd" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/confd" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/confd" \
  --cmd "autocmd FileType go set tags=~/github/wuranbo/confd/tags" \
  -S "~/.vim_sessions/confd"
