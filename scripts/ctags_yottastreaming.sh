cd ~/yottastreaming
rm tags
ack -f --type=scala ~/yottastreaming/src/main/scala/cn/yottabyte > .tmp_filename_index
ctags -L .tmp_filename_index 2>&1 2>/dev/null
rm .tmp_filename_index
