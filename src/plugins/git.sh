dotify-action-git() {
  if [ "$DOTIFY_RUN_MODE" == "install" ]; then
    dotify-action-git-install $@
  elif [ "$DOTIFY_RUN_MODE" == "uninstall" ]; then
    dotify-action-git-uninstall $@
  fi
}

dotify-action-git-install() {
  echo "git install: $@"
}

dotify-action-git-uninstall() {
  echo "git uninstall: $@"
}
