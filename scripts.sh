#
# ~/.config/bashrc


################################################################################

#########
#  fzf  #
#########


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
if [[ $- = *i* ]]
then
    # Required to refresh the prompt after fzf
    bind -m emacs-standard '"\er": redraw-current-line'
     
    
    bind -m vi-command '"\C-z": emacs-editing-mode'
    bind -m vi-insert '"\C-z": emacs-editing-mode'
    bind -m emacs-standard '"\C-z": vi-editing-mode'
    
    # CTRL-T - Paste the selected file path into the command line
    if [[ "${FZF_CTRL_T_COMMAND-x}" != "" ]]; then
      bind -m emacs-standard -x '"\C-t": fzf-file-widget'
      bind -m vi-command -x '"\C-t": fzf-file-widget'
      bind -m vi-insert -x '"\C-t": fzf-file-widget'
    fi
    
    # ALT-C - cd into the selected directory
    if [[ "${FZF_ALT_C_COMMAND-x}" != "" ]]; then
      bind -m emacs-standard '"\ec": " \C-b\C-k \C-u`__fzf_cd__`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
      bind -m vi-command '"\ec": "\C-z\ec\C-z"'
      bind -m vi-insert '"\ec": "\C-z\ec\C-z"'
    fi
fi

################################################################################

##########################
#  todos show and count  #
##########################

# showing and counting todos using silversurfer (ag)
todos() {
    if [ -z "$1" ]; then
        ag todo:
        echo
        echo $(ag todo:|wc -l) "tasks"
        echo $(ag x\]todo:|wc -l) "completed"
        echo $(ag  \]todo:|wc -l) "remaining"
    else 
        ag -numbers todo: "$1"
        echo
        echo $(ag todo: "$1"|wc -l) "todos"
        echo $(ag x\]todo: "$1"|wc -l) "done"
        echo $(ag ' \]todo:' "$1"|wc -l) "remaining"
    fi
}


############################
#  fix tlmgr after update  #
############################

# script to re"f@#K" tlmgr which get f@#K everytime tex distrbution is updated
tex-update(){
    TEXMFDIST="/usr/share/texmf-dist"
    sudo sed -i 's/\$Master = "\$Master\/..\/..";/\$Master = "\$Master\/..\/..\/..";/' "$TEXMFDIST/scripts/texlive/tlmgr.pl"
}
