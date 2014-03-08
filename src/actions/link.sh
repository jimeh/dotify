# Register link action.
dotify-register-action "link"

# Link action.
dotify-action-link() {
  local mode="$1"
  ! local valid_mode="$(command -v "dotify-action-link-do-${mode}")"

  if [ -n "$valid_mode" ]; then
    shift 1
    dotify-action-link-do-${mode} $@
  fi
}

dotify-action-link-do-install() {
  echo "link install: $@"
}

dotify-action-link-do-uninstall() {
  echo "link uninstall: $@"
}

dotify-action-link-do-cleanup() {
  echo "link cleanup: $@"
}

dotify-action-link-post-run() {
  if [ "$1" == "cleanup" ]; then
    shift 1
    dotify-action-link-do-cleanup $@
  fi
}
