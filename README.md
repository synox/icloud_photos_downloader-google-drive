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

# Make sure the mount is active
test -d mount-google-drive/Photos/ || (echo mount-google-drive/Photos is not mounted; exit 1)

source icloud.creds
source gmail.creds

email_seetings=
if [[ "$1" == "cron" ]]; then
  email_seetings="--smtp-username $gmail_username --smtp-password $gmail_password --notification-email $recipient"
fi

icloudpd --directory ./mount-google-drive/Photos \
--username $email \
--password $password \
$email_seetings \
--recent 500 --size original   --folder-structure {:%Y/%Y-%m-%d} \
--threads-num 1
```

mkdir mount-google-drive
chmod +x icloud_photos_downloader.sh

./icloud_photos_downloader.sh # for initial 2FA setup

crontab -e:
```
0 */6 * * * /root/icloud_photos_downloader.sh
```

# sign in 
source icloud.creds
icloud --username $email
