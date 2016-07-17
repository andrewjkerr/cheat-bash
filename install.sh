#!/bin/bash

###
# CHEAT: install.sh
#
# The cheat-bash installer.
###

echo '~~ CHEAT INSTALLER ~~'
echo 'For assistance, please contact @andrewuf on Twitter'
echo 'or open up an issue on GitHub: https://github.com/andrewjkerr/cheat-bash.'
echo ''
echo 'Thanks!'
echo ''
echo 'Enter the git URL of the cheatsheet repository you would like to use:'

read repo_url

# Check if ~/.cheat exists. If it does, ask for permission to remove and create it.
# If it does not exist, then just create it.
if [ -d ~/.cheat ]; then
	echo 'Is it ok to remove the ~/.cheat directory? (Y/n)'
	read answer
	if [ "$answer" == "Y" ]; then
		rm -rf ~/.cheat
		mkdir ~/.cheat
	else
		echo 'Installation failed - ~/.cheat already exists'
		exit 1
	fi
else
	mkdir ~/.cheat
fi

echo 'Cloning the scripts!'
git clone https://github.com/andrewjkerr/cheat-bash.git ~/.cheat/scripts
chmod +x ~/.cheat/scripts/*
mkdir ~/.cheat/bin
mv ~/.cheat/scripts/cheat ~/.cheat/bin

echo 'Cloning the sheets!'
export CHEATSHEET_REPO=$repo_url
bash ~/.cheat/scripts/update.sh

echo 'Installation done! Please make sure to update your ~/.bashrc or ~/.zshrc to include'
echo 'the path to the `cheat` script:'
echo 'export PATH="$PATH:$HOME/.cheat/bin"'
