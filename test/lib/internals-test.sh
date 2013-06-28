#! /usr/bin/env bash
source "../assert.sh"

source "../../src/lib/internals.sh"

# silent shortcut to "cd -"
cd-back() {
  cd - 1>/dev/null
}

#
# locate-dotfile()
#

# Create temp files/folders used for locate-dotfile() tests.
mkdir -p "locate-dotfile-tests/without"
mkdir -p "locate-dotfile-tests/with"
touch "locate-dotfile-tests/with/Dotfile"

# When $DOTFILE is empty and current path has a Dotfile.
cd "locate-dotfile-tests/with"
DOTFILE=""
assert_raises 'locate-dotfile' 0
assert 'locate-dotfile; echo "$DOTFILE"' "$(pwd)/Dotfile"
unset DOTFILE
cd-back

# When $DOTFILE is empty and current path does not have a Dotfile.
cd "locate-dotfile-tests/without"
DOTFILE=""
assert_raises 'locate-dotfile' 1
assert 'locate-dotfile 2>&1' "ERROR: \"$(pwd)\" does not have a Dotfile."
assert 'locate-dotfile; echo "$DOTFILE"' ""
unset DOTFILE
cd-back

# When $DOTFILE is not empty and points at a existing Dotfile.
DOTFILE="locate-dotfile-tests/with/Dotfile"
assert_raises 'locate-dotfile' 0
assert 'locate-dotfile; echo "$DOTFILE"' "$DOTFILE"
unset DOTFILE

# When $DOTFILE is not empty and points at a non-existing Dotfile.
DOTFILE="locate-dotfile-tests/without/Dotfile"
assert_raises 'locate-dotfile' 1
assert 'locate-dotfile 2>&1' "ERROR: \"$DOTFILE\" does not exist."
assert 'locate-dotfile; echo "$DOTFILE"' "$DOTFILE"
unset DOTFILE

# Remove temp files/folders used for locate-dotfile() tests.
rm "locate-dotfile-tests/with/Dotfile"
rmdir "locate-dotfile-tests/with"
rmdir "locate-dotfile-tests/without"
rmdir "locate-dotfile-tests"

assert_end 'locate-dotfile()'


#
# locate-target()
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

assert_end 'locate-target()'
