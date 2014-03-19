#! /usr/bin/env bash
source "../../test-helper.sh"
source "../../../src/lib/internals/create-symlink.sh"

#
# dotify-create-symlink() tests
#

# Create temp files/folders used for dotify-create-symlink() tests.
mkdir -p "tmp/source" "tmp/target"
touch "tmp/source/profile"

# Creates a normal symlink.
assert_raises 'dotify-create-symlink ../source tmp/target/.dotfiles' 0
assert 'readlink tmp/target/.dotfiles' "../source"
rm "tmp/target/.dotfiles"
assert 'dotify-create-symlink ../source tmp/target/.dotfiles' "created"
rm "tmp/target/.dotfiles"
assert 'dotify-create-symlink ../source tmp/target/.dotfiles 2>&1' "created"
rm "tmp/target/.dotfiles"

# When target exists and is a symlink to the same source.
ln -s "../source" "tmp/target/.dotfiles"
assert_raises 'dotify-create-symlink ../source tmp/target/.dotfiles' 0
assert 'dotify-create-symlink ../source tmp/target/.dotfiles' "exists"
assert 'dotify-create-symlink ../source tmp/target/.dotfiles 2>&1' "exists"
rm "tmp/target/.dotfiles"

# When target exists and is a symlink to a different source.
ln -s "../other" "tmp/target/.dotfiles"
assert_raises 'dotify-create-symlink ../source tmp/target/.dotfiles' 1
assert 'dotify-create-symlink ../source tmp/target/.dotfiles' ""
assert 'dotify-create-symlink ../source tmp/target/.dotfiles 2>&1' \
  "ERROR: \"tmp/target/.dotfiles\" exists, is a symlink to: ../other"
rm "tmp/target/.dotfiles"

# When target exists and is a file.
touch "tmp/target/.profile"
assert_raises 'dotify-create-symlink ../source/profile tmp/target/.profile' 1
assert 'dotify-create-symlink ../source/profile tmp/target/.profile' ""
assert 'dotify-create-symlink ../source/profile tmp/target/.profile 2>&1' \
  "ERROR: \"tmp/target/.profile\" exists"
rm "tmp/target/.profile"

# When target exists and is a directory.
assert_raises 'dotify-create-symlink ../source tmp/target' 1
assert 'dotify-create-symlink ../source tmp/target' ""
assert 'dotify-create-symlink ../source tmp/target 2>&1' \
  "ERROR: \"tmp/target\" exists"

# Remove temp files/folders used for locate-dotfile() tests.
rm "tmp/source/profile"
rmdir "tmp/source" "tmp/target" "tmp"

assert_end 'dotify-create-symlink()'
