# =================================
# JF Vuillaume 2018
# Plot stations C
# import matplotlib
# matplotlib.use('Agg')
# import matplotlib.pyplot as plt
import datetime as dt  # Python standard library datetime  module
import numpy as np
from netCDF4 import Dataset  # http://code.google.com/p/netcdf4-python/
import netCDF4
import pandas as pd
from datetime import date, timedelta
import datetime as dt
import datetime
import xarray as xr
import subprocess

date = str(date.today() - timedelta(1)).split()[0]

# Save rsl file for error track
subprocess.run("cp -f /mnt/disks/wrf-mod/progs/run_A.log", shell=True)

# link d01
# ln -fs /mnt/disks/wrf-mod/NCLoutput_C/d01__C.nc ./d01__C.nc
# Extract lat #6.3 7.4
#        lon #79.6 81
nc_f = "./d01__A_18.nc"
# Save RAINNC and RAINC
nc_fid = Dataset(nc_f, 'r')
lats = nc_fid.variables['XLAT'][0, :, :]  # extract/copy the data
lons = nc_fid.variables['XLONG'][0, :, :]
print(lats[38:44, 0])  # 89, 79
print(lons[0, 34:41])
ds = xr.open_dataset(nc_f, engine="netcdf4")
ds.RAINNC[:, 38:44, 34:41].to_netcdf(path="d01_RAINNC.nc", engine="scipy")
ds.RAINC[:, 38:44, 34:41].to_netcdf(path="d01_RAIN.nc", engine="scipy")
ds.U10[:, 38:44, 34:41].to_netcdf(path="d01_U10.nc", engine="scipy")
ds.V10[:, 38:44, 34:41].to_netcdf(path="d01_V10.nc", engine="scipy")
ds.U[:, 0, 38:44, 34:41].to_netcdf(path="d03_U1.nc", engine="scipy")
ds.V[:, 0, 38:44, 34:41].to_netcdf(path="d03_V1.nc", engine="scipy")
# [6.2375183 6.4810715 6.7245026 6.967819  7.211014  7.454071 ]
# [79.54869  79.79375  80.03881  80.283875 80.52894  80.774    81.019066]
nc_f = "./d03__A_18.nc"
# Save RAINNC and RAINC
ds = xr.open_dataset(nc_f, engine="netcdf4")
ds.RAINNC.to_netcdf(path="d03_RAINNC.nc", engine="scipy")
ds.U10.to_netcdf(path="d03_U10.nc", engine="scipy")
ds.V10.to_netcdf(path="d03_V10.nc", engine="scipy")
ds.U[:, 0, :, :].to_netcdf(path="d03_U1.nc", engine="scipy")
ds.V[:, 0, :, :].to_netcdf(path="d03_V1.nc", engine="scipy")