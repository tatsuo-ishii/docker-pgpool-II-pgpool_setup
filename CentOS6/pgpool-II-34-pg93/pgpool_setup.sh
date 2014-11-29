#! /bin/sh
cd $PGHOME
mkdir cluster
cd cluster
pgpool_setup -n 3

ed startall <<EOF
1p
i
rm /tmp/.s.PGSQL.11000
rm /tmp/.s.PGSQL.11001
rm run/pgpool.pid
.
w
q
E
EOF

for i in data0 data1 data2
do
    echo "host    all             all             0.0.0.0/0            trust" >> $i/pg_hba.conf
done
echo "listen_addresses ='*'" >> etc/pgpool.conf
./startall
while true
do
  sleep 60
done
