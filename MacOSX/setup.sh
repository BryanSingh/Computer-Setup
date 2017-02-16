#!/bin/sh
# Bryan H. Singh
#set -e
echo "Script to help get your developers platform up and running!"
echo "Checking Internet connection ..."

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
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	brew update
fi

git_package()
{
    which git
    if [[ $? != 0 ]]; then
        brew install git
    else
        echo "git is installed"
    fi
}

spotify_package() {

	 which spotify

	if [[ $? != 0 ]]; then
		brew cask install spotify
	else
		echo "spotify is installed"
	fi
}


java_package()
{
	which java
	if [[ $? != 0 ]]; then
		brew cask install java
	else
		echo "Java is installed"
	fi
}

google_chrome_package()
{
	which google-chrome
	if [[ $? != 0 ]]; then
		brew cask install google-chrome
	else
		echo "google chrome is installed"
	fi
}

nmap_package()
{
	which nmap
	if [[ $? != 0 ]]; then
		brew install nmap
	else
		echo "nmap is installed"
	fi
}

wget_package()
{
	which wget
	if [[ $? 1 != 0]]; then
		brew install wget
	else
		echo "wget is installed"
	fi
}

vim_package()
{
	which vim

	if [[ $? != 0 ]]; then
		brew install vim
	else
		echo "vim is installed"
}


sublime_package()
{
	which sublime
	if [[ $? != 0 ]]; then
		brew cask install sublime
	else
		"sublime is installed"
	fi
}

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

install_volitlity()
{
	cd
	mkdir ~/Documents/Developer/forensics/
	cd ~/Documents/Developer/forensics/
	git clone https://github.com/volatilityfoundation/volatility.git
	# cd volatility
}

install_virtualbox()
{
	which virtualbox

	if [[ $? != 0]]; then
		brew cask install virtualbox
	else
		echo "virtualbox is installed"
}

install_vagrant()
{
	which vagrant

	if [[ $? != 0]]; then
		brew cask install vagrant
		brew cask install vagrant-manager
	else
		echo "vagrant is installed"
}

wget_package
sublime_package
nmap_package
#google_chrome_package
java_package
spotify_package
git_package
install_rails
install_database_mySQL
install_database_mySQL