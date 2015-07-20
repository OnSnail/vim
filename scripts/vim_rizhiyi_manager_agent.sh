if [ $# -eq 1 ]; then
  if [ $1 = clear ]; then
    echo '!!!clear session and viminfo!!!'
    rm ~/.vim_sessions/rizhiyi_manager_agent
    rm ~/.vim_viminfos/rizhiyi_manager_agent
    touch ~/.vim_viminfos/rizhiyi_manager_agent
    touch ~/.vim_sessions/rizhiyi_manager_agent
  fi
fi

cd ~/yottabyte/src/rizhiyi_manager_agent
bash ~/github/wuranbo/vim/scripts/ctags_rizhiyi_manager_agent.sh
vim -c "set tags=~/yottabyte/src/rizhiyi_manager_agent/tags" \
  -c "set path+=~/yottabyte/src/rizhiyi_manager_agent" \
  -c "nnoremap <silent> <F5>  :<C-u>Unite -smartcase -buffer-name=files -start-insert file_rec/git:/src/rizhiyi_manager_agent/:--full-name<CR>" \
  -c "nnoremap <F3>  :<C-u>Unite -smartcase -start-insert grep:/src/rizhiyi_manager_agent/:--python<CR>" \
  -c "autocmd VimLeavePre * :mksession!  ~/.vim_sessions/rizhiyi_manager_agent" \
  -c "autocmd VimLeavePre * :wviminfo ~/.vim_viminfos/rizhiyi_manager_agent" \
  -c "autocmd VimEnter * :rviminfo ~/.vim_viminfos/rizhiyi_manager_agent" \
  -S "~/.vim_sessions/rizhiyi_manager_agent"
