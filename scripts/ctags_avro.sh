cd ~/goworkspace/src/github.com/wuranbo/goavro/
rm tags
ack -f --type=python ./lang/py > .tmp_filename_index
ctags --python-kinds=-i -L .tmp_filename_index 2>&1 2>/dev/null
rm .tmp_filename_index

