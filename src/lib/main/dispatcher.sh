dotify-main-dispatcher() {
  # Show help and exit if help arguments or command are given.
  if [ -n "$DOTIFY_ARG_HELP" ] || [ "$DOTIFY_COMMAND" == "help" ]; then
    dotify-command-help
    exit
  fi

  # Show version info and exit if version arguments or command are given.
  if [ -n "$DOTIFY_ARG_VERSION" ] || [ "$DOTIFY_COMMAND" == "version" ]; then
    dotify-command-help | head -1
    exit
  fi

  # Deal with the commands.
  case "$DOTIFY_COMMAND" in
    "info" )
      dotify-command-info
      ;;
    "compile" )
      dotify-command-compile
      ;;
    "" | "install" )
      dotify-command-install
      ;;
    "uninstall" )
      dotify-command-uninstall
      ;;
    "clean" )
      dotify-command-clean
      ;;
  esac

  return $?
}
