cd ~/goworkspace/src/github.com/beego/wetalk/
rm tags
ack --ignore-dir=Godeps --ignore-dir=docc -f --type=go ./ > .tmp_filename_index
gotags -f ./tags -L .tmp_filename_index 2>&1 2>/dev/null
rm .tmp_filename_index
