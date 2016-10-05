#!/usr/bin/env docker

sudo docker rm -v $(sudo docker ps -a -q -f status=exited)

sudo docker rmi $(sudo docker images -f "dangling=true" -q)

sudo docker volume rm $(sudo docker volume ls -qf dangling=true)
