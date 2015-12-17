build:
	docker build --tag mattward/alfresco:5.1-SNAPSHOT .

run:
	docker run -d --hostname docker-host --name alfresco -p 8080:8080 mattward/alfresco:5.1-SNAPSHOT
	
