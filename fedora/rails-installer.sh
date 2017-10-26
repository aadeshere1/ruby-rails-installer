#!/bin/bash

set -e

# If you decide to skip the full update, be sure to at least run 'sudo yum update audit -y'
echo "Updates packages. Asks for your password."
sudo yum update -y

echo "Installs packages. Give your password when asked."
yum install git-core zlib zlib-devel gcc-c++ patch readline readline-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison curl sqlite-devel

# Install rbenv
echo "Install rbenv"
cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
exec $SHELL

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
exec $SHELL

# Reload environmental variables
source ~/.bash_profile
source ~/.bashrc

# Verify that rbenv is correctly setup.
echo "Verify that rbenv is correctly setup"
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

# Install Ruby
echo "Install ruby"
rbenv install 2.4.2

# Run the following command to set version 2.4.2 as the default version for all shells.
rbenv global 2.4.2

# Install just gems
echo "Installing gems"
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler
gem install ffi
gem install bindex
gem install rails -v 5.1.4

# Make rails executables known to rbenv
rbenv rehash

# Verify the version of Rails. (should be > 5)
echo "Rails installed!"
rails -v

cd ~
read -p "Create test project? (Y/N)" p
if [ $p == 'Y' ] || [ $p == 'y' ] ; then
  rails new test_project
  cd test_project
fi
