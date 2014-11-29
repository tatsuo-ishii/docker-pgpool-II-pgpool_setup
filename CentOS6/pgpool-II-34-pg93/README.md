How to run docker container
==================

### 1. Build docker image

```
	sudo docker build -t pgpool2_34_pg93_pgpool_setup .
```

### 2. Run docker container

```
	sudo docker run -p 8080:80 -p 11000:11000 -p 11001:11001 -p 11002:11002 -p 11003:11003 -p 11004:11004 --privileged --name="pgpool_demo" -t pgpool2_34_pg93_pgpool_setup
```
* *--privileged* is mandatory because it does some magics to increase shared memory available in the container. Please take a look at *start.sh* for more details.
* port 8080 can be accesed for pgpoolAdmin (url: http://localhost:8080)
* port 11002 is the port number for database node 0
* port 11003 is the port number for database node 1
* port 11004 is the port number for database node 2
* port 11000 is the port number for pgpool-II
* port 11001 is the port number for pcp command

Since sshd is running inside the container, you can ssh login to it. To know the IP address type:

```
	sudo docker ps a
	CONTAINER ID        IMAGE                                 COMMAND                CREATED             STATUS              PORTS                                                                                                                                                    NAMES
b9ffb0800ca5        pgpool2_34_pg93_pgpool_setup:latest   /bin/sh -c /tmp/star   26 minutes ago      Up 22 minutes       0.0.0.0:8080->80/tcp, 0.0.0.0:11000->11000/tcp, 0.0.0.0:11001->11001/tcp, 0.0.0.0:11002->11002/tcp, 0.0.0.0:11003->11003/tcp, 0.0.0.0:11004->11004/tcp   pgpool_demo
	sudo docker inspect --format ' {{ .NetworkSettings.IPAddress }} ' pgpool_demo
	172.16.0.243
```

Then login to the container. Account "postgres" (password is same as the account name) and root (password is same as the account name) are prepared.

```
	ssl -l postgres -h 172.16.0.243
```

The container is running forever. To stop the container, type:

```
	sudo docker stop pgpool_demo
```

Of course you need to change the container id.

You can access pgpool-II and PostgreSQL from outside of the container. For example to access pgpool-II, type:

```
	psql -p 11000 -h localhost -U postgres test
	psql (9.4rc1, server 9.3.5)
	Type "help" for help.
	
	test=# show pool_nodes;
	 node_id | hostname | port  | status | lb_weight |  role   
	 ---------+----------+-------+--------+-----------+---------
	  0       | /tmp     | 11002 | 2      | 0.333333  | primary
	  1       | /tmp     | 11003 | 2      | 0.333333  | standby
	  2       | /tmp     | 11004 | 2      | 0.333333  | standby
	  (3 rows)

```