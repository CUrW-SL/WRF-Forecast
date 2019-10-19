#!/bin/bash
lib_path="/opt/lib"
export NETCDF="$lib_path"/netcdf
export LD_LIBRARY_PATH="$lib_path"/mpich/lib:"$lib_path"/grib2/lib:$LD_LIBRARY_PATH
export LD_INCLUDE_PATH="$lib_path"/mpich/include:/usr/include:"$lib_path"/grib2/include:$LD_INCLUDE_PATH
export PATH=$PATH:"$lib_path"/mpich/bin/
rundate=`date '+%Y%m%d' --date="2 days ago"`
rundate1=`date '+%Y-%m-%d' --date="2 days ago"`
#rundate=`date '+%Y%m%d' --date="1 days ago"`
#rundate1=`date '+%Y-%m-%d' --date="1 days ago"`
#rundate=`date '+%Y%m%d'`
#rundate1=`date '+%Y-%m-%d'`
#rundate="20161111"
#rundate1="2016-11-11"
year1=${rundate:0:4}
month1=${rundate:4:2}
date1=${rundate:6:2}
rundate2=`date '+%Y%m%d' --date " 1 days"`
#rundate2=`date '+%Y%m%d' --date " 2 days"`
#rundate2=`date '+%Y%m%d' --date " 3 days"`
year2=${rundate2:0:4}
month2=${rundate2:4:2}
date2=${rundate2:6:2}
#month1=`date '+%m'`
#date1=`date '+%d'`
#year2=`date '+%Y' --date " 3 days"`
#month2=`date '+%m' --date " 3 days"`
#date2=`date '+%d' --date " 3 days"`
cd /mnt/disks/wrf-mod/Data/GFS_18
find1="${rundate}.gfs.t18z.pgrb2.0p50.f075"
if [ -f ${find1} ]; then
find2=`find ./ -size 0 | grep ${rundate}`
if [ !-e ${find2} ];
then
  echo " ${rundate} Data available";
else
  echo "Data not yet available";
  exit;
fi
else
echo "Data not yet available";
exit;
fi
cd /mnt/disks/wrf-mod/
lockfile="wpslock4_18.txt"
if [ -f ${lockfile} ]
then
 echo "Simulation has already started";
 exit;
else
 echo "start simulation ${rundate}";
 touch wpslock4_18.txt
fi
ulimit -s unlimited
mpdboot
cd ./WPS4
sed -e 's/YY1/'$year1'/'g -e 's/MM1/'$month1'/'g -e 's/DD1/'$date1'/'g  -e 's/YY2/'$year2'/'g -e 's/MM2/'$month2'/'g -e 's/DD2/'$date2'/'g namelist.wps2_18 > namelist.wps
rm FILE:*
rm PFILE:*
rm met_em*
link="./link_grib.csh ../Data/GFS_18/$rundate"
$link
ungrib="./ungrib.exe"
$ungrib
#geogrid="./geogrid.exe"
#$geogrid
metgrid="./metgrid.exe"
$metgrid
cd /mnt/disks/wrf-mod/
rm -rf wpslock4_18.txt
exit;
