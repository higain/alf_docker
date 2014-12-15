build:
	docker build --tag mattward/alfresco:4.2 .

run:
	docker run -d --hostname docker-host --name alfresco -p 8080:8080 mattward/alfresco:4.2
	
