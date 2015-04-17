if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/wetalk
    rm ~/.vim_viminfos/wetalk
    touch ~/.vim_viminfos/wetalk
    touch ~/.vim_sessions/wetalk
  fi
fi

cd /Users/wrb/goworkspace/src/github.com/beego/wetalk
bash ~/github/wuranbo/vim/scripts/ctags_wetalk.sh
vim --cmd "set path+=~/goworkspace/src/github.com/beego/wetalk" \
  --cmd "autocmd BufNewFile,BufRead *.tpl set filetype=html" \
  --cmd "autocmd BufNewFile,BufRead *.sample set filetype=dosini" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/git:/Users/wrb/goworkspace/src/github.com/beego/wetalk/:<CR>" \
  -c "nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:/Users/wrb/goworkspace/src/github.com/beego/wetalk/:--go<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/wetalk" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/wetalk" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/wetalk" \
  --cmd "autocmd FileType go set tags=~/goworkspace/src/github.com/beego/wetalk/tags" \
  -S "~/.vim_sessions/wetalk"
