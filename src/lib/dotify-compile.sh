dotify-compile() {
  locate-dotfile
  if [ "$?" != "0" ]; then return 1; fi

  compile-dotfile "$DOTFILE"
  return $?
}
