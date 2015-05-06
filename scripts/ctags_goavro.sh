cd ~/goworkspace/src/github.com/wuranbo/goavro/
rm tags
ack --ignore-dir=examples -f --type=go ./ > .tmp_filename_index
gotags -f ./tags -L .tmp_filename_index 2>&1 2>/dev/null
rm .tmp_filename_index
