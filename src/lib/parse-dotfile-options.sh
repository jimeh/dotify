parse-dotfile-options() {
  OPT_ROOT_LINK="$(parse-dotfile-root_link-option)"
  OPT_DEFAULT_ACTION="$(parse-dotfile-default_action-option)"
}

parse-dotfile-root_link-option() {
  local dotfile="$DOTFILE"
  if [ -n "$1" ]; then dotfile="$1"; fi

  # Set default.
  local root_link=".dotfiles"

  while read line; do
    if [[ "$line" == "root_link "* ]]; then
      root_link="$(trim "${line/#root_link /}")"
      break
    fi
  done < "$dotfile"

  echo "$root_link"
}

parse-dotfile-default_action-option() {
  local dotfile="$DOTFILE"
  if [ -n "$1" ]; then dotfile="$1"; fi

  # Set default value.
  default_action="link"

  while read line; do
    if [[ "$line" == "default_action "* ]]; then
      default_action="$(trim "${line/#default_action /}")"
      break
    fi
  done < "$dotfile"

  echo "$default_action"
}
