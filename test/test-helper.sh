[ -n "$TEST_DEBUG" ] && set -x

resolve_link() {
  $(type -p greadlink readlink | head -1) $1
}

abs_dirname() {
  local cwd="$(pwd)"
  local path="$1"

  while [ -n "$path" ]; do
    cd "${path%/*}"
    local name="${path##*/}"
    path="$(resolve_link "$name" || true)"
  done

  pwd
  cd "$cwd"
}

# Set testroot variable.
testroot="$(abs_dirname "$BASH_SOURCE")"

# Set root variable.
root="$(abs_dirname "$testroot/../..")"

# Setup PATH environment variable.
PATH="$root/bin:$root/libexec:$PATH"

# Include assert.sh testing library.
source "${testroot}/assert.sh"
source "${testroot}/stub.sh"


#
# Test Helpers
#

# Silent shortcut to "cd -".
cd-back() {
  cd - 1>/dev/null
}
