#!/usr/bin/env bash
#dropbear -REmwg -p 22
function lazyclone {
    url=$1;
    reponame=$(echo $url | awk -F/ '{print $NF}' | sed -e 's/.git$//');
    git clone $url $reponame;
    cd $reponame;
}
lazyclone $REPO
chmod +x ./gradlew
./gradlew build
nohup ./gradlew bootRun &
while true
do
 echo "Git pull, yo!"
 git pull | grep -v "up-to-date" && ./gradlew build
 sleep 5
done
#tail -f /dev/null
