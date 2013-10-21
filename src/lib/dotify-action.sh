dotify-action() {
  local action="$1"
  local source="$2"
  local target="$3"

  if [ "$action" == "default" ]; then
    action="$DOTIFY_OPT_DEFAULT_ACTION"
  fi

  dotify-action-${action} "$source" "$target"
}
