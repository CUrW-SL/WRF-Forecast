#!/bin/bash
export NCARG_ROOT=/usr/local/ncarg
export PATH=$PATH:/usr/bin/
lib_path="/opt/lib"
export NETCDF="$lib_path"/netcdf
export LD_LIBRARY_PATH="$lib_path"/mpich/lib:"$lib_path"/grib2/lib:$LD_LIBRARY_PATH
export LD_INCLUDE_PATH="$lib_path"/mpich/include:/usr/include:"$lib_path"/grib2/include:$LD_INCLUDE_PATH
export PATH=$PATH:"$lib_path"/mpich/bin/
GFS_HR=$1
echo ${GFS_HR}
GFS_WT=$2
echo ${GFS_WT}
GFS_d=$3
echo ${GFS_d}
#rundate1=`date '+%Y-%m-%d' --date="1 days ago"`
rundate1=`date '+%Y-%m-%d' --date="1 days" `
cd /mnt/disks/wrf-mod/progs
mkdir /mnt/disks/wrf_nfs/wrf/4.0/${GFS_d}/${GFS_HR}/${rundate1}/
mkdir /mnt/disks/wrf_nfs/wrf/4.0/${GFS_d}/${GFS_HR}/${rundate1}/${GFS_WT}
cp /mnt/disks/wrf-mod/progs/Scripts/plot_rain_${GFS_WT}_d01_d03_v2.py /mnt/disks/wrf_nfs/wrf/4.0/${GFS_d}/${GFS_HR}/${rundate1}/${GFS_WT}
#ln -fs /mnt/disks/wrf-mod/progs/OUTPUT/d01__${GFS_WT}_${GFS_HR}.nc /mnt/disks/wrf_nfs/wrf/4.0/${GFS_d}/${GFS_HR}/${rundate1}/${GFS_WT}
#ln -fs /mnt/disks/wrf-mod/progs/OUTPUT/d03__${GFS_WT}_${GFS_HR}.nc /mnt/disks/wrf_nfs/wrf/4.0/${GFS_d}/${GFS_HR}/${rundate1}/${GFS_WT}
ln -fs /mnt/disks/wrf-mod/NCLoutput_${GFS_WT}/d01__${GFS_WT}.nc /mnt/disks/wrf_nfs/wrf/4.0/${GFS_d}/${GFS_HR}/${rundate1}/${GFS_WT}/d01__${GFS_WT}_${GFS_HR}.nc
ln -fs /mnt/disks/wrf-mod/NCLoutput_${GFS_WT}/d03__${GFS_WT}.nc /mnt/disks/wrf_nfs/wrf/4.0/${GFS_d}/${GFS_HR}/${rundate1}/${GFS_WT}/d03__${GFS_WT}_${GFS_HR}.nc
cd /mnt/disks/wrf_nfs/wrf/4.0/${GFS_d}/${GFS_HR}/${rundate1}/${GFS_WT}
python3 plot_rain_${GFS_WT}_d01_d03_v2.py
#rm *.bash
exit;