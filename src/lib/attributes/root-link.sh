dotify-set-root-link() {
  DOTIFY_ATTR_ROOT_LINK="$1"
}

dotify-get-root-link() {
  if [ -z "$DOTIFY_ATTR_ROOT_LINK" ]; then
    DOTIFY_ATTR_ROOT_LINK=".dotfiles" # Default value.
  fi

  echo "$DOTIFY_ATTR_ROOT_LINK"
}
