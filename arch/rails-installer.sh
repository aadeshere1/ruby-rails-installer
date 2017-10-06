#!/bin/bash

set -e

echo "Updates packages."
sudo pacman -Sy

read -p "Want rbenv ?(Y/N)" rbenv

if [ $rbenv == 'Y' ] || [ $rbenv == 'y'] ; then
	echo "Installing rbenv"
	yaourt -S rbenv

	echo "Installing ruby-build"
	yaourt -S ruby-build
fi
sudo pacman -S --needed gcc5 base-devel libffi libyaml openssl zlib

read -p "Install ruby ?(Y/N)" ruby
if [ $ruby == 'Y' ] || [ $ruby == 'y' ] ; then
	echo "gcc 7.2 throws segmentation fault"
	echo "Installing ruby 2.4.0 with gcc 5 compiler"
	echo "run rbenv install version to see list"
	CC=/usr/bin/gcc-5 rbenv install 2.4.0
fi

echo "making 2.4.0 global version"
rbenv global 2.4.0

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

echo "check ruby version"
ruby -v

echo "__________"
read -p "install bundler?(Y/N)" b

if [ $b == 'Y' ] || [ $b == 'y' ] ; then
	gem install bundler
fi

echo "rehash rbenv"
rbenv rehash

echo "install rails(latest available)"
gem install rails 
