dotify-has-action() {
  if [[ " ${DOTIFY_ACTIONS[@]} " != *" $1 "* ]]; then
    return 1
  fi
}
