PROMPT='
[%{$fg[white]%}%n@%m %{$fg_bold[cyan]%}${PWD/#$HOME/~}%{$reset_color%}$(git_prompt_info)] %{$reset_color%}
%{$fg_bold[white]%}λ%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[green]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} ✗%{$fg_bold[green]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=")"
