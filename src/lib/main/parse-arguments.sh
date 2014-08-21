dotify-main-parse-arguments() {
  DOTIFY_ARG_DOTFILE="" # --dotfile / -f
  DOTIFY_ARG_TARGET=""  # --target  / -t
  DOTIFY_ARG_DRY_RUN="" # --dry-run / -d
  DOTIFY_ARG_HELP=""    # --help    / -h
  DOTIFY_ARG_VERSION="" # --version / -v

  if has-argument dotfile f "$@"; then
    DOTIFY_ARG_DOTFILE="$(parse-argument dotfile f "$@")"
  fi

  if has-argument target t "$@"; then
    DOTIFY_ARG_TARGET="$(parse-argument target t "$@")"
  fi

  if has-argument dry-run d "$@"; then
    DOTIFY_ARG_DRY_RUN="1"
  fi

  if has-argument help h "$@"; then
    DOTIFY_ARG_HELP="1"
  fi

  if has-argument version v "$@"; then
    DOTIFY_ARG_VERSION="1"
  fi
}
