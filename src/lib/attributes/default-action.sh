dotify-set-default-action() {
  DOTIFY_ATTR_DEFAULT_ACTION="$@"
}

dotify-get-default-action() {
  if [ -z "$DOTIFY_ATTR_DEFAULT_ACTION" ]; then
    DOTIFY_ATTR_DEFAULT_ACTION="link" # Default value.
  fi

  echo "$DOTIFY_ATTR_DEFAULT_ACTION"
}
