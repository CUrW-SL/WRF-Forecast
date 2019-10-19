#!/bin/bash
lib_path="/opt/lib"
export NETCDF="$lib_path"/netcdf
export LD_LIBRARY_PATH="$lib_path"/mpich/lib:"$lib_path"/grib2/lib:$LD_LIBRARY_PATH
export LD_INCLUDE_PATH="$lib_path"/mpich/include:/usr/include:"$lib_path"/grib2/include:$LD_INCLUDE_PATH
export PATH=$PATH:"$lib_path"/mpich/bin/
rm /mnt/disks/wrf-mod/OUTPUT_A_18/wrfout_d01*
rm /mnt/disks/wrf-mod/OUTPUT_A_18/wrfout_d02*
rm /mnt/disks/wrf-mod/OUTPUT_A_18/wrfout_d03*
#iundate=`date '+%Y%m%d' --date="1 days ago"`
#rundate1=`date '+%Y-%m-%d' --date="1 days ago"`
rundate=`date '+%Y%m%d' --date="2 days ago"`
rundate1=`date '+%Y-%m-%d' --date="2 days ago"`
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
cd /mnt/disks/wrf-mod/
lockfile="wrflock4_A_18.txt"
if [ -f ${lockfile} ]
then
 echo "Simulation has already started";
 exit;
else
 echo "start simulation ${rundate}";
 touch wrflock4_A_18.txt
fi
ulimit -s unlimited
mpdboot
cd /mnt/disks/wrf-mod/WRFV4_A/test/em_real/
sed -e 's/YY1/'$year1'/'g -e 's/MM1/'$month1'/'g -e 's/DD1/'$date1'/'g  -e 's/YY2/'$year2'/'g -e 's/MM2/'$month2'/'g -e 's/DD2/'$date2'/'g namelist.inputA_18 > namelist.input
rm met_em*
rm rsl*
# edit namelist.input for dates
linkmet="ln -sf ../../../WPS4/met_em.d0* ."
$linkmet
./real.exe
./wrf.exe
mv wrfout_d0* /mnt/disks/wrf-mod/OUTPUT_A_18
cd /mnt/disks/wrf-mod/NCLoutput_A/
ln -fs /mnt/disks/wrf-mod/OUTPUT_A_18/wrfout_d01_* d01__A.nc
ln -fs /mnt/disks/wrf-mod/OUTPUT_A_18/wrfout_d02_* d02__A.nc
ln -fs /mnt/disks/wrf-mod/OUTPUT_A_18/wrfout_d03_* d03__A.nc
#cp /mnt/disks/wrf-mod/OUTPUT_A_18/wrfout_d01_* ./d01__A.nc
#cp /mnt/disks/wrf-mod/OUTPUT_A_18/wrfout_d02_* ./d02__A.nc
#cp /mnt/disks/wrf-mod/OUTPUT_A_18/wrfout_d03_* ./d03__A.nc
#cd /mnt/disks/wrf-mod/NCLoutput_A/
#runncl="./PrecipM_A_18.bash"
#$runncl
cd /mnt/disks/wrf-mod/
rm -f wrflock4_A_18.txt
exit;
