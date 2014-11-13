#! /bin/bash
# 1GB shared memory
umount /dev/shm
mount -t tmpfs -o rw,nosuid,nodev,noexec,relatime,size=256M tmpfs /dev/shm
sysctl -w kernel.shmmax=1063256064
sysctl -w kernel.shmall=259584
ipcs -l
service sshd start
if [ ! -d /var/volum/$PGPOOL_BRANCH ];then
    mkdir /var/volum/$PGPOOL_BRANCH
fi
service memcached start
chown -R postgres /var/volum/$PGPOOL_BRANCH
export PGBIN=/usr/pgsql-${POSTGRESQL_VERSION}/bin
export PGPOOL_INSTALL_DIR=/usr
export PGPOOLDIR=/etc/pgpool-II
su postgres
