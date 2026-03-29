# edit of Sunaku's theme 
# Removed git related markings as they're not relevant for me (except branch)
# kept them here though just in case (note: changed !? -> mu)
# changed > to $
# ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}+"
# ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[magenta]%}m"
# ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}-"
# ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}>"
# ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}#"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%}u"

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

local user_color='green'
test $UID -eq 0 && user_color='red'

PROMPT='%(?..%{$fg_bold[red]%}exit %?
%{$reset_color%})'\
'%{$bold_color%}$(git_prompt_status)%{$reset_color%}'\
'$(git_prompt_info)'\
'%{$fg[$user_color]%}%~%{$reset_color%}'\
' %(!.#.$) '

PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
