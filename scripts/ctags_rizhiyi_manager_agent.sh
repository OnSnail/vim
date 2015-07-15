cd ~/yottabyte/src/rizhiyi_manager_agent/
rm tags
ack --ignore-dir=rizhiyi/java --ignore-dir=rizhiyi/license --ignore-dir=rizhiyi_manager_agent/python  -f --type=python ./ > .tmp_filename_index
ctags --python-kinds=-i -L .tmp_filename_index 2>&1 2>/dev/null
rm .tmp_filename_index
