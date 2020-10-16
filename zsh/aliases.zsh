alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

alias q=exit
alias clr=clear
alias sudo='sudo '
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias wget='wget -c'

alias mk=make
alias rcp='rsync -vaP --delete'
alias rmirror='rsync -rtvu --delete'
alias gurl='curl --compressed'

alias y='xclip -selection clipboard -in'
alias p='xclip -selection clipboard -out'

alias sc=systemctl
alias ssc='sudo systemctl'

if command -v exa >/dev/null; then
  alias exa="exa --group-directories-first";
  alias l="exa -1";
  alias ll="exa -lg";
  alias la="LC_COLLATE=C exa -la";
fi

autoload -U zmv

take() {
  mkdir "$1" && cd "$1";
}; compdef take=mkdir

zman() {
  PAGER="less -g -s '+/^       "$1"'" man zshall;
}

r() {
  local time=$1; shift
  sched "$time" "notify-send --urgency=critical 'Reminder' '$@'; ding";
}; compdef r=sched

# TMUX
alias ta='tmux attach'
alias tl='tmux ls'

if [[ -n $TMUX ]]; then # From inside tmux
  alias tf='tmux find-window'
  # Detach all other clients to this session
  alias mine='tmux detach -a'
  # Send command to other tmux window
  tt() {
    tmux send-keys -t .+ C-u && \
      tmux set-buffer "$*" && \
      tmux paste-buffer -t .+ && \
      tmux send-keys -t .+ Enter;
  }
  # Create new session (from inside one)
  tn() {
    local name="${1:-`basename $PWD`}"
    TMUX= tmux new-session -d -s "$name"
    tmux switch-client -t "$name"
    tmux display-message "Session #S created"
  }
else # From outside tmux
  # Start grouped session so I can be in two different windows in one session
  tdup() { tmux new-session -t "${1:-`tmux display-message -p '#S'`}"; }
fi

# GIT
g() { [[ $# = 0 ]] && git status --short . || git $*; }

alias git='noglob git'
alias ga='git add'
alias gap='git add --patch'
alias gb='git branch -av'
alias gop='git open'
alias gbl='git blame'
alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gcf='git commit --fixup'
alias gcl='git clone'
alias gco='git checkout'
alias gcoo='git checkout --'
alias gf='git fetch'
alias gi='git init'
alias gl='git log --graph --pretty="format:%C(yellow)%h%Creset %C(red)%G?%Creset%C(green)%d%Creset %s %Cblue(%cr) %C(bold blue)<%aN>%Creset"'
alias gll='git log --pretty="format:%C(yellow)%h%Creset %C(red)%G?%Creset%C(green)%d%Creset %s %Cblue(%cr) %C(bold blue)<%aN>%Creset"'
alias gL='gl --stat'
alias gp='git push'
alias gpl='git pull --rebase --autostash'
alias gs='git status --short .'
alias gss='git status'
alias gst='git stash'
alias gr='git reset HEAD'
alias grv='git rev-parse'
