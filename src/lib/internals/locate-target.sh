locate-target() {
  if [ -n "$TARGET" ]; then
    if [ ! -d "$TARGET" ]; then
      echo "ERROR: Target \"$TARGET\" is not a directory." >&2
      return 1
    fi
  elif [ -n "$HOME" ] && [ -d "$HOME" ]; then
    TARGET="$HOME"
  elif [ -d ~ ]; then
    TARGET=~
  else
    echo "ERROR: Your \$HOME folder could not be found." >&2
    return 1
  fi
}
