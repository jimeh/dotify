dotify-install() {
  DOTIFY_RUN_MODE="install"
  execute-dotfile
  return $?
}
