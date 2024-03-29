#!/bin/bash
set -e

cd "$(dirname "${BASH_SOURCE[0]}")"

MOUNT=./mount-google-drive/Photos

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

update_seetings=
if [[ "$2" == "update" ]]; then
  update_seetings=" --until-found 25 "
 # disable for initial sync

fi


/usr/local/bin/icloudpd --directory $MOUNT \
--username $email \
--password $password \
$email_seetings $update_seetings \
--size original   --folder-structure {:%Y/%Y-%m-%d} \
--threads-num 50  2>&1
