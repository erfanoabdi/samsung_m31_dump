#!/system/bin/sh
if ! applypatch --check EMMC:/dev/block/platform/13520000.ufs/by-name/recovery:71106560:ad7ab3d9224a7ba98147939545becde31623fc8a; then
  applypatch \
          --patch /system/recovery-from-boot.p \
          --source EMMC:/dev/block/platform/13520000.ufs/by-name/boot:61865984:9bc0c021bc84c58a85a079c76c0adbcc8ac7c5d0 \
          --target EMMC:/dev/block/platform/13520000.ufs/by-name/recovery:71106560:ad7ab3d9224a7ba98147939545becde31623fc8a && \
      log -t install_recovery "Installing new recovery image: succeeded" || \
      echo 454 > /cache/fota/fota.status
else
  log -t recovery "Recovery image already installed"
fi

if [ -e /cache/recovery/command ] ; then
  PACKAGE_PATH=""
  SEARCH_COMMAND="--update_package"
  PATH_POS=16
  if [ -e '/system/bin/grep' ] ; then
    PACKAGE_PATH=`cat /cache/recovery/command | grep 'update_package'`
    PACKAGE_ORG_PATH=`cat /cache/recovery/command | grep 'update_org_package'`
    if [ "$PACKAGE_ORG_PATH" != "" ] ; then
      PACKAGE_PATH=$PACKAGE_ORG_PATH
      SEARCH_COMMAND="--update_org_package"
      PATH_POS=20
    fi
    if [ -e /cache/recovery/saved" ] ; then
      rm -rf /cache/recovery/saved
    fi

    if [ -e /data/.recovery/saved" ] ; then
      rm -rf /data/.recovery/saved
    fi
  fi
  if [ "$PACKAGE_PATH" != "" ] ; then
    for PACKAGE_LINE in $PACKAGE_PATH
    do
      if [ ${PACKAGE_LINE:0:$PATH_POS} == $SEARCH_COMMAND ] ; then
        break
      fi
    done
    let PATH_POS+=1
    PACKAGE_PATH=${PACKAGE_LINE:$PATH_POS}
    if [ "${PACKAGE_PATH:0:7}" == "@/cache" ] ; then
      if [ -e /cache/recovery/uncrypt_file ] ; then
        UNCRYPT_PACKAGE_PATH=`cat /cache/recovery/uncrypt_file`
        PACKAGE_PATH=$UNCRYPT_PACKAGE_PATH
        echo "The delta path is changed by uncrypt_file" >> /cache/fota/install_recovery.log
      fi
    fi
  fi   
  if [ "$PACKAGE_PATH" != "" ] ; then
    rm $PACKAGE_PATH
    log -t install_recovery "install_recovery tried to remove the delta"
    echo "install_recovery tried to remove the delta" >> /cache/fota/install_recovery.log
    if [ -e "$PACKAGE_PATH" ]; then
      log -t install_recovery "The delta was not removed in install-recovery.sh"
      echo "The delta was not removed in install-recovery.sh" >> /cache/fota/install_recovery.log
    else
      log -t install_recovery "The delta was removed in install-recovery.sh"
      echo "The delta was removed in install-recovery.sh" >> /cache/fota/install_recovery.log
    fi      
  fi
  if [ "${PACKAGE_PATH:0:5}" == "/data" ] ; then
    echo $PACKAGE_PATH > /cache/fota/fota_path_command
    chown system:system /cache/fota/fota_path_command
  fi
  chown system:system /cache/fota/install_recovery.log
  rm /cache/recovery/command
fi
