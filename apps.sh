#!/bin/bash
clear

if [ $(tput colors) ]; then # Checks if terminal supports colors
	red="\e[31m"
	green="\e[32m"
	endcolor="\e[39m"
fi

#use sudo rights for the whole script
sudo -s << ODUSO

clear

echo ------------------------
echo "Welcome to my Installer"
echo ------------------------
echo "   "
sleep 2

# Add all the repositories
# echo "Adding Repositories" 
# (
	# server utilities
# curl -sL https://deb.nodesource.com/setup | sudo bash -

	# desktop standards
# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
# sudo echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
# sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886 && echo deb http://repository.spotify.com testing non-free | tee /etc/apt/sources.list.d/spotify.list
# 
	# media
# sudo apt-add-repository ppa:plexapp/plexht -y
# sudo apt-add-repository ppa:jon-severinsson/ffmpeg -y
# sudo apt-add-repository ppa:webupd8team/popcorntime -y 
# sudo apt-add-repository ppa:team-xbmc/ppa -y
# sudo apt-add-repository ppa:deluge-team/ppa -y
# sudo add-apt-repository ppa:jcfp/ppa
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC
# echo "deb http://apt.sonarr.tv/ master main" | tee /etc/apt/sources.list.d/sonarr.list
# ) &> /tmp/repolog && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Updating System" 
(
apt-get update
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

#############
# Utilities #
#############

echo "Installing Xclip"
(
apt-get -y install xclip
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Git"
(
apt-get -y install git git-core
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Vim"
(
apt-get -y install vim-gtk
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Python"
(
apt-get -y install python
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Node"
(
apt-get -y install build-essential
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output


echo "Installing file archiving resources"
(
apt-get install unace rar unrar p7zip-rar p7zip zip unzip sharutils uudeview mpack arj cabextract file-roller -y
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output
echo "Installing Skype"
(
apt-get -y install skype 
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output
echo "Cleaning up"
(
apt-get -y autoremove 
apt-get -y autoclean 
apt-get -y clean
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Ubuntu Restricted Extra"
(
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections 
apt-get install ttf-mscorefonts-installer -y 
apt-get install ubuntu-restricted-addons -y 
apt-get install gstreamer0.10-plugins-bad-multiverse -y 
apt-get install libavcodec-extra-53 -y 
apt-get install unrar -y
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Upgrading old packages"
(
apt-get -y upgrade
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output


ODUSO
notify-send "Oduso" "Finished installing"
exit 0

