locate-dotfile() {
  local dotfile
  if [ -n "$DOTFILE" ]; then
    dotfile="$DOTFILE"
    if [ ! -f "$dotfile" ]; then
      echo "ERROR: \"$dotfile\" does not exist." >&2
      return 1
    fi
  elif [ -f "$(pwd)/Dotfile" ]; then
    dotfile="$(pwd)/Dotfile"
  else
    echo "ERROR: \"$(pwd)\" does not have a Dotfile." >&2
    return 1
  fi

  echo "$dotfile"
}

locate-target() {
  local target
  if [ -n "$DOTFILE" ]; then
    target="$TARGET"
    if [ ! -d "$target" ]; then
      echo "ERROR: Target \"$target\" is not a directory." >&2
      return 1
    fi
  elif [ -n "$HOME" ] && [ -d "$HOME" ]; then
    target="$HOME"
  elif [ -d ~ ]; then
    target=~
  else
    echo "ERROR: Your \$HOME folder could not be found." >&2
    return 1
  fi

  echo "$target"
}

create-rootlink() {
  local root="$1"
  local rootlink="$2"
}

create-symlink() {
  local source="$1"
  local target="$2"
}

parse-dotfile() {
  local dotfile="$1"
  local target="$2"
  local rootlink="$(parse-dotfile-rootlink "$dotfile")"

  local rootdir="$(dirname "$dotfile")"
  local cwd="$(pwd)"
  cd "$rootdir"

  create-rootlink "$rootdir" "$target/$rootlink"
  if [ -n "$?" ]; then return 1; fi

  while read line; do
    parse-dotfile-line "$dotfile" "$target" "$rootdir" "$rootlink" "$line"
    if [ -n "$?" ]; then return 1; fi
  done < "$dotfile"

  cd "$cwd"
}

parse-dotfile-rootlink() {
  local dotfile="$1"
  local rootlink

  while read line; do
    if [[ "$line" == "root_link "* ]]; then
      rootlink=${line/#root_link /}
      break
    fi
  done < "$dotfile"

  if [ -z "$rootlink" ]; then rootlink=".dotfiles"; fi

  echo "$root_link"
}

parse-dotfile-line() {
  local dotfile="$1"
  local target="$2"
  local rootdir="$3"
  local rootlink="$4"
  local line="$5"

  # Ignore comment lines starting with "#".
  if [[ "$line" == "#"* ]]; then return 0; fi

  # Ignore root link command.
  if [[ "$line" == "root_link "* ]]; then return 0; fi

  # Handle include command.
  if [[ "$line" == "include "* ]]; then
    include-dotfile "${line/#include /}" "$target" "$rootdir" "$rootlink"
    return "$?"
  fi

  echo "$line"
}

include-dotfile() {
  local dotfile="$1"
  local target="$2"
  local rootdir="$3"
  local rootlink="$4"

  local cwd="$(pwd)"
  cd "$rootdir"

  if [ ! -f "$dotfile" ]; then
    echo "ERROR: Can not include \"$dotfile\", it does not exist." >&2
    return 1
  fi

  while read line; do
    parse-dotfile-line "$dotfile" "$target" "$rootdir" "$rootlink" "$line"
    if [ -n "$?" ]; then return 1; fi
  done < "$dotfile"

  cd "$cwd"
}
