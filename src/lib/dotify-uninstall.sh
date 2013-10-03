dotify-uninstall() {
  DOTIFY_RUN_MODE="uninstall"
  execute-dotfile
  return $?
}
