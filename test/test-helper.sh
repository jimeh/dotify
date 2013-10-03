# Set testroot variable.
testroot="$(dirname "$BASH_SOURCE")"

# Include assert.sh testing library.
source "$testroot/assert.sh"
source "$testroot/stub.sh"

#
# Additional test helpers.
#

# Silent shortcut to "cd -".
cd-back() {
  cd - 1>/dev/null
}
