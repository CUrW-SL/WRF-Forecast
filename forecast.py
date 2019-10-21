from ftplib import FTP


def get_file(ftp, filename):
    try:
        ftp.retrbinary('RETR ' + filename, open(filename, 'wb').write)
    except:
        print('Error')


def connect_gfs_ftp_server():
    ftp = FTP('ftp.ncep.noaa.gov')
    ftp.login()
    print(ftp.pwd())
    ftp.cwd('/pub/data/nccf/com/gfs/prod/gfs.20191020/18/')
    print(ftp.retrlines('LIST'))


if __name__ == '__main__':
    connect_gfs_ftp_server()

