# icloud_photos_downloader-google-drive

# rclone mount
```
apt install rclone
apt install fuse

rclone config	# with custom client id: https://rclone.org/drive/#making-your-own-client-id

mkdir mount-google-drive
rclone mount --vfs-cache-mode full "gdrive:Apple Photos backup" mount-google-drive/ --daemon
```
# setup icloudpd
```
apt intall python3-pip
pip3 install icloudpd
```

icloud.creds: 
```
email=
password=
```
gmail.creds:
```
gmail_username=
gmail_password=
recipient=
```

[icloud_photos_downloader.sh](./icloud_photos_downloader.sh)

```
chmod +x icloud_photos_downloader.sh
```
# First test  / refresh 2FA
```
./icloud_photos_downloader.sh 
```
# Setup cron
```
crontab -e

0 */6 * * * /root/icloud_photos_downloader.sh cron
```
