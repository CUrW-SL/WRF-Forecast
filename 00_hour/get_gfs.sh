#!/bin/bash

echo $rundate
cd /mnt/disks/wrf-mod/Data/GFS_00/
if [ -f runlock_00.txt ]; then
#ls -lrt
echo "get_00.bash is already running";
exit;
fi 
datafile="${rundate}.gfs.t00z.pgrb2.0p50.f078"
echo $datafile
if [ -f ${datafile} ]; 
then
 find2=`find ./ -size 0 | grep ${rundate}`
 echo $find2
 if [ !-e ${find2}  ]; then
    echo "Data already there";
    exit;
  else
    echo "start downloading"
 fi
else
 echo "Data not downloaded. Start downloading";
fi
rm *.*
touch runlock_00.txt
DataLink="ftp://ftpprd.ncep.noaa.gov/pub/data/nccf/com/gfs/prod/gfs.${rundate}/00"
echo $DataLink
DN=0
PN=0
echo $DataLink
while [ $DN -le 75 ]; do
if [ $DN -gt 10 ]; then
DataName="gfs.t00z.pgrb2.0p50.f0${DN}"
else
DataName="gfs.t00z.pgrb2.0p50.f0${PN}${DN}"
fi
echo Downloading $DataName
wget ${DataLink}/${DataName} -O ./${rundate}.${DataName} 
find3=`find ./ -size 0 | grep ${rundate}`
echo $find3
if [ !-e ${find3}  ]; then
DN=$(( $DN+3 )) 
else
DN=$(( $DN+0 )) 
fi
done
rm runlock_00.txt