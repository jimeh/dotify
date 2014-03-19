dotify-create-symlink() {
  local source="$1"
  local target="$2"

  if [ ! -e "$target" ] && [ ! -h "$target" ]; then
    ln -s "$source" "$target"
    echo "created"
    return 0
  elif [ -h "$target" ]; then
    if [ "$(readlink "$target")" == "$source" ]; then
      echo "exists"
      return 0
    else
      echo "ERROR: \"$target\" exists, is a symlink to:" \
        "$(readlink "$target")" >&2
      return 1
    fi
  else
    echo "ERROR: \"$target\" exists" >&2
    return 1
  fi
}
