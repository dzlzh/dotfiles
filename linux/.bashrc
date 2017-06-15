alias l="ls -a"
alias la="ls -al"
alias w="cd /d/Workspace"
function git_branch {
   branch="`git branch 2>/dev/null | grep "^\*" | sed -e "s/^\*\ //"`"
   if [ "${branch}" != "" ];then
       if [ "${branch}" = "(no branch)" ];then
           branch="(`git rev-parse --short HEAD`...)"
       fi
       echo " ($branch)"
   fi
}

# export PS1="\[\033[01;34m\][\d] \[\033[01;36m\]\w\[\033[01;32m\]$(git_branch)\[\033[00m\]\n\$ "
export PS1='\[\033[01;34m\][\d] \[\033[01;36m\]\w\n\[\033[01;31m\]\$\[\033[00m\] '

