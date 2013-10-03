execute-dotfile() {
  local dotfile_source="$(dotify-compile)"

  locate-target
  if [ "$?" != "0" ]; then return 1; fi

  echo "$dotfile_source"
  return $?
}
