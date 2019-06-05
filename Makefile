
docker_build:
	docker build -f Dockerfile.texlive-pandoc -t josdotso/pp:texlive-pandoc .
	docker build -f Dockerfile.pp -t josdotso/pp:pp .
	docker tag josdotso/pp:pp josdotso/pp:latest

docker_push:
	docker push josdotso/pp:texlive-pandoc
	docker push josdotso/pp:pp
	docker push josdotso/pp:latest
