export GOPATH=`godep path`:$HOME/goworkspace
export GO_INSTALL_HOME=/usr/local/go
export GO_ROOT=/usr/local/go
export SCALA_HOME=/usr/local/share/scala
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_65.jdk/Contents/Home
#这里很奇怪
#/usr/bin/java@ -> /System/Library/Frameworks/JavaVM.framework/Versions/Current/Commands/java
#继续可以看到一个/A的目录，当前which java的java -version 也是1.7.0_65
export CLICOLOR=1
#export C_INCLUDE_PATH=/usr/local/Cellar/imagemagick/6.8.7-0/include/ImageMagick:$C_INCLUDE_PATH

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

source "$HOME/.git-completion.bash"
#mysql
MYSQL=/usr/local/mysql/bin
#gitbin
GIT=/usr/local/git/bin
# ranbo
export PATH=$GO_INSTALL_HOME/bin:$MYSQL:$GIT:$HOME/bin:$HOME/pro/arcanist/arcanist/bin:$SCALA_HOME/bin:$PATH:$GOPATH/bin
#export PATH=$MYSQL:$GIT:$HOME/bin:/usr/local/bin:$PATH
#export PATH=$PATH:$HOME/pro/arcanist/arcanist/bin/
#export PATH=$PATH:$SCALA_HOME/bin
#export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
# .bashrc

# User specific aliases and functions

#sudo无密码
#sudo no password
# %wrb ALL=NOPASSWD: ALL
export SVN_EDITOR=vim
export GIT_EDITOR=vim
export VISUAL=vim
export EDITOR=vim
export HISTTIMEFORMAT='%Y-%m-%d-%H:%M:%S '
export LESSCHARSET=utf-8
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return
# Define to access remotely checked-out files over passwordless ssh for CVS
COMP_CVS_REMOTE=1
#
# Define to avoid stripping description in --option=description of './configure --help'
COMP_CONFIGURE_HINTS=1
#
# Define to avoid flattening internal contents of tar files
COMP_TAR_INTERNAL_PATHS=1

cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}


# source ~/.profile
# start content in ~/.profile
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
# end content in ~/.profile

#
alias less='less -r'                          # raw control characters
alias whence='type -a'                        # where, of a sort
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
alias ls='ls -hF'                 # classify files in colour
alias dir='ls'
alias vdir='ls'
alias ll='ls -lta'                              # long list
alias la='ls -A'                              # all but . and ..
alias l='ls -CF'                              #
#add by wuranbo
alias cd=cd_func
alias qgit='/Users/wrb/bin/qgit.app/Contents/MacOS/qgit'
alias git-graph='git log --pretty=format:"%d %h (%cd)%s" --date=short --decorate=short --graph'

alias 50='ssh root@192.168.1.50'
alias 44='ssh root@192.168.1.44'
alias 70='ssh root@192.168.1.70'
alias 72='ssh root@192.168.1.72'
alias 22='ssh root@192.168.1.22'
alias 23='ssh root@192.168.1.23'
alias 32='ssh root@192.168.1.32'
alias 27='ssh root@192.168.1.27'
alias 91='ssh root@192.168.1.91'
alias 29='ssh root@192.168.1.29'
alias maichuang92='ssh -p36899 rd@211.157.169.92'
alias skjkj='ssh root@182.92.1.108'
alias ctags='ctags --links=no'
alias jshint='jshint --verbose'
#
# Qu Jing iTerm & Terminal Setup Script
# version 0.4
# Felix Ding
# Nov 18, 2014
#
# function start_qujing {
  # export http_proxy='http://theironislands.f.getqujing.net:31149'
  # export HTTPS_PROXY='http://theironislands.f.getqujing.net:31149'
# }
