#!/bin/bash
set -eo pipefail

has() {
  [[ -x "$(command -v "$1")" ]];
}

has_not() {
  ! has "$1" ;
}

ok() {
  echo "→ "$1" OK"
}

sudo apt-get update
sudo apt-get install -y \
    curl 


if has_not code; then
  # install the dependencies and wget
  sudo apt-get install -y software-properties-common apt-transport-https wget 
  # import the Microsoft GPG key using the following wget command:
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
  # enable vscode repo 
  sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
  # finally update and install vscode
  sudo apt update
  sudo apt install code
fi
ok 'Visual Studio code installed, use code to open it up'

if has_not google-chrome-stable; then
  wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg --force-depends -i chrome.deb
  sudo apt-get install -fy
  rm chrome.deb
fi
ok "Chrome"

if has_not vlc; then #Check if vlc is not installedt hen install using snap
  sudo snap install -y vlc
fi
ok 'vlc'
if has not slack; then 
    sudo snap install slack --classic
fi
ok 'Slack'
if has_not prey; then #Installing prey
    wget https://downloads.preyproject.com/prey-client-releases/node-client/1.6.6/prey_1.9.2_amd64.deb
    sudo apt-get install giblib1 libimlib2 mpg123 scrot streamer xawtv-plugins
    sudo dpkg -i prey_1.9.2_amd64.deb
    prey config gui
fi
ok 'Successfully configured prey'

#Clean up and system upgrade
sudo apt-get -f install
sudo apt-get upgrade
sudo apt-get dist-upgrade
sudo apt-get autoclean -y
sudo apt-get autoremove -y

ok 'Installation complete'




