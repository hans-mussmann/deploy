#!/bin/bash

## Author: Hans Mussmann

echo -e "\n-----------------------------------------------------\n"
echo -e ' - Deploy                                    [START]'

_BRANCH='master'
_REPO='reapster.com.au'
_SITE='reapster.com.au'

echo -e " - Using repo $_REPO"
cd /var/repo/$_REPO/ || exit 1

echo -e " - Fetching branch $_BRANCH"
git branch -r
git checkout $_BRANCH
git pull

echo -e ' - Archive static files e.g. Images and Uploads'
cp -Ru /var/www/$_SITE/images/. /var/www/archive/$_SITE/images/
cp -Ru /var/www/$_SITE/uploads/. /var/www/archive/$_SITE/uploads/

echo -e " - Deploy site $_SITE"
git archive $_BRANCH | tar -x -C /var/www/$_SITE/

echo -e ' - Cleaning up e.g. git'
rm -rf /var/www/$_SITE/.git*

echo -e ' - Restore archived files'
cp -R /var/www/archive/$_SITE/images/*.jp* /var/www/$_SITE/images/
cp -R /var/www/archive/$_SITE/uploads/. /var/www/$_SITE/uploads/

cd ~/

echo -e ' - Deploy                                      [DONE]'
echo -e "\n-----------------------------------------------------\n"

