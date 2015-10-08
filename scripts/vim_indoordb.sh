if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/indoordb
    rm ~/.vim_viminfos/indoordb
    touch ~/.vim_viminfos/indoordb
    touch ~/.vim_sessions/indoordb
  fi
fi
SRCDIR=/Users/wrb/src/indoordb/indoordb
cd $SRCDIR
bash $SRCDIR/ctags_indoordb.sh

vim -c "nnoremap <silent> <Leader>ff :Unite -input=${SRCDIR} file<CR>" \
  -c "set tags=${SRCDIR}/tags"  \
  -c "set path+=${SRCDIR}" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/git:${SRCDIR}:--full-name<CR>" \
  -c "au FileType ruby nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:${SRCDIR}:--ruby<CR>" \
  -c "au FileType scss nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:${SRCDIR}/app/assets/stylesheets:--sass<CR>" \
  -c "au FileType javascript nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:${SRCDIR}/app/assets/javascripts:--js<CR>" \
  -c "au FileType eruby.html nnoremap <buffer> <F3>  :<C-u>Unite -smartcase -start-insert grep:${SRCDIR}/app/views:--ruby<CR>" \
  --cmd "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/indoordb" \
  --cmd "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/indoordb" \
  --cmd "autocmd VimEnter * :rviminfo ~/.vim_viminfos/indoordb" \
  -S "~/.vim_sessions/indoordb"
