dotify-get-dry-run() {
  if [ -n "$DOTIFY_ATTR_DRY_RUN" ]; then
    DOTIFY_ATTR_DRY_RUN="$ARG_DRY_RUN"
  fi

  echo "$DOTIFY_ATTR_DRY_RUN"
}
