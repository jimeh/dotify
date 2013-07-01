# Set testroot variable.
testroot="$(dirname "$BASH_SOURCE")"

# Include assert.sh testing library.
source "$testroot/assert.sh"

#
# Additional test helpers.
#

# Silent shortcut to "cd -".
cd-back() {
  cd - 1>/dev/null
}

# Stub commands printing it's name and arguments to STDOUT or STDERR.
stub() {
  local cmd="$1"
  if [ "$2" == "STDERR" ]; then local redirect=" 1>&2"; fi

  if [[ "$(type "$cmd" | head -1)" == *"is a function" ]]; then
    local source="$(type "$cmd" | tail -n +2)"
    source="${source/$cmd/original_${cmd}}"
    eval "$source"
  fi
  eval "$(echo -e "${1}() {\n  echo \"$1 stub: \$@\"$redirect\n}")"
}

# Restore the original command/function that was stubbed with stub.
restore() {
  local cmd="$1"
  unset "$cmd"
  if type "original_${cmd}" &>/dev/null; then
    if [[ "$(type "original_${cmd}" | head -1)" == *"is a function" ]]; then
      local source="$(type "original_$cmd" | tail -n +2)"
      source="${source/original_${cmd}/$cmd}"
      eval "$source"
      unset "original_${cmd}"
    fi
  fi
}