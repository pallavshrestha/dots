#
# ~/.bashrc
#
##############
#  Defaults  #
##############

export EDITOR=vim;
export VISUAL=vim;
# export BROWSER="usr/bin/librewolf"
export BROWSER='/usr/bin/qutebrowser'
export PATH="$HOME/Applications:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.config/scripts:$PATH"
export BAT_THEME="Nord"
export TERMINAL='alacritty'
export FZF_COMPLETION_TRIGGER='**'
export FZF_COMPLETION_OPTS="--preview 'fzf-preview.sh {}'"

################################################################################

#############
#  Aliases  #
#############

alias nay='yay -Rns'
alias purge='yay -Rs $(yay -Qqtd)'
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
alias v='vim'
alias P='ipython'
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias z='devour zathura'
alias m='devour mpv'
alias top='btop'
alias htop='btop'
alias feh='feh --conversion-timeout 1'
alias t='$TERMINAL &'
alias showorphans='pacman -Qtdq'
alias removeorphans='sudo pacman -Rns $(pacman -Qtdq)'
alias present='impressive --noquit --nologo --wrap' 
alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
alias ytfzf='ytfzf -u umpv'

## Conda Aliases
alias maths='conda activate maths'
alias neural='conda activate neural'
alias lca='conda activate brightway2'
alias deconda='conda deactivate'

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

# pipx completions
eval "$(register-python-argcomplete pipx)"


################################################################################
neofetch() {
    # Define the list of arguments
    local args=("tree" "oni" "trollface" "trollface_alt" "witcher" "witcher_small" "darkos")

    # Get a random index
    local random_index=$(( RANDOM % ${#args[@]} ))

    # Call neofetch with the random argument
    command neofetch --ascii_distro "${args[$random_index]}"
}
