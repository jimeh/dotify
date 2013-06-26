# Checks for specified argument.
#
# Example:
#
#   $ has-argument help h "-t none"
#   > returns 1
#   $ has-argument help h "-t none --help"
#   > returns 0
#   $ has-argument help h "-t none -h"
#   > returns 0
#
# Returns 0 and echos value if argument was found, returns 1 otherwise.
has-argument() {
  local long short args arg next_arg

  long="--$1"
  short="-$2"
  shift 2

  if [[ " $@ " == *" $long "* ]] || [[ " $@ " == *" $long="* ]]; then
    return 0
  elif [[ " $@ " == *" $short "* ]] || [[ " $@ " == *" $short="* ]]; then
    return 0
  fi
  return 1
}

# Parses and echos value of specified argument.
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
    elif [[ " $arg " == *" $long "* ]] || [[ " $arg " == *" $short "* ]]; then
      next_arg="yes"
    elif [[ " $arg " == *" $long="* ]]; then
      arg="${arg/#$long=/}"
      echo "$arg"
      return 0
    elif [[ " $arg " == *" $short="* ]]; then
      arg="${arg/#$short=/}"
      echo "$arg"
      return 0
    fi
  done
  return 1
}
