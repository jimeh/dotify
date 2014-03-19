dotify-command-clean() {
  dotify-set-run-mode "clean"
  dotify-execute-dotfile
  return $?
}
