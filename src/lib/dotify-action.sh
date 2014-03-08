dotify-action() {
  local action="$1"

  if [ $# -lt 3 ]; then
    local target="$2"
  else
    local source="$2"
    local target="$3"
  fi

  if [ "$action" == "default" ]; then
    action="$DOTIFY_OPT_DEFAULT_ACTION"
  fi

  ! local valid_action="$(command -v "dotify-action-${action}")"
  if [ -z "$valid_action" ]; then
    echo "ERROR: \"$action\" is not a valid action." >&2
    return 1
  fi

  if [ -n "$source" ]; then
    dotify-action-${action} "$DOTIFY_RUN_MODE" "$target" "$source"
  else
    dotify-action-${action} "$DOTIFY_RUN_MODE" "$target"
  fi
}
