#! /usr/bin/env bash
source "../test-helper.sh"

#
# Integration test: link action
#

# Create temp files/folders used for tests.
TEST_SOURCE="tmp/source"
TEST_TARGET="tmp/target"
MY_DOTFILE="$TEST_SOURCE/Dotfile"
mkdir -p "$TEST_SOURCE" "$TEST_TARGET"

PROFILE_TXT="# I am a .profile file"
echo "$PROFILE_TXT" > "$TEST_SOURCE/profile"

# Basic of basics.
echo -e "profile -> .profile" > "$MY_DOTFILE"
assert_raises "dotify -f '$MY_DOTFILE' -t '$TEST_TARGET'" 0
assert "dotify -f '$MY_DOTFILE' -t '$TEST_TARGET'" \
  "   Create symlink: $TEST_TARGET/.profile -> .dotfiles/profile"
assert "readlink '$TEST_TARGET/.profile'" ".dotfiles/profile"
assert "cat '$TEST_TARGET/.profile'" "$PROFILE_TXT"
rm "TEST_TARGET/.profile"
rm "$MY_DOTFILE"


# Remove temp files/folders used for locate-dotfile() tests.
rm "$TEST_SOURCE/profile"
rmdir "$TEST_SOURCE" "$TEST_TARGET" "tmp"

assert_end 'Integration: link action'
