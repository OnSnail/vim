cd ~/indoordb/
rm tags
ctags -a --Ruby-kinds=+f -o tags -R ./app/ -R ./lib/ -R ./config/ 2>&1 2>/dev/null
# ripper-tags -R ./app/ -R ./lib
