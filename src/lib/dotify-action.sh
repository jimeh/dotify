dotify-action() {
  local action="$1"
  local source="$2"
  local target="$3"

  if [ "$action" == "default" ]; then
    action="$DOTIFY_OPT_DEFAULT_ACTION"
  fi

  ! valid_action="$(command -v "dotify-action-${action}")"
  if [ -z "$valid_action" ]; then
    echo "ERROR: \"$action\" is not a valid action." >&2
    return 1
  fi

  dotify-action-${action} "$source" "$target"
}
