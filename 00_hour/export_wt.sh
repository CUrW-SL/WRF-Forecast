#!/bin/bash
export NCARG_ROOT=/usr/local/ncarg
export PATH=$PATH:/usr/bin/
lib_path="/opt/lib"
export NETCDF="$lib_path"/netcdf
export LD_LIBRARY_PATH="$lib_path"/mpich/lib:"$lib_path"/grib2/lib:$LD_LIBRARY_PATH
export LD_INCLUDE_PATH="$lib_path"/mpich/include:/usr/include:"$lib_path"/grib2/include:$LD_INCLUDE_PATH
export PATH=$PATH:"$lib_path"/mpich/bin/
#rundate1=`date '+%Y-%m-%d' --date="1 days ago"`
rundate1=`date '+%Y-%m-%d' --date="+1 days"`
cd /mnt/disks/wrf/
mkdir /mnt/disks/wrf_nfs/wrf/4.0/18/C/$rundate1
mkdir /mnt/disks/wrf_nfs/wrf/4.0/18/A/$rundate1
mkdir /mnt/disks/wrf_nfs/wrf/4.0/18/E/$rundate1
mkdir /mnt/disks/wrf_nfs/wrf/4.0/18/SE/$rundate1

cp /mnt/disks/wrf-mod/Scripts/plot_rain_C_d01_d03_v2.py /mnt/disks/wrf_nfs/wrf/4.0/18/C/$rundate1
cp /mnt/disks/wrf-mod/Scripts/plot_rain_A_d01_d03_v2.py /mnt/disks/wrf_nfs/wrf/4.0/18/A/$rundate1
cp /mnt/disks/wrf-mod/Scripts/plot_rain_E_d01_d03_v2.py /mnt/disks/wrf_nfs/wrf/4.0/18/E/$rundate1
cp /mnt/disks/wrf-mod/Scripts/plot_rain_SE_d01_d03_v2.py /mnt/disks/wrf_nfs/wrf/4.0/18/SE/$rundate1

ln -fs /mnt/disks/wrf-mod/NCLoutput_C/d01__C.nc /mnt/disks/wrf_nfs/wrf/4.0/18/C/$rundate1
ln -fs /mnt/disks/wrf-mod/NCLoutput_A/d01__A.nc /mnt/disks/wrf_nfs/wrf/4.0/18/A/$rundate1
ln -fs /mnt/disks/wrf-mod/NCLoutput_E/d01__E.nc /mnt/disks/wrf_nfs/wrf/4.0/18/E/$rundate1
ln -fs /mnt/disks/wrf-mod/NCLoutput_SE/d01__SE.nc /mnt/disks/wrf_nfs/wrf/4.0/18/SE/$rundate1

ln -fs /mnt/disks/wrf-mod/NCLoutput_C/d03__C.nc /mnt/disks/wrf_nfs/wrf/4.0/18/C/$rundate1
ln -fs /mnt/disks/wrf-mod/NCLoutput_A/d03__A.nc /mnt/disks/wrf_nfs/wrf/4.0/18/A/$rundate1
ln -fs /mnt/disks/wrf-mod/NCLoutput_E/d03__E.nc /mnt/disks/wrf_nfs/wrf/4.0/18/E/$rundate1
ln -fs /mnt/disks/wrf-mod/NCLoutput_SE/d03__SE.nc /mnt/disks/wrf_nfs/wrf/4.0/18/SE/$rundate1

cd /mnt/disks/wrf_nfs/wrf/4.0/18/C/$rundate1/
python3 plot_rain_C_d01_d03_v2.py
cd /mnt/disks/wrf_nfs/wrf/4.0/18/A/$rundate1/
python3 plot_rain_A_d01_d03_v2.py
cd /mnt/disks/wrf_nfs/wrf/4.0/18/E/$rundate1/
python3 plot_rain_E_d01_d03_v2.py
cd /mnt/disks/wrf_nfs/wrf/4.0/18/SE/$rundate1/
python3 plot_rain_SE_d01_d03_v2.py
#rm *.bash
exit;