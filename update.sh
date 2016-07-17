#!/bin/bash

###
# CHEAT: update.sh
#
# Updates the cheatsheets installed on the system by pulling the cheatsheets
# git repository.
###

# If our cheat directory doesn't exist, let's create it and clone the repo.
# If it does exist, let's pull the latest content.
if [ ! -d ~/.cheat ]; then
	mkdir ~/.cheat;
	git clone $CHEATSHEET_REPO ~/.cheat/cheatsheets_src
else
	if [ ! -d ~/.cheat/cheatsheets_src ]; then
		git clone $CHEATSHEET_REPO ~/.cheat/cheatsheets_src
	else
		CURRENT_DIR=$(pwd)
		cd ~/.cheat/cheatsheets_src; git pull; cd "$CURRENT_DIR";
	fi
fi

# TO-DO: Only run the following if files are updated.
for file in $HOME/.cheat/cheatsheets_src/*.md
do
	# Extract the filename
	filename=${file##*/}
	filename=${filename%.md}

	# We don't need to convert the README :)
	if [ ! "$filename" == "README" ]; then
		echo "Updating: $filename"

		# Add man headers
		echo ".TH $filename x \"$(date +'%d %B %Y')\" \"x.x\" \"Cheatsheet for: $filename\"" > $HOME/.cheat/$filename

		# Convert from markdown to man page
		pandoc -f markdown -t man "$file" >> /$HOME/.cheat/$filename
	fi
done
