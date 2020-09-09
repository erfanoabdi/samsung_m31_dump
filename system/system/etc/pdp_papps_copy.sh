#!/system/bin/sh
# Copyright (c) 2016, Samsung Electronics Co., Ltd.

# PDP : Preloaded-Data Preservation

echo "[PDP] pdp_pap__c_p_.sh  cp apks from /s/p to /d/a" > /dev/kmsg
# /system/bin/cp -y -f -v --with-fmode=0664 --with-owner=system.system /system/preload/*.ppk /data/app/*.apk

/system/bin/cp -v -a -f /system/preload/* /data/app 2> /dev/kmsg
# /system/bin/chmod -R 0664 /data/app 2> /dev/kmsg
# /system/bin/chown -R system /data/app 2> /dev/kmsg
# /system/bin/chgrp -R system /data/app 2> /dev/kmsg

# init process is waiting for this work to be finished.  let it knows.
echo "[PDP] pdp_pap__c_p_.s_  done" > /dev/kmsg
/system/bin/mkdir -p /data/pdp_bkup/papps_cp_done
