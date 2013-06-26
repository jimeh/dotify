#! /usr/bin/env bash
source "src/lib/dotify-version.sh"
source "src/lib/trim.sh"

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


#
# Config
#

source="src/bin/dotify"
target="bin/dotify"


#
# Setup
#

root="$(abs_dirname "$0")"
cd "$(dirname "$root/$source")"
source="$(basename "$source")"
output=""


#
# Building
#

while IFS= read line; do
  if [[ "$line" == "#"* ]]; then
    # Replace {{VERSION}} placeholder in comments.
    line="${line/\{\{VERSION\}\}/$(dotify-version)}"
  fi

  if [[ "$line" == "source \""*"\"" ]]; then
    # Inject content of sourced file directly into output.
    line="$(trim "$line")"
    file="${line/#source \"/}"
    file="${file/%\"/}"
    output="${output}$(cat "$file")\n\n"
  else
    # Append line to output.
    output="${output}${line}\n"
  fi
done < "$source"

cd "$root"
echo -e "$output" > "$target"
chmod +x "$target"
