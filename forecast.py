from ftplib import FTP


def connect_gfs_ftp_server():
    ftp = FTP('ftp.ncep.noaa.gov')
    ftp.login()
    print(ftp.pwd())
    print(ftp.retrlines('LIST'))
    ftp.cwd('data/nccf/com/gfs/prod')


if __name__ == '__main__':
    connect_gfs_ftp_server()

