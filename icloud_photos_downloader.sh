#!/bin/bash
set -e

cd "$(dirname "${BASH_SOURCE[0]}")"

# Make sure it's not already running
pgrep --full ${BASH_SOURCE[0]} |grep -v "$BASHPID" && echo "${BASH_SOURCE[0]} is already running." && exit

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

icloudpd --directory $MOUNT \
--username $email \
--password $password \
$email_seetings \
--size original   --folder-structure {:%Y/%Y-%m-%d} \
--threads-num 50
