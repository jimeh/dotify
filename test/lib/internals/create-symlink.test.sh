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
assert 'dotify-create-symlink ../source tmp/target/.dotfiles' \
       "   create: tmp/target/.dotfiles --> ../source"
rm "tmp/target/.dotfiles"
assert 'dotify-create-symlink ../source tmp/target/.dotfiles 2>&1' \
       "   create: tmp/target/.dotfiles --> ../source"
rm "tmp/target/.dotfiles"

# When target exists and is a symlink to the same source.
ln -s "../source" "tmp/target/.dotfiles"
assert_raises 'dotify-create-symlink ../source tmp/target/.dotfiles' 0
assert 'dotify-create-symlink ../source tmp/target/.dotfiles' \
       "   exists: tmp/target/.dotfiles"
assert 'dotify-create-symlink ../source tmp/target/.dotfiles 2>&1' \
       "   exists: tmp/target/.dotfiles"
rm "tmp/target/.dotfiles"

# When target exists and is a symlink to a different source.
ln -s "../other" "tmp/target/.dotfiles"
assert_raises 'dotify-create-symlink ../source tmp/target/.dotfiles' 1
assert 'dotify-create-symlink ../source tmp/target/.dotfiles' \
       "   exists: tmp/target/.dotfiles -- is symlink to: ../other"
assert 'dotify-create-symlink ../source tmp/target/.dotfiles 2>&1' \
       "   exists: tmp/target/.dotfiles -- is symlink to: ../other"
rm "tmp/target/.dotfiles"

# When target exists and is a file.
touch "tmp/target/.profile"
assert_raises 'dotify-create-symlink ../source/profile tmp/target/.profile' 2
assert 'dotify-create-symlink ../source/profile tmp/target/.profile' \
       "   exists: tmp/target/.profile -- is a regular file/folder"
assert 'dotify-create-symlink ../source/profile tmp/target/.profile 2>&1' \
       "   exists: tmp/target/.profile -- is a regular file/folder"
rm "tmp/target/.profile"

# When target exists and is a directory.
assert_raises 'dotify-create-symlink ../source tmp/target' 2
assert 'dotify-create-symlink ../source tmp/target' \
       "   exists: tmp/target -- is a regular file/folder"
assert 'dotify-create-symlink ../source tmp/target 2>&1' \
       "   exists: tmp/target -- is a regular file/folder"

# Remove temp files/folders used for locate-dotfile() tests.
rm "tmp/source/profile"
rmdir "tmp/source" "tmp/target" "tmp"

assert_end 'dotify-create-symlink()'
