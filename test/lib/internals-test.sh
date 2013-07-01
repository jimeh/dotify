#! /usr/bin/env bash
source "../test-helper.sh"
source "../../src/lib/internals.sh"

#
# locate-dotfile()
#

# Create temp files/folders used for locate-dotfile() tests.
mkdir -p "test-tmp/without"
mkdir -p "test-tmp/with"
touch "test-tmp/with/Dotfile"

# When $DOTFILE is empty and current path has a Dotfile.
cd "test-tmp/with"
DOTFILE=""
assert_raises 'locate-dotfile' 0
assert 'locate-dotfile; echo "$DOTFILE"' "$(pwd)/Dotfile"
unset DOTFILE
cd-back

# When $DOTFILE is empty and current path does not have a Dotfile.
cd "test-tmp/without"
DOTFILE=""
assert_raises 'locate-dotfile' 1
assert 'locate-dotfile 2>&1' "ERROR: \"$(pwd)\" does not have a Dotfile."
assert 'locate-dotfile; echo "$DOTFILE"' ""
unset DOTFILE
cd-back

# When $DOTFILE is not empty and points at a existing Dotfile.
DOTFILE="test-tmp/with/Dotfile"
assert_raises 'locate-dotfile' 0
assert 'locate-dotfile; echo "$DOTFILE"' "$DOTFILE"
unset DOTFILE

# When $DOTFILE is not empty and points at a non-existing Dotfile.
DOTFILE="test-tmp/without/Dotfile"
assert_raises 'locate-dotfile' 1
assert 'locate-dotfile 2>&1' "ERROR: \"$DOTFILE\" does not exist."
assert 'locate-dotfile; echo "$DOTFILE"' "$DOTFILE"
unset DOTFILE

# Remove temp files/folders used for locate-dotfile() tests.
rm "test-tmp/with/Dotfile"
rmdir "test-tmp/with"
rmdir "test-tmp/without"
rmdir "test-tmp"

# Ensure temp files/folder were cleaned up.
assert_raises "test -d test-tmp" 1

# End of locate-dotfile() tests.
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

# End of locate-target() tests.
assert_end 'locate-target()'
