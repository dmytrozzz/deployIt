#!/usr/bin/env bash
#dropbear -REmwg -p 22
function lazyclone {
    url=$1;
    reponame=$(echo $url | awk -F/ '{print $NF}' | sed -e 's/.git$//');
    git clone $url $reponame;
    cd $reponame;
}
lazyclone $REPO
gradle clean
nohup gradle build & #--continuous &
nohup gradle bootRun -x test &
while true
do
 #echo "Git pull, yo!"
 git pull | grep -v "up-to-date" && gradle clean build
 sleep 10
done
#tail -f /dev/null
