dotify-get-dotfile-path() {
  if [ -n "$DOTIFY_ATTR_DOTFILE_PATH" ]; then
    echo "$DOTIFY_ATTR_DOTFILE_PATH"
    return 0
  fi

  if [ -n "$ARG_DOTFILE" ]; then
    if [ -f "$ARG_DOTFILE" ]; then
      DOTIFY_ATTR_DOTFILE_PATH="$ARG_DOTFILE"
    else
      echo "ERROR: \"$ARG_DOTFILE\" does not exist." >&2
      return 1
    fi
  elif [ -f "$(pwd)/Dotfile" ]; then
    DOTIFY_ATTR_DOTFILE_PATH="$(pwd)/Dotfile"
  else
    echo "ERROR: \"$(pwd)\" does not have a Dotfile." >&2
    return 1
  fi

  echo "$DOTIFY_ATTR_DOTFILE_PATH"
}

dotify-valid-dotfile-path() {
  dotify-get-dotfile-path >/dev/null 2>&1
  return "$?"
}
