dotify-clean() {
  DOTIFY_RUN_MODE="clean"
  execute-dotfile
  return $?
}
