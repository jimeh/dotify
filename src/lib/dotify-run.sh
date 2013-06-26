dotify-run() {
  local dotfile="$(locate-dotfile "$@")"
  if [ -z "$dotfile" ]; then return 1; fi

  local target="$(locate-target "$@")"
  if [ -z "$target" ]; then return 1; fi

  parse-dotfile "$dotfile" "$target"
  return "$?"
}
