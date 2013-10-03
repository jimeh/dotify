locate-dotfile() {
  if [ -n "$DOTFILE" ]; then
    if [ ! -f "$DOTFILE" ]; then
      echo "ERROR: \"$DOTFILE\" does not exist." >&2
      return 1
    fi
  elif [ -f "$(pwd)/Dotfile" ]; then
    DOTFILE="$(pwd)/Dotfile"
  else
    echo "ERROR: \"$(pwd)\" does not have a Dotfile." >&2
    return 1
  fi
}
