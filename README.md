# Hello World!
Hello World application written on Go

## Files   
The following files are in this repo:   
```app/main.go``` - Hello World app written on Go   
```Dockerfile``` - Application dockerization instructions   
```Jenkinsfile``` - Simple pipeline to implement CI/CD on Jenkins   

## How to launch this app   

### From VM
1. Pull source code from repository:   
```git pull https://github.com/antifootbolist/go-helloworld.git```
2. Run the application:   
```go run filename.go```
4. Check a status of the application:  
```curl -X GET http://localhost:8080```

### Inside Docker container
1. Pull source code from repository:   
```git pull https://github.com/antifootbolist/go-helloworld.git```
2. Execute docker image build by using Dockerfile from repo:   
```docker build -t go-hw-app .```
3. Run docker container:  
```docker run -d --name go-hw-app -p 8080:8080```
4. Check a status of the application:  
```curl -X GET http://localhost:8080```
