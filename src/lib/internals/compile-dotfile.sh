compile-dotfile() {
  local dotfile="$1"
  if [ -z "$dotfile" ]; then dotfile="$DOTFILE"; fi

  if [ ! -f "$dotfile" ]; then
    echo "ERROR: \"$dotfile\" does not exist." >&2
    return 1
  fi

  local output=""
  local line=""
  while IFS= read line; do
    # Ignore comments and blank lines.
    if [[ "$line" =~ ^(\ *\#.*|\ *)$ ]]; then
      continue

    # Parse "<action>: <source> -> <target>" lines.
    elif [[ "$line" =~ ^(\ +)?([a-zA-Z0-9_-]+):\ (.+)\ +-[\>]\ +(.+)$ ]]; then
      output="${output}${BASH_REMATCH[1]}dotify-action ${BASH_REMATCH[2]} "
      output="${output}$(trim "${BASH_REMATCH[3]}") "
      output="${output}$(trim "${BASH_REMATCH[4]}")\n"

    # Parse "<action>: -> <target>" lines.
    elif [[ "$line" =~ ^(\ +)?([a-zA-Z0-9_-]+):\ *-[\>]\ +(.+)$ ]]; then
      output="${output}${BASH_REMATCH[1]}dotify-action ${BASH_REMATCH[2]} "
      output="${output}$(trim "${BASH_REMATCH[3]}")\n"

    # Parse "<source> -> <target>" lines.
    elif [[ "$line" =~ ^(\ +)?(.+)\ -[\>]\ (.+)$ ]]; then
      output="${output}${BASH_REMATCH[1]}dotify-action default "
      output="${output}$(trim "${BASH_REMATCH[2]}") "
      output="${output}$(trim "${BASH_REMATCH[3]}")\n"

    # Parse "-> <target>" lines.
    elif [[ "$line" =~ ^(\ +)?-[\>]\ (.+)$ ]]; then
      output="${output}${BASH_REMATCH[1]}dotify-action default "
      output="${output}$(trim "${BASH_REMATCH[2]}")\n"

    # Append line without modifications.
    else
      output="${output}${line}\n"
    fi
  done < "$dotfile"

  echo -e "$output"
}
