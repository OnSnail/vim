if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/avro
    rm ~/.vim_viminfos/avro
    touch ~/.vim_viminfos/avro
    touch ~/.vim_sessions/avro
  fi
fi

cd /Users/wrb/goworkspace/src/github.com/wuranbo/avro
bash ~/github/wuranbo/vim/scripts/ctags_avro.sh
vim --cmd "set path+=~/goworkspace/src/github.com/wuranbo/avro" \
  --cmd "autocmd BufNewFile,BufRead *.tpl set filetype=html" \
  --cmd "autocmd BufNewFile,BufRead *.sample set filetype=dosini" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/git:/Users/wrb/github/wuranbo/avro/:<CR>" \
  -c "nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:/Users/wrb/github/wuranbo/avro/:--python<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/avro" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/avro" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/avro" \
  --cmd "autocmd FileType python set tags=~/github/wuranbo/avro/tags" \
  -S "~/.vim_sessions/avro"
