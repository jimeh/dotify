#! /usr/bin/env bash
source "../../test-helper.sh"
source "../../../src/lib/internals/locate-target.sh"

#
# locate-target() tests
#

# When $TARGET is empty.
TARGET=""
assert_raises 'locate-target' 0
assert 'locate-target; echo "$TARGET"' "$HOME"
unset TARGET

# When $TARGET is not empty and is a directory.
TARGET="$(pwd)"
assert_raises 'locate-target' 0
assert 'locate-target; echo "$TARGET"' "$(pwd)"
unset TARGET

# When $TARGET is not empty and is not a directory.
TARGET="/tmp/this/does/not/exist"
assert_raises 'locate-target' 1
assert 'locate-target 2>&1' "ERROR: Target \"$TARGET\" is not a directory."
assert 'locate-target; echo "$TARGET"' "$TARGET"
unset TARGET

# If neither $TARGET or $HOME is set, ~ is expanded to find home folder
original_home="$HOME"
unset HOME
assert_raises 'locate-target' 0
assert 'locate-target; echo "$TARGET"' "$original_home"
HOME="$original_home"

# End of locate-target() tests.
assert_end 'locate-target()'
