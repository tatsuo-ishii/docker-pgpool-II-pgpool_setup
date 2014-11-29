docker-pgpool-II-pgpool_setup
=============================

Build pgpool-II + PostgreSQL streaming replication + pgpoolAdmin demo
container.

* All the ports of pgpool-II, pcp, PostgreSQL are exported to outside the container. Thus you could access them like "pgsql -h localhost -p 11000 -U postgres test" (access to pgpool)

* You can ssh into the container and type psql to access the cluster (use "postgres" account. password is same as the account name). Clusters live under /var/lib/postgres/cluster. You can cd to the directory and type "pg_ctl -D data1 -m f stop" to test failover by letting down node 1 PostgreSQL for example.

Caution: __This container is not suitable for production purpose.__

Each subdirectory corresponds to each version.

Here are some sample images of pgpoolAdmin (the web GUI for pgpool-II) running in the container.
***
![pgpoolAdmin (English)](https://raw.githubusercontent.com/wiki/tatsuo-ishii/wiki/images/docker-pgpool-II-pgpool_setup/pgpoolAdmin-en.png)
***
![pgpoolAdmin (Japanese)](https://raw.githubusercontent.com/wiki/tatsuo-ishii/wiki/images/docker-pgpool-II-pgpool_setup/pgpoolAdmin-ja.png)
