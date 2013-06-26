# Trim leading and trailing whitespace.
#
# Example:
#
#   $ trim "  foo bar   "
#   foo bar
#
trim() {
  local string="$@"
  string="${string#"${string%%[![:space:]]*}"}"
  string="${string%"${string##*[![:space:]]}"}"
  echo -n "$string"
}
