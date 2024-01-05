Create Docker Image 
Build docker build -t integrationprod -f db/integrationprod/Dockerfile .

cretae docker container
 docker run -d --name integrationdb -p 5430:5432 integrationprod

connect to db :-
jdbc:postgresql://localhost:5430/integrationdb

[//]: # (postgres)