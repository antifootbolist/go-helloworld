# Use the official Go image as the base image
FROM golang:alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the Go application source code to the container
COPY app/main.go .

# Compile the Go application
RUN go build -o app-hw main.go

# Set the command to run the Go application
CMD ["./app-hw"]
