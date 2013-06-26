dotify-info() {
  local dotfile="$(locate-dotfile "$@")"
  if [ -z "$dotfile" ]; then return 1; fi

  local target="$(locate-target "$@")"
  if [ -z "$target" ]; then return 1; fi

  echo "dotify $(dotify-version)"
  echo "  Dotfile: $dotfile"
  echo "     Root: $(dirname "$dotfile")"
  echo "   Target: $target"
}
