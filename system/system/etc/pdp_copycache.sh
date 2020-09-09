#!/system/bin/sh
# Copyright (c) 2016, Samsung Electronics Co., Ltd.

# PDP : Preloaded-Data Preservation

echo "[PDP] p_p_c___c____.sh  cp pd______.tar.gz from /da to /ca" > /dev/kmsg
/system/bin/cp -f /data/pdp_bkup/pdp_bkup.tar.gz /cache/pdp_bkup/pdp_bkup.tar.gz

echo "[PDP] p_p_c___c____.sh  cp pd______.txt from /c to /da" > /dev/kmsg
/system/bin/cp -f /data/pdp_bkup/pdp_list.txt /cache/pdp_bkup/pdp_list.txt

# echo "[PDP] p_p_c___c____.sh  rm /c____/vo___e_re____e" > /dev/kmsg
# /system/bin/rm /cache/volume_reserve

echo "[PDP] p_p_c___c____.sh  cp p___cc_done.txt from /c to /da" > /dev/kmsg
/system/bin/cp -f /data/pdp_bkup/pdp_list.txt /data/pdp_bkup/pdp_cc_done.txt
