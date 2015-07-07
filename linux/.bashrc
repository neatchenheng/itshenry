# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# User specific aliases and functions
umask 022

unalias -a

alias ls='ls --color --classify'
alias la='ls -a --color --classify'
alias lls='ls -l -h --color --classify --time-style=long-iso'
alias lrs='ls -R --color --classify'
alias rm='rm -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias cp='cp -ir'
alias zip='zip -9 -r'
alias cd..='cd ..'
alias grep='grep --color=always'
alias a2ps='a2ps --tabsize=4'
alias fold='fold -s'
alias vi='vim'

alias duc='du -h --max-depth=1'
alias dus='du -sh'
alias dfl='df -lh'
alias pss="ps --user=$USER fo pid,bsdstart,%cpu,%mem,vsz,rss,args"
alias psa="ps -e fo user,pid,%cpu,%mem,args"
alias ct="more"
alias pyps="ps -ef | grep python | grep -v grep"
alias nt='netstat -an |awk "/^tcp/ {++S[$NF]} END {for (a in S) print a, S[a]}"'

# List of colours that work on IRIX X-Terms
# Black       0;30     Dark Gray     1;30
# Red         0;31     Light Red     1;31
# Green       0;32     Light Green   1;32
# Brown       0;33     Yellow        1;33
# Blue        0;34     Light Blue    1;34
# Purple      0;35     Light Purple  1;35
# Cyan        0;36     Light Cyan    1;36
# Light Gray  0;37     White         1;37

#alias dark_echo="echo -e -n '\E[1;30;40m'"
#alias red_echo="echo -e -n '\E[1;31;40m'"
#alias green_echo="echo -e -n '\E[1;32;40m'"
#alias yellow_echo="echo -e -n '\E[1;33;40m'"
#alias blue_echo="echo -e -n '\E[1;34;40m'"
#alias purple_echo="echo -e -n '\E[1;35;40m'"
#alias cyan_echo="echo -e -n '\E[1;36;40m'"

BLACK="\[\033[0;30m\]"
DARK_GRAY="\[\033[1;30m\]"
RED="\[\033[0;31m\]"
LIGHT_RED="\[\033[1;31m\]"
GREEN="\[\033[0;32m\]"
LIGHT_GREEN="\[\033[1;32m\]"
BROWN="\[\033[0;33m\]"
YELLOW="\[\033[1;33m\]"
BLUE="\[\033[0;34m\]"
LIGHT_BLUE="\[\033[1;34m\]"
PURPLE="\[\033[0;35m\]"
LIGHT_PURPLE="\[\033[1;35m\]"
CYAN="\[\033[0;36m\]"
LIGHT_CYAN="\[\033[1;36m\]"
LIGHT_GRAY="\[\033[0;37m\]"
WHITE="\[\033[1;37m\]"

NORMAL_TEXT="\[\033[0m\]"

TITLEBAR='\[\033]0;\u @ \h\007\]'

PS1="$TITLEBAR\
$CYAN[\
$YELLOW\t$NORMAL_TEXT:\
$LIGHT_RED\w\
$CYAN]\
$NORMAL_TEXT "

PS2=">>"

export PS1 PS2

LS_COLORS='no=00:fi=00:di=36:ln=32:pi=40;33:so=35:bd=40;33;01:cd=40;33;01:ex=32'
LS_COLORS="${LS_COLORS}:*.tar=31:*.jar=31:*.tgz=31:*.arj=31:*.taz=31:*.zip=31:*.z=31:*.gz=31:*.bz2=31:*.rar=31"
LS_COLORS="${LS_COLORS}:*.exe=1;32:*.com=1;32:*.sh=1;32:*.bat=1;32"
LS_COLORS="${LS_COLORS}:*.dvi=33:*.ps=33:*.eps=33:*.pdf=33"
LS_COLORS="${LS_COLORS}:*.fig=1;34:*.jpg=1;34:*.jpeg=1;34:*.gif=1;34:*.bmp=1;34:*.xbm=1;34:*.xpm=1;34:*.tif=1;34:*.png=1;34"
LS_COLORS="${LS_COLORS}:*.txt=1;35:*.h=35:*.H=35:*.c=1;35:*.cc=1;35:*.C=1;35:*.CC=1;35:*.cpp=1;35:*.java=1;35:*.html=1;35:*.htm=1;35:*.tex=1;35:*.bib=1;35:*.sql=1;35"
export LS_COLORS


#PATH=$PATH:/home/henry/bin/depot_tools:/home/henry/bin/node-v0.10.29-linux-x64/bin
ANDROID_SDK_HOME=/home/henry/Dlibs/android-sdk-linux
NDK_HOME=/home/henry/Dlibs/android-ndk-r10d
JAVA_HOME=/home/henry/Dlibs/jdk1.7.0_71
PATH=$JAVA_HOME/bin:$JAVA_HOME/jre/bin:$ANDROID_SDK_HOME/tools:$ANDROID_SDK_HOME/platform-tools:$PATH:$NDK_HOME
export JAVA_HOME PATH NDK_HOME
