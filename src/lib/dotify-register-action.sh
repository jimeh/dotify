dotify-register-action() {
  if [ -z "$DOTIFY_ACTIONS" ]; then DOTIFY_ACTIONS=(); fi
  DOTIFY_ACTIONS+=("$1")
}
