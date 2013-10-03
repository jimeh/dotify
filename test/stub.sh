# Stub commands for testing purposes.
#
# Arguments:
#   - $1: Name of command to stub.
#   - $2: Output will go to STDERR when $2 is "STDERR".
#
stub() {
  local cmd="$1"
  if [ "$2" == "STDERR" ]; then local redirect=" 1>&2"; fi

  if [[ "$(type "$cmd" | head -1)" == *"is a function" ]]; then
    local source="$(type "$cmd" | tail -n +2)"
    source="${source/$cmd/non_stubbed_${cmd}}"
    eval "$source"
  fi
  eval "$(echo -e "${1}() {\n  echo \"$1 stub: \$@\"$redirect\n}")"
}

# Restore the original command/function that was stubbed with stub().
#
# Arguments:
#   - $1: Name of command to restore.
#
restore() {
  local cmd="$1"
  unset -f "$cmd"
  if type "non_stubbed_${cmd}" &>/dev/null; then
    if [[ "$(type "non_stubbed_${cmd}" | head -1)" == *"is a function" ]]; then
      local source="$(type "non_stubbed_$cmd" | tail -n +2)"
      source="${source/non_stubbed_${cmd}/$cmd}"
      eval "$source"
      unset -f "non_stubbed_${cmd}"
    fi
  fi
}
