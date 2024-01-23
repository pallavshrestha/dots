#
# ~/.bashrc
#
#Defaults
export EDITOR=vim;
export VISUAL=vim;
# export BROWSER="usr/bin/librewolf"
export BROWSER='/usr/bin/qutebrowser'
export FZF_BIBTEX_CACHEDIR='$HOME/.local/cache'
export FZF_BIBTEX_SOURCES='$HOME/work/docVault/collections/library.bib:$HOME/work/notebooks/papers/global.bib'

################################################################################

# ALiases for AppImage
alias libreoffice='$HOME/applications/LibreOffice.AppImage'

# Aliases
alias nay='yay -Rns'
alias purge='yay -Rs $(yay -Qqtd)'
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
alias v='vim'
alias p='ipython'
alias r='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias z='devour zathura'
alias mpv='devour mpv'
alias top='btop'
alias htop='btop'
alias t='xfce4-terminal'
alias showorphans='pacman -Qtdq'
alias removeorphans='sudo pacman -Rns $(pacman -Qtdq)'
alias present='impressive --noquit --nologo --wrap' 
alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
#alias rclone-web='rclone rcd --rc-web-gui'

## Conda Aliases
alias maths='conda activate maths'
alias neural='conda activate neural'
alias lca='conda activate lca'
alias deconda='conda deactivate'



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

source ~/.config/powerline.sh

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


export PATH="$HOME/Applications:$PATH"
export PATH="$HOME/.local/bin:$PATH"


################################################################################

#pdf fzf integration
pdfzf () {
    open='devour xdg-open'   # this will open pdf file withthe default PDF viewer on KDE, xfce, LXDE and perhaps on other desktops.

    ag -U -g ".pdf$" \
    | fast-p \
    | fzf --read0 --reverse -e -d $'\t'  \
        --preview-window up:60% --preview '
            v=$(echo {q} | tr " " "|");
            echo -e {1}"\n"{2} | grep -E "^|$v" -i --color=always;
        ' \
    | cut -z -f 1 -d $'\t' | tr -d '\n' | xargs -r --null $open > /dev/null 2> /dev/null
} 


################################################################################

# ctrl+t fzf
#
# # ctrl+t fzf
__fzf_select__() {
  local cmd opts
  cmd="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | cut -b3-"}"
  opts="--height ${FZF_TMUX_HEIGHT:-40%} --bind=ctrl-z:ignore --reverse ${FZF_DEFAULT_OPTS-} ${FZF_CTRL_T_OPTS-} -m"
  eval "$cmd" |
    FZF_DEFAULT_OPTS="$opts" $(__fzfcmd) "$@" |
    while read -r item; do
      printf '%q ' "$item"  # escape special chars
    done
}


__fzfcmd() {
  [[ -n "${TMUX_PANE-}" ]] && { [[ "${FZF_TMUX:-0}" != 0 ]] || [[ -n "${FZF_TMUX_OPTS-}" ]]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

fzf-file-widget() {
  local selected="$(__fzf_select__ "$@")"
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}


__fzf_cd__() {
  local cmd opts dir
  cmd="${FZF_ALT_C_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | command cut -b3-"}"
  opts="--height ${FZF_TMUX_HEIGHT:-40%} --bind=ctrl-z:ignore --reverse ${FZF_DEFAULT_OPTS-} ${FZF_ALT_C_OPTS-} +m"
  dir=$(set +o pipefail; eval "$cmd" | FZF_DEFAULT_OPTS="$opts" $(__fzfcmd)) && printf 'builtin cd -- %q' "$dir"
}

 bind -m emacs-standard '"\er": redraw-current-line'

 bind -m vi-command '"\C-z": emacs-editing-mode'
 bind -m vi-insert '"\C-z": emacs-editing-mode'
 bind -m emacs-standard '"\C-z": vi-editing-mode'

  # CTRL-T - Paste the selected file path into the command line
 bind -m emacs-standard -x '"\C-t": fzf-file-widget'
 bind -m vi-command -x '"\C-t": fzf-file-widget'
 bind -m vi-insert -x '"\C-t": fzf-file-widget'
 #
 # CTRL-T - Paste the selected file path into the command line
 bind -m emacs-standard '"\ec": " \C-b\C-k \C-u`__fzf_cd__`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
 bind -m vi-command '"\ec": "\C-z\ec\C-z"'
 bind -m vi-insert '"\ec": "\C-z\ec\C-z"'

################################################################################

