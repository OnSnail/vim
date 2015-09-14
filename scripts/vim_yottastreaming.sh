if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/yottastreaming
    rm ~/.vim_viminfos/yottastreaming
    touch ~/.vim_viminfos/yottastreaming
    touch ~/.vim_sessions/yottastreaming
  fi
fi

STRAMING_PATH=/src/yotta_backends/log_streaming/
cd $STRAMING_PATH
bash ~/github/wuranbo/vim/scripts/ctags_yottastreaming.sh
vim --cmd "set tags=~/yottastreaming/tags" \
  --cmd "set path=/src/yotta_elasticsearch/" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/git:${STRAMING_PATH}:--full-name<CR>" \
  -c "nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:${STRAMING_PATH}:--scala<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/yottastreaming" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/yottastreaming" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/yottastreaming" \
  -S "~/.vim_sessions/yottastreaming"
