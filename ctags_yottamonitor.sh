cd ~/yottamonitor/
rm tags
ack --ignore-dir=server --ignore-dir=influxdb --ignore-dir=pymysql --ignore-dir=requests --ignore-dir=static/assets --ignore-dir=static/css --ignore-dir=static/less --ignore-dir=tools --ignore-dir=web -f --type=python ./ > .tmp_filename_index
ctags --python-kinds=-i+vcfm -L .tmp_filename_index 2>&1 2>/dev/null
rm .tmp_filename_index

ack --ignore-dir=server --ignore-dir=influxdb --ignore-dir=pymysql --ignore-dir=requests --ignore-dir=static/assets --ignore-dir=static/css --ignore-dir=static/less --ignore-dir=tools --ignore-dir=web -f --type=js ./ > .tmp_filename_index
ctags --javascript-kinds=+fcmvp -L .tmp_filename_index -f .tmp_tag_files 2>&1 2>/dev/null
cat .tmp_tag_files >> ./tags
rm .tmp_tag_files
rm .tmp_filename_index
