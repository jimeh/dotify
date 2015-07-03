# Get absolute path to directory given file resides in.
#
# Example:
#
#   $ cd /tmp/foo-bar
#   $ abs_dirname hello/world.txt
#   /tmp/foo-bar/hello/world.txt
#
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

abs_path() {
  local path="$1"
  echo "$(cd "$(abs_dirname "$path")" && pwd)/$(basename "$path")"
}

resolve_link() {
  $(type -p greadlink readlink | head -1) $1
}
