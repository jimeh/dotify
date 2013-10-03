#! /usr/bin/env bash
source "../../test-helper.sh"
source "../../../src/lib/internals/locate-dotfile.sh"

#
# locate-dotfile() tests
#

# Create temp files/folders used for locate-dotfile() tests.
mkdir -p "test-tmp/with" "test-tmp/without"
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
rmdir "test-tmp/with" "test-tmp/without" "test-tmp"

# Ensure temp files/folder were cleaned up.
assert_raises "test -d test-tmp" 1

# End of locate-dotfile() tests.
assert_end 'locate-dotfile()'
