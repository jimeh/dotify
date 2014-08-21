dotify-main-parse-command() {
  local skip_next

  # Command is first argument that does not start with a dash or plus.
  for arg in "$@"; do
    if [ -n "$skip_next" ]; then
      skip_next=
    elif [[ "$arg" =~ ^(--dotfile|-f|--taraget|-t)$ ]]; then
      skip_next=1
    elif [[ "$arg" != "-"* ]] && [[ "$arg" != "+"* ]]; then
      COMMAND="$arg"
      break
    fi
  done
}
