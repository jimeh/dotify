dotify-create-symlink() {
  local source="$1"
  local target="$2"

  if [ ! -e "$target" ] && [ ! -h "$target" ]; then
    ln -s "$source" "$target"
    echo "   create: $target --> $source"
    return 0
  elif [ -h "$target" ]; then
    local link_source="$(readlink "$target")"
    if [ "$link_source" == "$source" ]; then
      echo "   exists: $target"
      return 0
    else
      echo "   exists: $target -- is symlink to: $link_source"
      return 1
    fi
  else
      echo "   exists: $target -- is a regular file/folder"
    return 2
  fi
}
