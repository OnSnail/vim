cd ~/yottaweb/
rm tags
ack --ignore-dir=yottaweb/static/assets --ignore-dir=yottaweb/bin --ignore-dir=yottaweb/lib --ignore-dir=yottaweb/include --ignore-dir=yottaweb/var --ignore-dir=yottaweb/test --ignore-dir=yottaweb/static/css -f --type=python ./ > .tmp_filename_index
ctags --python-kinds=-i+vcfm -L .tmp_filename_index 2>&1 2>/dev/null
rm .tmp_filename_index

ack --ignore-dir=yottaweb/static/assets --ignore-dir=yottaweb/bin --ignore-dir=yottaweb/lib --ignore-dir=yottaweb/include --ignore-dir=yottaweb/var --ignore-dir=yottaweb/test --ignore-dir=yottaweb/static/css -f --type=js ./ > .tmp_filename_index
ctags --javascript-kinds=+fcmvp -L .tmp_filename_index -f .tmp_tag_files 2>&1 2>/dev/null
cat .tmp_tag_files >> ./tags
rm .tmp_tag_files
rm .tmp_filename_index
