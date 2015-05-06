if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/goavro
    rm ~/.vim_viminfos/goavro
    touch ~/.vim_viminfos/goavro
    touch ~/.vim_sessions/goavro
  fi
fi

cd /Users/wrb/goworkspace/src/github.com/wuranbo/goavro
bash ~/github/wuranbo/vim/scripts/ctags_goavro.sh
vim --cmd "set path+=~/goworkspace/src/github.com/wuranbo/goavro" \
  --cmd "autocmd BufNewFile,BufRead *.tpl set filetype=html" \
  --cmd "autocmd BufNewFile,BufRead *.sample set filetype=dosini" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/git:/Users/wrb/github/wuranbo/goavro/:<CR>" \
  -c "nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:/Users/wrb/github/wuranbo/goavro/:--go<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/goavro" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/goavro" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/goavro" \
  --cmd "autocmd FileType go set tags=~/github/wuranbo/goavro/tags" \
  -S "~/.vim_sessions/goavro"
