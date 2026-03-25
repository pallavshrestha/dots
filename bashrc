#
# ~/.bashrc
#
##############
#  Defaults  #
##############

export EDITOR=vim;
export VISUAL=vim;
export BROWSER='/usr/bin/qutebrowser'
export PATH="$HOME/Applications:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.config/scripts:$PATH"
export PATH=$PATH:$(find $HOME/.config/scripts -type d) # subdirectories include
export TERMINAL='xdg-terminal-exec'
export FZF_COMPLETION_TRIGGER='**'
export FZF_COMPLETION_OPTS="--preview 'fzf-preview.sh {}'"

################################################################################

#############
#  Aliases  #
#############

alias rm='rm -i'
alias nay='yay -Rns'
alias purge='yay -Rns $(yay -Qqtd)'
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
alias v='vim'
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias z='hide zathura'
alias top='btop'
alias htop='btop'
alias t='$TERMINAL &'
alias showorphans='pacman -Qtdq'
alias removeorphans='sudo pacman -Rns $(pacman -Qtdq)'
alias clear="printf '\033[2J\033[3J\033[1;1H'"
# alias ef='xdg-open'
alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
alias ytfzf='ytfzf -u umpv'
alias mvi='mpv -profile image'
alias img='swayimg'
alias ff='fastfetch'
alias fi2en='argos-translate -f fi -t en'
alias en2fi='argos-translate -f en -t fi'


## Ledger Aliases
alias ledg='ledger -f $HOME/work/vaults/personal.ldg'
alias pers='vim $HOME/work/vaults/personal.ldg'

## Conda Aliases
alias maths='conda activate maths'
alias deconda='conda deactivate'

## Niri dynamic cast
alias dyncast-pick='niri msg action set-dynamic-cast-window --id $(niri msg --json pick-window | jq .id)'
alias dyncast-window='niri msg action set-dynamic-cast-window'
alias dyncast-monitor='niri msg action set-dynamic-cast-monitor'
alias dyncast-clear='niri msg action clear-dynamic-cast-target'

#############
#  Sources  #
#############

source ~/.config/powerline.sh
source ~/.config/scripts.sh

################################################################################
# If not running interactively, don't do anything
[[ $- != *i* ]] && return


#function _update_ps1() {
#    PS1=$(powerline-shell $?)
#}
#
#if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi

#_set_liveuser_PS1() {
#    PS1='[\u@\h \W]\$ '
#}

################################################################################

################################################################################
alias ls='ls --color=auto'
alias ll='ls -lavh --ignore=..'   # show long listing of all except ".."
alias l='ls -lavh --ignore=.?*'   # show long listing but no hidden dotfiles except "."

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

################################################################################

_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1:
    #    - Do not use for executable files!
    # Note2:
    #    - Uses 'mime' bindings, so you may need to use
    #      e.g. a file manager to make proper file bindings.

    if [ -x /usr/bin/exo-open ] ; then
        echo "exo-open $@" >&2
        setsid exo-open "$@" >& /dev/null
        return
    fi
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return
    fi

    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}


################################################################################

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/conda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/conda/etc/profile.d/conda.sh" ]; then
        . "$HOME/conda/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/conda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


################################################################################
neofetch() {
    # Define the list of arguments
    local args=("tree" "oni" "trollface" "trollface_alt" "witcher" "witcher_small" "darkos")

    # Get a random index
    local random_index=$(( RANDOM % ${#args[@]} ))

    # Call neofetch with the random argument
    command neofetch --ascii_distro "${args[$random_index]}"
}

################################################################################
#######################################################################
#                             Completions                             #
#######################################################################

# pipx completions
eval "$(register-python-argcomplete pipx)"

 source ~/.config/bash/git-completion.bash
