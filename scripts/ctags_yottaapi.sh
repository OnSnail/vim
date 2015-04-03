cd ~/yottaapi/
rm tags
ack --ignore-dir=db --ignore-dir=config --ignore-dir=yottaapi.egg-info --ignore-dir=yottaapi/bin --ignore-dir=yottaapi/include --ignore-dir=yottaapi/lib  -f --type=python ./ > .tmp_filename_index
ctags --python-kinds=-i -L .tmp_filename_index 2>&1 2>/dev/null
rm .tmp_filename_index
