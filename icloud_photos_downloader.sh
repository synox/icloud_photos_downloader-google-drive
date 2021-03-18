#!/bin/bash
# Make sure it's not already running
pgrep -f icloudpd && echo "icloudpd is already running." && exit

MOUNT=mount-google-drive/Photos

# Make sure the mount is active
if [ ! -d $MOUNT/ ]; then
  echo $MOUNT is not mounted;
  exit 1
fi

source icloud.creds
source gmail.creds

email_seetings=
if [[ "$1" == "cron" ]]; then
  email_seetings="--smtp-username $gmail_username --smtp-password $gmail_password --notification-email $recipient"
fi

icloudpd --directory ./$MOUNT \
--username $email \
--password $password \
$email_seetings \
--recent 500 --size original   --folder-structure {:%Y/%Y-%m-%d} \
--threads-num 1
