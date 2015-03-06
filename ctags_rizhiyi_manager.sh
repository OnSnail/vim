cd ~/rizhiyi_manager/
rm tags
ack --ignore-dir=agent --ignore-dir=manager/static -f --type=go ./ > .tmp_filename_index
gotags -f ./tags -L .tmp_filename_index 2>&1 2>/dev/null
rm .tmp_filename_index

ack --ignore-dir=agent -f --type=js ./ > .tmp_filename_index
ctags --javascript-kinds=+fcmvp -L .tmp_filename_index -f .tmp_tag_files 2>&1 2>/dev/null
cat .tmp_tag_files >> ./tags
rm .tmp_tag_files
rm .tmp_filename_index
