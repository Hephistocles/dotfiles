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
echo "Adding Repositories" 
(
	# server utilities
curl -sL https://deb.nodesource.com/setup | sudo bash -

	# desktop standards
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886 && echo deb http://repository.spotify.com testing non-free | tee /etc/apt/sources.list.d/spotify.list

	# media
# sudo apt-add-repository ppa:plexapp/plexht -y
sudo apt-add-repository ppa:jon-severinsson/ffmpeg -y
# sudo apt-add-repository ppa:webupd8team/popcorntime -y 
# sudo apt-add-repository ppa:team-xbmc/ppa -y
sudo apt-add-repository ppa:deluge-team/ppa -y
sudo add-apt-repository ppa:jcfp/ppa
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC
# echo "deb http://apt.sonarr.tv/ master main" | tee /etc/apt/sources.list.d/sonarr.list
) &> /tmp/repolog && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

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
apt-get -y install nodejs build-essential
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output


echo "Installing file archiving resources"
(
apt-get install unace rar unrar p7zip-rar p7zip zip unzip sharutils uudeview mpack arj cabextract file-roller -y
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

#############
#  Desktop  #
#############
echo "Installing Spotify"
(
apt-get install spotify-client -y
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

# echo "Installing Sublime 3"
# (
# apt-get -y install sublime-text-installer
# ) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing VLC"
(
apt-get -y install vlc
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Deluge"
(
apt-get install deluge -y 
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Chrome"
(
apt-get -y install google-chrome-stable
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

# echo "Installing Guake"
# (
# apt-get -y install guake
# ) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

# echo "Installing Arc Theme"
# (
# 	apt-get -y install arc-theme
# ) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

# echo "Installing TexLive"
# (
# apt-get -y install texlive
# ) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

# echo "Installing SABnzbd"
# (
# apt-get -y install sabnzbdplus
# ) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Skype"
(
apt-get -y install skype 
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

echo "Installing Slack"
(
	wget -O - https://slack-ssb-updates.global.ssl.fastly.net/linux_releases/slack-desktop-1.2.6-amd64.deb > /tmp/slack
	apt-get -y install /tmp/slack 
) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output


#############
#   Media   #
#############

# echo "Installing KODI Media Center"
# (
# apt-get -y install xbmc
# ) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

# echo "Installing Stremio"
# (
# 	mkdir -p /opt/stremio
# 	wget -O - http://www.strem.io/download > /tmp/stremio
# 	tar -xvzf /tmp/stremio -C /opt/stremio
# 	curl -SO# http://www.strem.io/3.0/stremio-white-small.png
# 	mv stremio-white-small.png /opt/stremio/
# 	curl -SO# https://gist.githubusercontent.com/claudiosmweb/797b502bc095dabee606/raw/52ad06b73d90a4ef389a384fbc815066c89798eb/stremio.desktop
# mv stremio.desktop /usr/share/applications/
# ) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

# echo "Installing Popcorn Time"
# (
	# p=`mktemp`
	# wget -O - http://popcorn-time.se/Popcorn-Time-linux64.tar.gz > $p
	# tar -xvzf /tmp/$p -C /tmp/$p-2
	# cd $p-2
	# ./install
# ) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

# echo "Installing CouchPotato"
# (
# git clone git://github.com/RuudBurger/CouchPotatoServer.git ~/.couchpotato
# ) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

# echo "Installing Sonarr"
# (
# apt-get -y install mono-devel nzbdrone
# ) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output

# echo "Installing Plex Home Theater"
# (
# apt-get -y install plexhometheater
# ) &> /dev/null && echo -e "$green OK $endcolor" || echo -e "$red FAILED $endcolor"; # Hide all output


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

