#!/usr/bin/env bash
runcount=1
./rarefail.sh > rarefailout.log 2> rarefailerr.log
while [ $? -eq 0 ]
do
  runcount=$(( $runcount + 1 ))
  ./rarefail.sh >> rarefailout.log 2>> rarefailerr.log
done

echo "stdout"
cat rarefailout.log
echo ""
echo "stderr"
cat rarefailerr.log
echo ""
echo "number of runs"
echo $runcount