build:
	docker build --tag deltakarlsruhe/alf_docker .

run:
	docker run -d --hostname docker-host --name alfresco -p 8080:8080 deltakarlsruhe/alf_docker
	
