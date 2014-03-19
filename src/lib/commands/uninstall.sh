dotify-command-uninstall() {
  dotify-set-run-mode "uninstall"
  dotify-execute-dotfile
  return $?
}
