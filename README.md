# icloud_photos_downloader-google-drive

# rclone mount
apt install rclone
apt install fuse

rclone config	# with custom client id: https://rclone.org/drive/#making-your-own-client-id

rclone mount "gdrive:Apple Photos backup" mount-google-drive/ --daemon

# iCloud Photos
apt intall python3-pip
pip3 install icloudpd

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

icloud_photos_downloader.sh:
```bash
#!/bin/bash
# Make sure it's not already running
pgrep -f icloudpd && echo "icloudpd is already running." && exit

source icloud.creds
source gmail.creds
icloudpd --directory ./mount-google-drive/Photos \
--username $email \
--password $password \
--recent 500 --size original   --folder-structure {:%Y/%Y-%m-%d} \
--smtp-username $gmail_username --smtp-password $gmail_password --notification-email $recipient \
--threads-num 1
```

mkdir mount-google-drive

crontab -e:
```
0 */6 * * * /root/icloud_photos_downloader.sh
```
