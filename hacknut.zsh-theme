function ruby_prompt {
  which rvm-prompt &> /dev/null && echo $(rvm-prompt i v g) && return
  which rbenv &> /dev/null && echo $(rbenv version | sed -e "s/ (set.*$//") && return
}

DISABLE_UNTRACKED_FILES_DIRTY="false"

ZSH_THEME_PROMPT_SEPARATOR="%{$reset_color%}%{$fg[magenta]%} ¦ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

# Customized git status
git_custom_status() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
      echo "$(parse_git_dirty)$(current_branch)$ZSH_THEME_PROMPT_SEPARATOR"
  fi
}

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '○'
}

function monokai_timestamp {
    echo "%{$FX[bold]%}%{$fg[white]%}%*%{$FX[no-bold]%}"
}

function monokai_dir {
    echo "%{$fg[cyan]%}%c%  %{$reset_color%}"
}

RPROMPT='%{$reset_color%}$(monokai_timestamp)$ZSH_THEME_PROMPT_SEPARATOR%{$fg[blue]%}$(ruby_prompt)%{$reset_color%} $EPS1'
PROMPT='$(git_custom_status)$(monokai_dir)%{$fg[magenta]%}$(prompt_char)%{$reset_color%} '
