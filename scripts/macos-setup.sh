#!/bin/bash

#############################################################
#
# macos-setup.sh installs all the prerequisite dependencies
# needed to run this emacs setup.
#
# This is a work in progress and is surely missing some
# dependencies
#
# After running this script, one should run the postscript
# commands manually.
#
# Prescript:
#
# * Make sure all git submodules have been recursively pulled in.
#
# Postscript:
#
# * M-x irony-install-server
# * MACOS: In ~/.emacs.d/elisp/languages/c++.el uncomment
#          (setenv OPENSSL_ROOT_DIR) if needed for c++ libs.
#
#############################################################

# C++ requirements.

# Ensure clang tools are properly installed.
brew install llvm
ln -s "$(brew --prefix llvm)/bin/clang-format" "/usr/local/bin/clang-format"
ln -s "$(brew --prefix llvm)/bin/clang-tidy" "/usr/local/bin/clang-tidy"

# Build rtags.
git clone --recursive git@github.com:Andersbakken/rtags.git
pushd rtags
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
make
popd

# Setup clang-c header files so that `M-x irony-install-server` works
# in the postscript setup.
sudo mkdir -p /usr/local/lib /usr/local/include
sudo cp -p "`xcode-select --print-path`"/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib /usr/local/lib
cd /tmp
svn export http://llvm.org/svn/llvm-project/cfe/trunk/include/clang-c/
sudo cp -RP clang-c /usr/local/include
