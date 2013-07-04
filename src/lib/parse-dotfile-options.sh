# Parse Dotfile options and set relevant global variables.
parse-dotfile-options() {
  OPT_ROOT_LINK="$(parse-dotfile-root_link-option)"
  OPT_DEFAULT_ACTION="$(parse-dotfile-default_action-option)"
}

# Extract a specific option from Dotfile.
#
# Arguments:
#   - $1: Name of option to extract.
#   - $2: (optional) Default value of option if not present in Dotfile.
#   - $3: (optional) Specific Dotfile to read. Uses $DOTFILE if empty.
#
parse-dotfile-option() {
  local name="$1"
  local value="$2"
  local dotfile="$3"
  if [ -z "$dotfile" ]; then dotfile="$DOTFILE"; fi

  while read line; do
    if [[ "$line" == "$name "* ]]; then
      value="$(trim "${line/#$name }")"
      break
    fi
  done < "$dotfile"

  echo "$value"
}

parse-dotfile-root_link-option() {
  echo "$(parse-dotfile-option "root_link" ".dotfiles" "$1")"
}

parse-dotfile-default_action-option() {
  echo "$(parse-dotfile-option "default_action" "link" "$1")"
}
