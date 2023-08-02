## ▒███████ ████████░ ██ ██▀███ ▄████▄
## ▒ ▒ ▒ ▄▒██    ▓██░ ██▓██ ▒ █▒██▀ ▀█
## ░ ▒ ▄▀▒░ ▓██▄ ▒██▀▀██▓██ ░▄█▒▓█    ▄
##   ▄▀▒    ▒   █░▓█ ░██▒██▀▀█▄▒▓▓▄ ▄██
## ▒██████▒██████░▓█▒░██░██▓ ▒█▒ ▓███▀
## ░▒▒ ▓░▒▒ ▒▓▒ ▒ ▒ ░░▒░░ ▒▓ ░▒░ ░▒ ▒
## ░░▒ ▒ ░░ ░▒  ░ ▒ ░▒░ ░ ░▒ ░ ▒ ░  ▒
## ░ ░ ░ ░░  ░  ░ ░  ░░ ░ ░░   ░
##   ░ ░        ░ ░  ░  ░  ░   ░ ░
## ░                           ░

### Nifty third party tools
# Source plugins
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ~/.config/zsh/plugins/gitstatus/gitstatus.plugin.zsh

# Startup zoxide
eval "$(zoxide init zsh)"

# Needed for linting zsh in nvim?
zmodload zsh/zpty

# Setup fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

#Source ssh environment
source ~/.ssh/agent-environment > /dev/null

# Color support for ls, fd, etc
eval $(dircolors $XDG_CONFIG_HOME/zsh/dircolors)

### Zsh specific settings
# General opts
setopt autocd
setopt magicequalsubst
unsetopt beep notify

# History opts
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
#setopt SHARE_HISTORY
setopt histignorespace
setopt share_history

# Colors for prompt
autoload -U colors && colors

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

#Word Navigation
WORDCHARS=''
key[Alt-Left]="${terminfo[kLFT3]}"
key[Alt-Right]="${terminfo[kRIT3]}"

[[ -n "${key[Alt-Left]}"  ]] && bindkey -- "${key[Alt-Left]}"  backward-word
[[ -n "${key[Alt-Right]}" ]] && bindkey -- "${key[Alt-Right]}" forward-word

# Exit shell w/ ^D even if there is something in the command line
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

# Completion
autoload -Uz compinit; compinit
setopt complete_in_word
setopt completealiases
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' rehash true
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' separate-sections true
zstyle ':completion:*' insert-sections true
zstyle ':completion:*:default' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:options' list-colors '=^(-- *)=35'
zstyle ':completion:*:descriptions' format '%F{8}%B■%b%f %F{red}━━━[%f%d%F{red}]%f'
zstyle ':completion:*:messages' format '%F{8}%B■%b%f %F{red}━━━[%f%d%F{red}]%f'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

## Prompt stuff
# Helper functions for prompt
# determine cursor position to either start with/out newline
cup(){
  echo -ne "\033[6n" > /dev/tty
  read -t 1 -s -d 'R' line < /dev/tty
  line="${line##*\[}"
  line="${line%;*}"
  echo "$line"
}

#Collapse path to single chars if it gets too long
collapse_pwd() {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

#Truncate the dir path
truncated_pwd() {
  n=$1 # n = number of directories to show in full (n = 3, /a/b/c/dee/ee/eff)
  path=`collapse_pwd`

  # split our path on /
  dirs=("${(s:/:)path}")
  dirs_length=$#dirs

  if [[ $dirs_length -ge $n ]]; then
    # we have more dirs than we want to show in full, so compact those down
    ((max=dirs_length - n))
    for (( i = 1; i <= $max; i++ )); do
      step="$dirs[$i]"
      if [[ -z $step ]]; then
        continue
      fi
      if [[ $step =~ "^\." ]]; then
        dirs[$i]=$step[0,2] #make .mydir => .m
      else
        dirs[$i]=$step[0,1] # make mydir => m
      fi

    done
  fi

  echo ${(j:/:)dirs}
}

# Preexec function
setup() {
    # Change window title to current command right after command is inputted
    print -Pn "\e]0;$1\a"
}

# Classy touch inspired prompt
custom_prompt() {
    cmd_cde=$?
    # Set window title
    print -Pn "\e]2;%n@%M: %~\a"
  cpos=$(cup)
  case "$cpos" in
    1|2)
          PROMPT=""
      ;;
    *)
          PROMPT=$'\n'
      ;;
  esac
    PROMPT+="%{$fg[red]%}┏━"

    #Are we root?
    [ "$(id -u)" -eq 0 ] && PROMPT+="[%{$fg[white]%}root%{$fg[red]%}]%{%G━%}"

    #Current directory
    PROMPT+="[%{$fg[white]%}%{$(truncated_pwd 3)%}%{$fg[red]%}]"

    #Git status
    if gitstatus_query MY && [[ "$VCS_STATUS_RESULT" == ok-sync ]]; then
        if [[ -n "$VCS_STATUS_LOCAL_BRANCH" ]]; then
            PROMPT+="%{%G━%}[%{$fg[white]%}${${VCS_STATUS_LOCAL_BRANCH:-@${VCS_STATUS_COMMIT}}//\%/%%}" # escape backslash
        else
            PROMPT+="%{%G━%}%{$fg[white]%}@${${VCS_STATUS_COMMIT}//\%/%%}" # escape backslash
        fi
        (( VCS_STATUS_HAS_STAGED )) && PROMPT+=' +'
        (( VCS_STATUS_HAS_UNSTAGED )) && PROMPT+=' !'
        (( VCS_STATUS_HAS_UNTRACKED )) && PROMPT+=' ?'
        PROMPT+="%{$fg[red]%}]"
    fi

    # Background job indicator
    PROMPT+="%(1j.━[%{$reset_color%}⚙%F{1}]%f.)"

    if [ $cmd_cde -eq 0 ]; then
        PROMPT+=$'\n'"%{$fg[red]%}┗━━ %F{8}%B■%b%f %{$reset_color%}"
    else
        PROMPT+=$'\n'"%{$fg[red]%}┗━━ %{$reset_color%}%B■%b "
    fi

    setopt no_prompt_{bang,subst} prompt_percent  # enable/disable correct prompt expansions
}

gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'
autoload -Uz add-zsh-hook
add-zsh-hook preexec setup
add-zsh-hook precmd custom_prompt
export PROMPT2="%F{1}━━━━━%f %F{8}%B■%b%f%{$reset_color%} "

### General configs
#Icons for lf
source ~/.config/lf/lficons

### Aliases
alias svim='sudoedit'
alias l="exa -la --icons"
alias ip="ip --color=auto"
alias diff='diff --color=auto'
alias clip="xsel -ib --logfile /dev/null"
#alias clip="wl-copy"
alias cat="bat -p"
alias ls="exa"
alias scan="scanimage --device 'hpaio:/net/OfficeJet_3830_series?ip=192.168.0.4' --progress --format=png --output-file"
alias ncdu="ncdu --color dark"
# avoid typing the whole thing
alias halt="sudo halt"
alias poweroff="sudo poweroff"
alias reboot="sudo reboot"
alias shutdown="sudo shutdown"
alias zzz="sudo zzz"
alias ZZZ="sudo ZZZ"
alias xr="sudo xbps-remove -Ro"
alias xc="sudo xbps-remove -Oo"
alias xu='sudo xbps-install -Su'
alias xl='xbps-query -l'
alias xf='xbps-query -f'
alias xd='xbps-query -x'
alias xm='xbps-query -m'
alias xs='fuzzypkg'
alias clk='sudo vkpurge rm all'
alias tksv='tmux kill-server'
alias hc='herbstclient'
alias dotlink="stow --ignore='.git' --ignore='screenshots' --ignore='wallpapers' --ignore='.gitmodules' --ignore='.gitignore' --ignore='pkglist.txt' --ignore='README.md' -R --target=/home/barbaross -d /home/barbaross/Public/thonkpad-dotfiles ."
alias rpi="ssh -p 5522 barbaross@192.168.0.2"
alias sdf="ssh barbaross@sdf.org"
alias trp="trash-put"
alias trr="trash-restore"
alias tre="trash-empty"
alias ovpn="sudo openvpn --config /etc/openvpn/client/muspelheim.ovpn --askpass /etc/openvpn/client/muspelheim.pass --daemon"
alias kovpn="sudo pkill -INT openvpn"
alias wgu="sudo wg-quick up muspelheim"
alias wgd="sudo wg-quick down muspelheim"
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....="cd ../../../.."
alias _="sudo"
alias newsboat='newsboat -q'
alias cmus='tmux new-session -s Music "tmux source-file ~/.config/cmus/tmux_session"'
alias ncmpcpp='tmux new-session -s Music "tmux source-file ~/.config/ncmpcpp/tmux_session"'
alias bnps='java -jar ~/Public/font-stuff/BitsNPicas.jar'
alias usv="SVDIR=~/.local/service/active sv"
alias figlet="figlet -d ~/Public/font-stuff/figlet-fonts"
alias g="git"
alias gco="git checkout"
alias gb="git branch"
alias gc="git commit"
alias gp="git push"
alias ga="git add"
alias ugsm="git submodule foreach git pull"
alias rf="rm -rf"
alias clevgen="sudo clevis luks regen -d /dev/nvme0n1p2 -s 1"

### Functions
# Colorized man pages
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;40;35m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;33m") \
        man "$@"
}

lf() {
    tempfile="$(mktemp)"
   /usr/bin/lf -command "map Q \$echo \$PWD >$tempfile; /usr/bin/lf -remote \"send \$id quit\"" "$@"

    new_dir=$(cat "$tempfile")
    if [ "$new_dir" != "$(pwd)" ]; then
           cd "$new_dir" || return
   fi
   rm -f -- "$tempfile" 2>/dev/null
}

dotgit() {
    gitdir="/home/barbaross/Public/thonkpad-dotfiles/"
    git -C $gitdir add .
    git -C $gitdir commit -m "$*"
    git -C $gitdir push
}

# one off calculator
calc() {
    echo "scale=3;$@" | bc -l
}

# Cheat query
cht() {
    curl -s "cheat.sh/$(echo -n "$*" | jq -sRr @uri)"
}

# Send a spotdl command to remote server
sshpotdl() {
    ssh -p 5522 barbaross@192.168.0.2 -f "sh -c 'tsp /home/barbaross/.local/bin/spotdl --headless --output /var/lib/mpd/music download $@ >/dev/null 2>&1 &'"
}

font_preview() {
echo "

                0 1 2 3 4 5 6 7 8 9
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
a b c d e f g h i j k l m n o p q r s t u v w x y z
            ! @ # \$ % ^ & * ( ) _ + = -
                   , . / ; ' [ ]
                   < > ? : \" { }


"
}

### Internal zsh functions
# auto ls after a cd
chpwd() {
    exa --icons -a
}

command_not_found_handler() {
  printf "M'lord, thy command \033[0;31m%s\033[0m does not exist!\n" "$0" >&2

  suggestions=$(xlocate $0 2>/dev/null | grep ".*/bin/$0" | sed 's/^/    /')
  if [ -n "$suggestions" ]; then
    printf "\n%s\n" "Would one of these suffice, m'lord?:" >&2
    printf "%s\n" "$suggestions" >&2
  fi
  return 127
}
