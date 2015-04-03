if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

export PS1='\u@\h:\W$(vcprompt -f "[%n:%b%m]")\$ '

export EDITOR=nano

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
