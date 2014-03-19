dotify-action() {
  local action="$1"

  if [ $# -lt 3 ]; then
    local target="$2"
  else
    local source="$2"
    local target="$3"
  fi

  dotify-setup-root-link

  if [ "$action" == "default" ]; then
    action="$(dotify-get-default-action)"
  fi

  ! local valid_action="$(command -v "dotify-action-${action}")"
  if [ -z "$valid_action" ]; then
    echo "ERROR: \"$action\" is not a valid action." >&2
    return 1
  fi

  if [ -n "$source" ]; then
    dotify-action-${action} "$(dotify-get-run-mode)" "$target" "$source"
  else
    dotify-action-${action} "$(dotify-get-run-mode)" "$target"
  fi
}
