#! /usr/bin/env bash

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


testdir="$(abs_dirname "$0")"
testfiles="$(find "$testdir" -name "*-test.sh")"

for testfile in $testfiles; do
  echo "running: ${testfile/#$(dirname "$testdir")\//}"
  cd "$(dirname "$testfile")"
  "$testfile"
  echo ""
done
