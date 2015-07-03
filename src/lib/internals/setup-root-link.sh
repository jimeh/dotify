dotify-setup-root-link() {
  if [ -n "$DOTIFY_ROOT_LINK_IS_SETUP" ]; then
    return 0
  fi

  local source="$(dotify-get-absolute-source-path)"
  local target="$(dotify-get-target-path)/$(dotify-get-root-link)"

  if [ "$source" != "$(abs_path "$target")" ]; then
    dotify-create-symlink "$source" "$target"
  fi

  DOTIFY_ROOT_LINK_IS_SETUP="1"
}
