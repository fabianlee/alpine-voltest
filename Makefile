OWNER := fabianlee
PROJECT := alpine-voltest
VERSION := 1.0.0
OPV := $(OWNER)/$(PROJECT):$(VERSION)
EXPOSED_PORT := 8080

## builds docker image
docker-build: 
	sudo docker build -f Dockerfile -t $(OPV) .

## cleans docker image
clean:
	sudo docker image rm $(OPV) | true

## runs container in foreground
docker-test: 
	sudo docker run -it -p $(EXPOSED_PORT):80 $(OPV) /bin/sh

## runs container in foreground, volume mounted at web root
docker-test-volume: 
	sudo docker run -it -p $(EXPOSED_PORT):80 --mount source=test,target=/var/www/localhost/htdocs $(OPV) /bin/sh

## runs container in foreground, 5Mb tmpfs volume mounted
docker-test-tmpfs: 
	sudo docker run -it -p $(EXPOSED_PORT):80 --mount type=tmpfs,destination=/tmpdata,tmpfs-size=5m $(OPV) /bin/sh
	#fallocate -l 7M /tmpdata/myfile.bin

## run container in background
docker-run: 
	sudo docker run -d --rm --name $(PROJECT) -p $(EXPOSED_PORT):80 $(OPV)

## get to console of running container
docker-ssh:
	sudo docker exec -it $(PROJECT) /bin/sh

## tails docker logs
docker-logs:
	sudo docker logs -f $(PROJECT)

## stops container running in background
docker-stop:
	sudo docker stop $(PROJECT)

## pushes to docker hub
docker-push:
	sudo docker push $(OPV)
