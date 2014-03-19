dotify-command-install() {
  dotify-set-run-mode "install"
  dotify-execute-dotfile
  return $?
}
