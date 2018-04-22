docker_build:
	docker build -t "charlieegan3/stackr:$$(cat Dockerfile entrypoint.sh | shasum | awk '{ print $$1 }')" \
							 -t charlieegan3/stackr:latest \
							 .

docker_push: docker_build
	docker push charlieegan3/stackr:$$(cat Dockerfile entrypoint.sh | shasum | awk '{ print $$1 }')
