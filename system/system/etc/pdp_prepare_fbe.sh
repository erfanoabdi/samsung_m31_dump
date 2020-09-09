#!/system/bin/sh
# Copyright (c) 2016, Samsung Electronics Co., Ltd.

# PDP : Preloaded-Data Preservation

# Unzip & un-tar
echo "[PDP] pdp_prep___fb_.s_  gunzip app__apk_.tar.gz to /d" > /dev/kmsg
/system/bin/gunzip -k /data/pdp_bkup/apps_apks.tar.gz

echo "[PDP] pdp_prep___fb_.s_  un-tar app__apk_.tar to /da__/a__" > /dev/kmsg
/system/bin/tar -xpf /data/pdp_bkup/apps_apks.tar -C /data

echo "[PDP] pdp_prep___fb_.s_  un-tar app__de_.tar to /da__/a__" > /dev/kmsg
/system/bin/tar -xpf /data/pdp_bkup/apps_dex.tar -C /data

# Rename file to pdp_bkup
echo "[PDP] pdp_prep___fb_.s_  rename app__apk_.tar.gz to pd__bku_.t__.g_" > /dev/kmsg
/system/bin/rm -f /data/pdp_bkup/pdp_bkup.tar.gz
/system/bin/mv -f /data/pdp_bkup/apps_apks.tar.gz /data/pdp_bkup/pdp_bkup.tar.gz

# remove temporary *.tar files
echo "[PDP] pdp_prep___fb_.s_  rm app__apk_.tar * app__de_.tar at /d" > /dev/kmsg
/system/bin/rm -f /data/pdp_bkup/apps_apks.tar
/system/bin/rm -f /data/pdp_bkup/apps_dex.tar

# let know current status, init process is waiting for this
echo "[PDP] pdp_prep___fb_.s_  unz__ & unt___ done" > /dev/kmsg
# /system/bin/mkdir -p --mode='a-rwx' /data/pdp_bkup/pfbe_done
/system/bin/mkdir -p /data/pdp_bkup/pfbe_done