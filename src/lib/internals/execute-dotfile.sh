execute-dotfile() {
  local dotfile_source="$(dotify-compile)"

  locate-target
  if [ "$?" != "0" ]; then return 1; fi

  eval "$dotfile_source"
  return $?
}
