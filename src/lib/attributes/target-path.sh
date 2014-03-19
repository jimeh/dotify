dotify-get-target-path() {
  if [ -n "$DOTIFY_ATTR_TARGET" ]; then
    echo "$DOTIFY_ATTR_TARGET"
    return 0
  fi

  if [ -n "$ARG_TARGET" ]; then
    if [ -d "$ARG_TARGET" ]; then
      DOTIFY_ATTR_TARGET="$ARG_TARGET"
    else
      echo "ERROR: Target \"$ARG_TARGET\" is not a directory." >&2
      return 1
    fi
  elif [ -n "$HOME" ] && [ -d "$HOME" ]; then
    DOTIFY_ATTR_TARGET="$HOME"
  elif [ -d ~ ]; then
    DOTIFY_ATTR_TARGET=~
  else
    echo "ERROR: Your \$HOME folder could not be found." >&2
    return 1
  fi

  echo "$DOTIFY_ATTR_TARGET"
}

dotify-valid-target-path() {
  dotify-get-target-path >/dev/null 2>&1
  return "$?"
}
