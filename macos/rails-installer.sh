#Install homebrew on computer
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#Install ruby build
brew install rbenv ruby-build

echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

#Install Ruby

echo "Please enter your perfered Ruby version: "
read version
stages="install global"

for stage in $stages; do
  rbenv $stage $version
done

#Install Gems

gems="bundler rails"

for gem in $gems; do
  gem install $gem
done

rbenv rehash