
docker_build:
	docker build -f Dockerfile.texlive-pandoc -t josdotso/docker-pp:texlive-pandoc .
	docker build -f Dockerfile.pp -t josdotso/docker-pp:pp .

docker_push:
	docker push josdotso/docker-pp:texlive-pandoc
	docker push josdotso/docker-pp:pp
