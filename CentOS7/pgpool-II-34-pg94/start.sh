#! /bin/bash
# 1GB shared memory
umount /dev/shm
mount -t tmpfs -o rw,nosuid,nodev,noexec,relatime,size=256M tmpfs /dev/shm
sysctl -w kernel.shmmax=1063256064
sysctl -w kernel.shmall=259584
ipcs -l

# Start servers
service sshd start
service httpd start
service memcached start

export PGBIN=/usr/pgsql-${POSTGRESQL_VERSION}/bin
export PGPOOL_INSTALL_DIR=/usr
export PGPOOLDIR=/etc/pgpool-II
chown postgres /var/www/html/pgpoolAdmin/conf/pgmgt.conf.php
su -c 'sh /tmp/pgpool_setup.sh' postgres
