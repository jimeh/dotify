# Register link action.
dotify-register-action "link"

# Link action.
dotify-action-link() {
  local mode="$1"
  ! local valid_mode="$(command -v "dotify-action-link-${mode}")"

  if [ -n "$valid_mode" ]; then
    shift 1
    dotify-action-link-${mode} $@
  fi
}

dotify-action-link-install() {
  echo "link install: $@"
}

dotify-action-link-uninstall() {
  echo "link uninstall: $@"
}

dotify-action-link-cleanup() {
  echo "link cleanup: $@"
}

dotify-action-link-post-run() {
  if [ "$1" == "cleanup" ]; then
    shift 1
    dotify-action-link-cleanup $@
  fi
}
