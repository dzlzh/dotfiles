#!/bin/sh

# 兼容zsh
export DISABLE_AUTO_TITLE="true"
# tmux path
cmd=$(which tmux)
# session name
session="dzl"
# 配置文件地址
conf="./wrokspace.tmux.conf"
# window name
workspace="workspace"

if [ -z $cmd ]; then
    echo "You need to install tmux."
    exit 1
fi

$cmd has -t $session

if [ $? -ne 0 ]; then
    $cmd -f $conf new -d -n $workspace -s $session 
    $cmd splitw -t $session:$workspace
    $cmd splitw -t $session:$workspace
    $cmd send -t $session:$workspace.1 'vim'
    $cmd selectl -t $workspace main-horizontal 
    $cmd selectw -t $session:1
fi

$cmd att -t $session

exit 0
