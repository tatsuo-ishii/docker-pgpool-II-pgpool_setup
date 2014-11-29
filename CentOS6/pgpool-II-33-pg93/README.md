How to run container (Note: still under construction)
==================

### 1. Build docker image

```
	sudo docker build -t pgpool2_33_pg93_pgpool_setup .
```

### 2. Run docker container

```
	sudo docker run --privileged -i -t pgpool2_33_pg93_pgpool_setup
```
* *--privileged* is mandatory because it does some magics to increase shared memory available in the container. Please take a look at *start.sh* for more details.

