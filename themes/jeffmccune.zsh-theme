# JJM Notes About the Prompt
# http://zshwiki.org/home/config/prompt
#
# * Wrap color variables inside of %{%} in order to allow zsh to accurately
# determine the length of the prompt.
#
# * Prompt expansion characters:
#   http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
#
# * Use print -P '[%n]' to preview an expansion character.
#
# * A multi-line right prompt (RPROMPT) is not easily possible.
#
# * To get a sense of the colors available:
#   for k v in ${(kv)fg} ${(kv)fg_bold}; print -- $v$k

local return_code='%(?..%{$fg[red]%}%? ↵%{$reset_color%})'

# TESTING:

# My Prompt Variables and Functions (I try and mix and match these)
function dirname_prompt() {
  local parent
  parent="$(dirname $(print -P %4~))"
  if [[ $parent == '.' ]]; then
    return 0
  elif [[ $parent == '/' ]]; then
    return 0
  else
    echo "${parent}%{$reset_color%}/"
  fi
}

function envpuppet_yellow() {
  if [[ ${+ENVPUPPET_BASEDIR} == '0' ]]; then
    echo "%{$fg[yellow]%}"
  else
    echo "%{$fg[green]%}"
  fi
}

# Colors of things

# This one is a little weird.  My goal is to draw attention to the directory I'm in
# since it "grows right" in the prompt and ALSO only display 3 path elements.
local fs_path='%{$reset_color%}%{$fg_bold[grey]%}$(dirname_prompt)%{$fg_bold[blue]%}%1~%{$reset_color%}'

# RVM.
# The idea behind this prompt is that envpuppet is important to me, but not so
# important that it needs a character.  It's almost always used in conjunction
# with rvm so changing the color of the rvm prompt is an option.  Yellow is a
# warning "something isn't right" but not so different from white that it's
# obnoxious.
function jeff_rvm_prompt() {
  local rvm_prompt="$(rvm-prompt v g)"
  if [[ -n $rvm_prompt ]]; then
    echo "%{$reset_color%}$(envpuppet_yellow)${rvm_prompt}%{$reset_color%} "
  fi
}

function jeff_git_prompt() {
  local p_git="$(git_prompt_info)"
  if [[ -n $p_git ]]; then
    echo "${p_git} "
  fi
}

# The idea behind this is that the general form takes:
# [user@host]
# * Don't draw too much attention to this part of the prompt.
# * If we're effectively root, draw much more attention.
local user_host='%{$fg[blue]%}[%{$reset_color%}%0(#,%{$fg_bold[cyan]%},%{$fg_bold[blue]%})%n%{$reset_color%}%{$fg[grey]%}@%{$reset_color%}%{$fg_bold[blue]%}%m%{$reset_color%}%{$fg[blue]%}]%{$reset_color%}'

local p_rvm='$(jeff_rvm_prompt)'
local p_git='$(jeff_git_prompt)'

PROMPT="$user_host ${p_git}${p_rvm}${fs_path} ${return_code}
%# "

# PROMPT='%{$fg[cyan]%}%2~ %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} %# %{$reset_color%}$(vi_mode_prompt_info)'
# RPROMPT="${return_code} ${rvm} "

## GIT Prompt Wrapping:

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}(%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$reset_color%})(%{$fg[red]%}dirty%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%})(%{$fg[green]%}clean%{$reset_color%})"

## VIM Mode: (No longer in use)
# zle-keymap-select() {
#   VIMODE="${${KEYMAP/vicmd/☍ }/(main|viins)/}"
#   zle reset-prompt
# }
# zle -N zle-keymap-select

# vim:ft=zsh
