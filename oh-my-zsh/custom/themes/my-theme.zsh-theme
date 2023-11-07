PROMPT='
'
PROMPT+='%{$fg[yellow]%}[%D{%L:%M:%S}]%{$reset_color%} '
PROMPT+='%{$fg_bold[cyan]%}%~%{$reset_color%} '
PROMPT+='$(git_prompt_info)'
PROMPT+='
%{$fg_bold[green]%}$%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
