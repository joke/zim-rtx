(( ${+commands[rtx]} || ${+commands[asdf]} && ${+functions[_direnv_hook]} )) && () {

  local command=${commands[rtx]:-"$(${commands[asdf]} which rtx 2> /dev/null)"}
  [[ -z $command ]] && return 1

  eval "$($command activate zsh)"

  local compfile=$1/functions/_rtx
  if [[ ! -e $compfile || $compfile -ot $command ]]; then
    $command complete --shell zsh >| $compfile
    zimfw check-dumpfile
  fi
} ${0:h}
