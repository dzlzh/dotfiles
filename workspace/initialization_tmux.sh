#!/bin/sh

# 兼容zsh
export DISABLE_AUTO_TITLE="true"
# tmux path
cmd=$(which tmux)
# session name
session="dzl"
# 配置文件地址
conf="./wrokspace.tmux.conf"

if [ -z $cmd ]; then
    echo "You need to install tmux."
    exit 1
fi

$cmd has -t $session 2> /dev/null

if [ $? -ne 0 ]; then
    $cmd -f $conf new -d -n workspace -s $session 
    # $cmd neww -n zsh -t $session
    # $cmd selectw -t $session:2
fi

$cmd att -t $session

exit 0
