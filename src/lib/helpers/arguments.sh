# Checks for specified argument.
#
# Requires bash extended globbing: shopt -s extglob
#
# Example:
#
#   $ has-argument help h -t none
#   > returns 1
#   $ has-argument help h -t none --help
#   > returns 0
#   $ has-argument help h -t none -h
#   > returns 0
#
# Returns 0 if argument was found, returns 1 otherwise.
has-argument() {
  local long short

  long="--$1"
  short="-$2"
  shift 2

  if [[ " $* " =~ ^.*\ ($long|$short)(=.+)?\ .*$ ]]; then
    return 0
  fi

  return 1
}

# Parses and echos value of specified argument.
#
# Requires bash extended globbing: shopt -s extglob
#
# Example:
#
#   $ parse-argument file f -t none --file /tmp/foobar.txt
#   /tmp/foobar.txt
#   $ parse-argument file f -t none --file="/tmp/foo bar.txt"
#   /tmp/foo bar.txt
#   $ parse-argument file f -t none -f /tmp/foobar.txt
#   /tmp/foobar.txt
#   $ parse-argument file f -t none -f=/tmp/foo\ bar.txt
#   /tmp/foo bar.txt
#
# Returns 0 and echos value if argument was found, returns 1 otherwise.
parse-argument() {
  local long short arg next_arg

  long="--$1"
  short="-$2"
  shift 2

  for arg in "$@"; do
    if [ -n "$next_arg" ]; then
      echo "$arg"
      return 0
    elif [[ " $arg " =~ ^\ ($long|$short)\ $ ]]; then
      next_arg=1
    elif [[ " $arg " =~ ^\ ($long|$short)=(.+)\ $ ]]; then
      echo "${BASH_REMATCH[2]}"
      return 0
    fi
  done

  return 1
}
