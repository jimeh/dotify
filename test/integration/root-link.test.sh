#! /usr/bin/env bash
source "../test-helper.sh"

#
# Integration test: root link
#

# Create temp files/folders used for tests.
TEST_SOURCE="tmp/source"
TEST_TARGET="tmp/target"
ABS_TEST_SOURCE="$(pwd)/$TEST_SOURCE"
MY_DOTFILE="$TEST_SOURCE/Dotfile"
mkdir -p "$TEST_SOURCE" "$TEST_TARGET"

PROFILE_TXT="# I am a .profile file"
echo "$PROFILE_TXT" > "$TEST_SOURCE/profile"

# Creates root link.
echo -e "profile -> .profile" > "$MY_DOTFILE"
assert "dotify -f '$MY_DOTFILE' -t '$TEST_TARGET' | head -n 1" \
  "   create: $TEST_TARGET/.dotfiles --> $ABS_TEST_SOURCE"
assert "readlink '$TEST_TARGET/.dotfiles'" "$ABS_TEST_SOURCE"
rm "$TEST_TARGET/.dotfiles"
rm "$TEST_TARGET/.profile"
rm "$MY_DOTFILE"

# Remove temp files/folders used for locate-dotfile() tests.
rm "$TEST_SOURCE/profile"
rmdir "$TEST_SOURCE" "$TEST_TARGET" "tmp"

assert_end 'Integration: root link'
