dotify-main-parse-arguments() {
  ARG_DOTFILE="" # --dotfile / -f
  ARG_TARGET=""  # --target  / -t
  ARG_DRY_RUN="" # --dry-run / -d
  ARG_HELP=""    # --help    / -h
  ARG_VERSION="" # --version / -v

  if has-argument dotfile f "$@"; then
    ARG_DOTFILE="$(parse-argument dotfile f "$@")"
  fi

  if has-argument target t "$@"; then
    ARG_TARGET="$(parse-argument target t "$@")"
  fi

  if has-argument dry-run d "$@"; then
    ARG_DRY_RUN="1"
  fi

  if has-argument help h "$@"; then
    ARG_HELP="1"
  fi

  if has-argument version v "$@"; then
    ARG_VERSION="1"
  fi
}
