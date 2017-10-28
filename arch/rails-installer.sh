#!/bin/bash

set -e

echo "Updates packages."
sudo pacman -Sy


echo "Installing rbenv"
yaourt -S rbenv

echo "Installing ruby-build"
yaourt -S ruby-build
sudo pacman -S --needed gcc5 base-devel libffi libyaml openssl zlib

echo "gcc 7.2 throws segmentation fault"

echo "Choose ruby version "
echo "1. 2.3.0"
echo "2. 2.4.0"
read -p "Install ruby : " p

if [ $p == 1 ] ; then
  echo "Installing ruby 2.3.0 with gcc 5 compiler"
  echo "using openssl-1.0"
  echo "run rbenv install version to see list"
  PKG_CONFIG_PATH=/usr/lib/openssl-1.0/pkgconfig CC=/usr/bin/gcc-5 rbenv install 2.3.0
  echo "making 2.3.0 global version"
  rbenv global 2.3.0
else 
  if [ $p == 2 ] ; then
  echo "Installing ruby 2.4.0 with gcc 5 compiler"
  echo "using openssl-1.0"
  PKG_CONFIG_PATH=/usr/lib/openssl-1.0/pkgconfig CC=/usr/bin/gcc-5 rbenv install 2.4.0
  echo "making 2.4.0 global version"
  rbenv global 2.4.0
  fi
fi

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

echo "check ruby version"
ruby -v

gems = "bundler rails"

for gem in $gems; do
  echo "Installing gem $gem"
  gem install $gem
done

echo "rehash rbenv"
rbenv rehash

read -p "Create test project? (Y/N)" p
if [ $p == 'Y' ] || [ $p == 'y' ] ; then
  rails new test_project
fi

