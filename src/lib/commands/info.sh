dotify-command-info() {
  dotify-valid-dotfile-path
  if [ "$?" != "0" ]; then return 1; fi

  dotify-valid-source-path
  if [ "$?" != "0" ]; then return 1; fi

  dotify-valid-target-path
  if [ "$?" != "0" ]; then return 1; fi

  echo "$(dotify-print-version)"
  echo "  Dotfile: $(dotify-get-dotfile-path)"
  echo "   Source: $(dotify-get-source-path)"
  echo "   Target: $(dotify-get-target-path)"
}
