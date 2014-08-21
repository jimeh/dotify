#! /usr/bin/env bash
source "../../test-helper.sh"
source "../../../src/lib/helpers/trim.sh"
source "../../../src/lib/internals/compile-dotfile.sh"

#
# dotify-compile-dotfile() tests
#

# Create temp files/folders used for locate-dotfile() tests.
mkdir -p "tmp"
dotfile="tmp/Dotfile"
echo "hostname='air'" > $dotfile


# Compiles file given as first argument.
assert "dotify-compile-dotfile $dotfile" "hostname='air'"
assert_raises "dotify-compile-dotfile tmp/fake" 1
assert "dotify-compile-dotfile tmp/fake" ""
assert "dotify-compile-dotfile tmp/fake 2>&1" \
  "ERROR: \"tmp/fake\" does not exist."


# Compiles file from dotify-get-dotfile-path attribute helper.
stub_and_echo "dotify-get-dotfile-path" "$dotfile"
assert "dotify-compile-dotfile" "hostname='air'"
stub_and_echo "dotify-get-dotfile-path" "tmp/fake"
assert_raises "dotify-compile-dotfile" 1
assert "dotify-compile-dotfile" ""
assert "dotify-compile-dotfile 2>&1" "ERROR: \"tmp/fake\" does not exist."
restore "dotify-get-dotfile-path"


# Compiles standard actions
echo -e "root_link .dotfiles
link: ackrc     -> .ackrc
link: gitconfig -> \".gitconfig\"" > $dotfile
assert "dotify-compile-dotfile $dotfile" "root_link .dotfiles
dotify-action link ackrc .ackrc
dotify-action link gitconfig \".gitconfig\""


# Compiles standard actions without a <source>
echo -e "root_link .dotfiles
link: -> .ackrc
link:-> \".gitconfig\"" > $dotfile
assert "dotify-compile-dotfile $dotfile" "root_link .dotfiles
dotify-action link .ackrc
dotify-action link \".gitconfig\""


# Compiles default (shorthand) actions
echo -e "root_link .dotfiles
link: ackrc -> .ackrc
gitconfig   -> \".gitconfig\"" > $dotfile
assert "dotify-compile-dotfile $dotfile" "root_link .dotfiles
dotify-action link ackrc .ackrc
dotify-action default gitconfig \".gitconfig\""


# Compiles default (shorthand) actions without a <source>
echo -e "root_link .dotfiles
-> .ackrc
 -> \".gitconfig\"" > $dotfile
assert "dotify-compile-dotfile $dotfile" "root_link .dotfiles
dotify-action default .ackrc
 dotify-action default \".gitconfig\""


# Correctly indents actions
echo -e "root_link .dotfiles
if [ true ]; then
  ackrc -> .ackrc
fi" > $dotfile
assert "dotify-compile-dotfile $dotfile" "root_link .dotfiles
if [ true ]; then
  dotify-action default ackrc .ackrc
fi"


# Strips out comments and blank lines.
echo -e "# My Dotfile
root_link .dotfiles

# Basics
profile -> .profile

# Apps
ackrc     -> .ackrc
gitconfig -> .gitconfig" > $dotfile
assert "dotify-compile-dotfile $dotfile" "root_link .dotfiles
dotify-action default profile .profile
dotify-action default ackrc .ackrc
dotify-action default gitconfig .gitconfig"


# Remove temp files/folders used for locate-dotfile() tests.
rm "tmp/Dotfile"
rmdir "tmp"
assert_raises "test -d tmp" 1

assert_end 'dotify-compile-dotfile()'
