#!/bin/sh
# Bryan H. Singh
#set -e
echo "Script to help get your devleopers paltform up and running!"
echo "Checking internet connection ..."

#8.8.8.8 is a server hosted by google
if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
	echo "ipv4 is up!"
else
	echo "ipv4 is down :("
	echo "Will try to connect, please wait ..."
	networksetup -setairportpower en0 on
	sleep 15s
fi

DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# check to see if homebrew is installed
which brew
if [[ $? != 0 ]]; then
	# install homebrew
	/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"
else
	brew update
fi

# check to see if git is installed
which git
if [[ $? != 0 ]]; then
	brew install git
else
	echo "git is installed"
fi

# check spotify
which spotify

if [[ $? != 0 ]]; then
	brew cask install spotify
else
	echo "spotify is installed"
fi

#check java
which java
if [[ $? != 0 ]]; then
	brew cask install java
else
	echo "Java is installed"
fi

which google-chrome
if [[ $? != 0 ]]; then
	brew cask install google-chrome
else
	echo "google chrome is installed"
fi

which nmap
if [[ $? != 0 ]]; then
	brew install nmap
else
	"nmap is installed"
fi

which sublime
if [[ $? != 0 ]]; then
	brew cask install sublime
else
	"sublime is installed"
fi
install_rails()
{
	# check to see if homebrew is installed
	which brew
	if [[ $? != 0 ]]; then
		# install homebrew
		/usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/gist/323731)"
	else
		brew update
	fi

	brew install rbenv ruby-build
	# Add rbenv to bash so that it loads every time you open a terminal
	echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
	source ~/.bash_profile

	# Install Ruby
	rbenv install 2.4.0
	rbenv global 2.4.0
	ruby -v

	gem install rails -v 5.0.1
	rbenv rehash
	rails -v
}
install_database_mySQL()
{
	#By default the mysql user is root with no password.

	# To have launchd start mysql at login:
	ln -sfv /usr/local/opt/mysql/*plist ~/Library/LaunchAgents

	# Then to load mysql now:
	launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
}

install_database_postgresql()
{
	brew install postgresql
	# To have launchd start postgresql at login:
	ln -sfv /usr/local/opt/postgresql/*plist ~/Library/LaunchAgents

	# Then to load postgresql now:
	launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist

	#By default the postgresql user is your current OS X username with no password. 
}
install_rails
install_database_mySQL
install_database_mySQL