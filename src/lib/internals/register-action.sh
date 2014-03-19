dotify-register-action() {
  if [ -z "$DOTIFY_ACTIONS" ]; then
    DOTIFY_ACTIONS=()
  fi

  if [[ " ${DOTIFY_ACTIONS[@]} " == *" $1 "* ]]; then
    return 1
  fi

  DOTIFY_ACTIONS+=("$1")
}
