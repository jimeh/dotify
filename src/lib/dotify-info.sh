dotify-info() {
  locate-dotfile
  if [ "$?" != "0" ]; then return 1; fi

  locate-target
  if [ "$?" != "0" ]; then return 1; fi

  echo "$(dotify-print-version)"
  echo "  Dotfile: $DOTFILE"
  echo "     Root: $(dirname "$DOTFILE")"
  echo "   Target: $TARGET"
}
