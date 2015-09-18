if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/logparser
    rm ~/.vim_viminfos/logparser
    touch ~/.vim_viminfos/logparser
    touch ~/.vim_sessions/logparser
  fi
fi

LOGPARSER_PATH=/src/yotta_backends/log_parser/
cd $LOGPARSER_PATH
bash ~/github/wuranbo/vim/scripts/ctags_logparser.sh
vim --cmd "set tags=~/logparser/tags" \
  --cmd "set path=/src/yotta_elasticsearch/" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/git:${LOGPARSER_PATH}:--full-name<CR>" \
  -c "nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:${LOGPARSER_PATH}:--scala<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/logparser" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/logparser" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/logparser" \
  -S "~/.vim_sessions/logparser"
