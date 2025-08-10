if [ "$USERNAME" = "root" ]; then CARETCOLOR="red"; else CARETCOLOR="blue"; fi

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT='%{$fg[green]%}[%D{%H:%M:%S}]%{$reset_color%} %{$fg_no_bold[cyan]%}%n@%m%{$reset_color%} %{${fg[green]}%}%3~ »%{${reset_color}%} '

RPS1="${return_code}"

#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}‹"
#ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
