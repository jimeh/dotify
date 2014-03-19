# Register git action
dotify-register-action "git"

# Git action.
dotify-action-git() {
  local mode="$1"
  ! local valid_mode="$(command -v "dotify-action-git-${mode}")"

  if [ -n "$valid_mode" ]; then
    shift 1
    dotify-action-git-${mode} $@
  fi
}

dotify-action-git-install() {
  echo "git install: $@"
}

dotify-action-git-uninstall() {
  echo "git uninstall: $@"
}

dotify-action-git-cleanup() {
  echo "git cleanup: $@"
}

dotify-action-git-post-run() {
  if [ "$1" == "cleanup" ]; then
    shift 1
    dotify-action-git-cleanup $@
  fi
}
