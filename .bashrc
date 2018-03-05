# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias apt='sudo apt'
#alias cp="rsync -avz --progress"

alias startui='sudo systemctl start lightdm.service'
alias stopui='sudo systemctl stop lightdm.service'

alias raid='cat /proc/scsi/rr272x_1x/8'
alias suit='sudo !!'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

alias brc="vim ~/.bashrc"
alias vrc="vim ~/.vimrc"
alias src="source ~/.bashrc"

export MC="/raid/servers/ozone"
export WEB="/raid/servers/web"
export TPD="/raid/servers/tpd"
export SRV="/raid/servers/"

alias startradar='screen -dmS radarr mono --debug /opt/Radarr/Radarr.exe' 
alias startsonar='screen -dmS sonarr mono --debug /opt/NzbDrone/NzbDrone.exe' 
alias startjackett='cd /home/daniel/jackett; screen -dmS jackett mono --debug JackettConsole.exe'
alias startweb2='cd /raid/servers/web/;screen -dmSL webserver node serve.js'
alias startweb='cd /raid/servers/web/;pm2 start serve.js'
alias startmc='cd $MC;screen -dmS mc sudo bash *Server*.sh'
alias stopmc='screen -S mc -p 0 -X stuff "stop
"'
alias deltor='sudo rm -R /var/lib/transmission-daemon/downloads/*'

alias startfactorio="sudo runuser -l factorio -c '/raid/servers/factorio/factorio-init/factorio start'"
alias stopfactorio="sudo runuser -l factorio -c '/raid/servers/factorio/factorio-init/factorio stop'"

alias ps='sudo ps'
alias java='sudo java'

alias fixperm='sudo chown -R nobody:nogroup /raid/*'

export PS1="\h \e[30;1m\w\e[0m\n\$ "
export PATH=/usr/local/cuda-8.0/bin:$PATH
export PATH=/usr/local/cuda-9.0/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-8.0/lib64
export TRANS="/raid/downloads"

alias purgetrans='sudo rm -R /var/lib/transmission-daemon/downloads/movies* /var/lib/transmission-daemon/downloads/tv/*'
alias startmine='cd ~/ccminer; screen -dmS miner ./ccminer -o stratum+tcp://lyra2rev2.usa.nicehash.com:3347 -u 3AggDaER1hdHkJG8M3cV5MLiVPNW36Egbh -p x'

alias untargz="tar -xvzf"


alias sshsher="ssh -i /raid/documents/desktop/documents/sher.priv ubuntu@ec2-18-220-63-132.us-east-2.compute.amazonaws.com"
alias sshvamp="ssh -i /raid/documents/desktop/documents/vamp.priv ubuntu@vamperage.chickenkiller.com"
