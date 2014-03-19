dotify-execute-dotfile() {
  local dotfile_source="$(dotify-command-compile)"

  dotify-valid-target-path
  if [ "$?" != "0" ]; then return 1; fi

  eval "$dotfile_source"
  return $?
}
