#/bin/bash
if [ ! -f ./ASOT.log ]; then
  echo "New log"‎
  echo 0 > ASOT.log
fi
EP=`curl -v --silent http://www.asotarchive.org --stderr - | grep '[/]episode[/][\?]p=[0-9]*' -o | head -n 2 | tail -n 1`
CU=`echo $EP | grep -o [0-9]*`
LA=`cat ASOT.log`
echo "Current episode"
echo $CU
echo "Last download"
echo $LA
if [ "$LA" \< "$CU" ]; then
  echo "New download"‎
  RD=`curl -v --silent ‎http://www.asotarchive.org$EP --stderr - | grep 'Location: http' | grep -o http[:/a-zA-Z0-9\.-]*`‎
  DL=`curl -v --silent $RD --stderr - | grep -o 'http[^"]*\.mp3'`
  echo $CU > ASOT.log
  cd downloads
  wget -c $DL
fi
