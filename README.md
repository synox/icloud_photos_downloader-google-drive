# icloud_photos_downloader-google-drive

pip install icloudpd

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


source icloud.creds
source gmail.creds

icloudpd --directory ./mount-google-drive/Photos \
--username $email \
--password $password \
--recent 500 --size original   --folder-structure {:%Y/%Y-%m-%d} \
--smtp-username $gmail_username --smtp-password $gmail_password --notification-email $recipient \
--threads-num 1
