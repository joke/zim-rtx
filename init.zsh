(( ${+commands[rtx]} )) && () {
  local command=${commands[rtx]}

  # generating activation file
  local activatefile=$1/rtx-activate.zsh
  if [[ ! -e $activatefile || $activatefile -ot $command ]]; then
    $command activate zsh >| $activatefile
    zcompile -UR $activatefile
  fi

  source $activatefile
  source <(rtx hook-env -s zsh | tee /dev/shm/tee)

  # generating completions
  local compfile=$1/functions/_rtx
  if [[ ! -e $compfile || $compfile -ot $command ]]; then
    $command complete --shell zsh >| $compfile
    print -u2 -PR "%F{green}! Detected a new version 'rtx'. Regenerated completions"
  fi
} ${0:h}