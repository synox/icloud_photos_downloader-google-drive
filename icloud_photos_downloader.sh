#!/bin/bash
# Make sure it's not already running
pgrep -f icloudpd && echo "icloudpd is already running." && exit

# Make sure the mount is active
if [ ! -d mount-google-drive/Photos/ ]; then
  echo mount-google-drive/Photos is not mounted; 
  exit 1
fi

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
