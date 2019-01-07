#!/bin/bash

#Credit to Mardoct on Archwiki

#Check for new XKCD comics.
#So far only able to see if a new one
#is present, not able to discern how
#many new ones exist.

#Each comic is uniquely names and we
#can just compare the line including
#the comic name in the html file
#against the line including the comic
#name the script stored on the last run.


#Get the latest one into .latestxkcd
#On first run create .lastseenxkcd
#We will know if there's a new one if the
#two files aren't the same
cd ~/.config/conky/
wget --quiet -O .xkcdtmp http://xkcd.com
touch .lastseenxkcd

#This strips the HTML file down to be
#exclusively the line with the comic name.
cat .xkcdtmp | grep "img src" | sed -e '3,50d' | sed -e '1d' >> .latestxkcd
rm .xkcdtmp
cat .lastseenxkcd | grep "img src" | cut -d '"' -f 2 | cut -b 3- >> .img

if [ "$(cat .latestxkcd)" != "$(cat .lastseenxkcd)" ]; then 
    echo "New XKCD comic!"
    cat .img | xargs wget -O newxkcd.png
    rm .img
else
    echo "No new XKCD comic"
fi

#Update the last seen comic
rm .lastseenxkcd
mv .latestxkcd .lastseenxkcd

#EOF
