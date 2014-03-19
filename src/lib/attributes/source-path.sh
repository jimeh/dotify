dotify-get-source-path() {
  local dotfile="$(dotify-get-dotfile-path)"
  if [ "$?" != "0" ]; then return 1; fi

  echo "$(dirname "$dotfile")"
}

dotify-valid-source-path() {
  dotify-get-source-path >/dev/null 2>&1
  return "$?"
}
