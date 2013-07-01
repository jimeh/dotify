dotify-install() {
  locate-dotfile
  if [ -n "$?" ]; then return 1; fi

  locate-target
  if [ -n "$?" ]; then return 1; fi

  execute-dotfile
  return $?
}
