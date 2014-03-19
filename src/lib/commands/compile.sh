dotify-command-compile() {
  dotify-valid-dotfile-path
  if [ "$?" != "0" ]; then return 1; fi

  dotify-compile-dotfile "$DOTFILE"
  return $?
}
