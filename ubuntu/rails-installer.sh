#Update Ubuntu

sudo apt-get update

# Install dependencies

packages = "autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev"

for package in $packages; do
  if ! type $package > /dev/null; then
    sudo apt-get install $software
  fi
done

#Install rbenv

rbenv_link = "https://github.com/rbenv/rbenv.git"
rbenv_path = ~/.rbenv

if [ ! -d $rbenv_path ];
  then git clone $rbenv_link $rbenv_path
fi

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

source ~/.bashrc

#Install ruby-build

ruby_build_link = "https://github.com/rbenv/ruby-build.git"
ruby_build_path = ~/.rbenv/plugins/ruby-build

if [ ! -d $ruby_build_path ];
  then git clone $ruby_build_link $ruby_build_path
fi

#Install Ruby

echo "Please enter your perfered Ruby version: "
read version
stages = "install global"

for stage in $stages; do
  rbenv $stage $version
done

#Install Gems

gems = "bundler rails"

for gem in $gems; do
  gem install $gem
done

rbenv rehash