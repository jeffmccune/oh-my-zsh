PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}$(vi_mode_prompt_info)'

# local git_branch='$(git_prompt_status)%{$reset_color%}$(git_prompt_info)%{$reset_color%}'

local return_code='%(?..%{$fg[red]%}%? ↵%{$reset_color%})'
local rvm='%{$fg[blue]%}%{$fg[cyan]%}$(rvm-prompt i v g)%{$blue%}%{$reset_color%}'
RPROMPT="${return_code}  ${rvm} "

# zle-keymap-select() {
#   VIMODE="${${KEYMAP/vicmd/☍ }/(main|viins)/}"
#   zle reset-prompt
# }

# zle -N zle-keymap-select

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

# vim:ft=zsh
