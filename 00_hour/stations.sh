#!/bin/bash
export NCARG_ROOT=/usr/local/ncarg
export PATH=$PATH:/usr/bin/
lib_path="/opt/lib"
export NETCDF="$lib_path"/netcdf
export LD_LIBRARY_PATH="$lib_path"/mpich/lib:"$lib_path"/grib2/lib:$LD_LIBRARY_PATH
export LD_INCLUDE_PATH="$lib_path"/mpich/include:/usr/include:"$lib_path"/grib2/include:$LD_INCLUDE_PATH
export PATH=$PATH:"$lib_path"/mpich/bin/
rundate1=`date '+%Y-%m-%d' --date="1 days ago"`
cd /mnt/disks/wrf-mod/
mkdir -p STATIONS_$rundate1
cd STATIONS_$rundate1

cp /mnt/disks/wrf-mod/Scripts/plot_rain_C_d01_d03.py .
cp /mnt/disks/wrf-mod/Scripts/plot_rain_A_d01_d03.py .
cp /mnt/disks/wrf-mod/Scripts/plot_rain_E_d01_d03.py .
cp /mnt/disks/wrf-mod/Scripts/plot_rain_SE_d01_d03.py .

ln -fs /mnt/disks/wrf-mod/NCLoutput_C/d01__C.nc .
ln -fs /mnt/disks/wrf-mod/NCLoutput_A/d01__A.nc .
ln -fs /mnt/disks/wrf-mod/NCLoutput_E/d01__E.nc .
ln -fs /mnt/disks/wrf-mod/NCLoutput_SE/d01__SE.nc .

ln -fs /mnt/disks/wrf-mod/NCLoutput_C/d03__C.nc .
ln -fs /mnt/disks/wrf-mod/NCLoutput_A/d03__A.nc .
ln -fs /mnt/disks/wrf-mod/NCLoutput_E/d03__E.nc .
ln -fs /mnt/disks/wrf-mod/NCLoutput_SE/d03__SE.nc .

python3 plot_rain_C_d01_d03.py
python3 plot_rain_A_d01_d03.py
python3 plot_rain_E_d01_d03.py
python3 plot_rain_SE_d01_d03.py
#rm *.bash
exit;
