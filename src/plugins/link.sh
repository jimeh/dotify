dotify-action-link() {
  if [ "$DOTIFY_RUN_MODE" == "install" ]; then
    dotify-action-link-install $@
  elif [ "$DOTIFY_RUN_MODE" == "uninstall" ]; then
    dotify-action-link-uninstall $@
  fi
}

dotify-action-link-install() {
  echo "link install: $@"
}

dotify-action-link-uninstall() {
  echo "link uninstall: $@"
}
