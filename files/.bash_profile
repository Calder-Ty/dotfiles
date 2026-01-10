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
    # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	export PS1="\[\033[34m\]\u\[$(tput sgr0)\]: \[$(tput sgr0)\]\[\033[32m\]\W\[$(tput sgr0)\] \\$ \[$(tput sgr0)\]" 
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

bold () {
	echo $(fmt "\e[1m" $@)
}

italic () {
	echo $(fmt "\e[3m" $@)
}


strikethrough () {
	echo $(fmt "\e[9m" $@)
}

cyan () {
	echo $(fmt "\e[36m" $@)
}

red () {
	echo $(fmt "\e[31m" $@)
}


green () {
	echo $(fmt "\e[32m" $@)
}


yellow () {
	echo $(fmt "\e[33m" $@)
}

fmt () {
	echo "$@\e[0m"
}

say_login_greeting () {

	echo -e "$(bold OS):  $(head -1 /etc/os-release | cut -d= -f2 | tr -d '"')"
	echo -e "$(bold 'Uptime'):  $(uptime -p)"
	echo ""
	echo -e "$(italic $(sort ~/.greetings -R | head -n 1))"
}

say_login_greeting

unset say_login_greeting
unset say_login_greeting
unset bold
unset italic
unset strikethrough
unset cyan
unset red
unset green
unset yellow
unset fmt


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

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


export EDITOR=vim
export PATH="~/.local/bin:$PATH"
# Get rid of undesired folders for fzf
export FZF_DEFAULT_COMMAND='ag -l --ignore ".git" --hidden -g ""'
export FZF_CTRL_T_COMMAND='fd --hidden --exclude .git'

# use neovim for manpager
export MANPAGER="nvim +Man!"


pyenv () {
	if [[ $# -eq  1 ]]; then
		selected=$1
	else
		selected=$(find ~/Envs/ -mindepth 1 -maxdepth 1 -type d | fzf --tmux)
	fi

	if [[ -z $selected ]]; then
		return 0
	fi

	. $selected/bin/activate
}



[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Otherwise start tmux
tmux_installed=$(which tmux)
if [[ -z "$TMUX"  ]] && [[ -n $tmux_installed ]]; then
	exec tmux -2
fi

