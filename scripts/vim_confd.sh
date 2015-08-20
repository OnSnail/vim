if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/confd
    rm ~/.vim_viminfos/confd
    touch ~/.vim_viminfos/confd
    touch ~/.vim_sessions/confd
  fi
fi

cd /src/confd
bash ~/github/wuranbo/vim/scripts/ctags_confd.sh
vim --cmd "set path+=/src/confd" \
  --cmd "autocmd BufNewFile,BufRead *.tpl set filetype=html" \
  --cmd "autocmd BufNewFile,BufRead *.sample set filetype=dosini" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/git:/src/confd/:--full-name<CR>" \
  -c "nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:/src/confd/:--go<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/confd" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/confd" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/confd" \
  --cmd "autocmd FileType go set tags=/src/confd/tags" \
  --cmd 'command! Go silent exec "!go install github.com/wuranbo/confd > /dev/null 2>&1 &" | execute ":redraw!"' \
  -S "~/.vim_sessions/confd"
