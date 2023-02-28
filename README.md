# Hello World!
Hello World application written on Go and Python

## Files   
The following files are in this repo:   
```go-app/main.go``` - Hello World app written on Go  
```py-app/main.py``` - Hello World app written on Python
```nginx/nginx.conf``` - Nginx config to run Web server in front of both apps 
```*/Dockerfile``` - Dockerfile to run apps inside container   
```Jenkinsfile``` - Jenkins pipeline to deploy Nginx and apps   

## Nginx configuration
When all containers are up and running, both applications are available at the following URLs:  
```http://server:8081``` - backend of Go application   
```http://server:8082``` - backend of Python application   

All requests to Nginx (frontend) are proxied according to the following algorithm:   
```http://server/go``` - to Go application   
```http://server/python``` - to Python application   


## Example how to launch app written on Go   

### From VM
1. Pull source code from repository:   
```git pull https://github.com/antifootbolist/go-helloworld.git```
2. Run the application:   
```go run filename.go```
4. Check a status of the application:  
```curl -X GET http://localhost:8081```

### Inside Docker container
1. Pull source code from repository:   
```git pull https://github.com/antifootbolist/go-helloworld.git```
2. Execute docker image build by using Dockerfile from repo:   
```docker build -t go-hw-app .```
3. Run docker container:  
```docker run -d --name go-hw-app -p 8081:8081```
4. Check a status of the application:  
```curl -X GET http://localhost:8081```
