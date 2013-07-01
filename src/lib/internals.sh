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

locate-target() {
  if [ -n "$TARGET" ]; then
    if [ ! -d "$TARGET" ]; then
      echo "ERROR: Target \"$TARGET\" is not a directory." >&2
      return 1
    fi
  elif [ -n "$HOME" ] && [ -d "$HOME" ]; then
    TARGET="$HOME"
  elif [ -d ~ ]; then
    TARGET=~
  else
    echo "ERROR: Your \$HOME folder could not be found." >&2
    return 1
  fi
}

create-symlink() {
  local source="$1"
  local target="$2"
}

execute-dotfile() {
  parse-dotfile-rootlink
  ROOTDIR="$(dirname "$DOTFILE")"

  local cwd="$(pwd)"
  cd "$rootdir"

  create-symlink "$rootdir" "$TARGET/$ROOTLINK"
  if [ -n "$?" ]; then return 1; fi

  while read line; do
    parse-dotfile-line "$line"
    if [ -n "$?" ]; then return 1; fi
  done < "$DOTFILE"

  cd "$cwd"
}

parse-dotfile-rootlink() {
  while read line; do
    if [[ "$line" == "root_link "* ]]; then
      ROOTLINK="$(trim "${line/#root_link /}")"
      break
    fi
  done < "$DOTFILE"

  if [ -z "$ROOTLINK" ]; then ROOTLINK=".dotfiles"; fi
  echo "$ROOTLINK"
}

parse-dotfile-line() {
  local line="$1"
  local dotfile="$DOTFILE"
  if [ -n "$2" ]; then dotfile="$2"; fi

  # Ignore comment lines starting with "#".
  if [[ "$line" == "#"* ]]; then return 0; fi

  # Ignore root link command.
  if [[ "$line" == "root_link "* ]]; then return 0; fi

  # Handle include command.
  if [[ "$line" == "include "* ]]; then
    include-dotfile "$(trim "${line/#include /}")"
    return "$?"
  fi

  echo "$line"
}

include-dotfile() {
  local dotfile="$1"

  local cwd="$(pwd)"
  cd "$rootdir"

  if [ ! -f "$dotfile" ]; then
    echo "ERROR: Can not include \"$dotfile\", it does not exist." >&2
    return 1
  fi

  while read line; do
    parse-dotfile-line "$line" "$dotfile"
    if [ -n "$?" ]; then return 1; fi
  done < "$dotfile"

  cd "$cwd"
}
