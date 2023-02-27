# Use the official Go image as the base image
FROM golang:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the Go application source code to the container
COPY app/main.go .

# Compile the Go application
RUN go build -o hello-world

# Set the command to run the Go application
CMD ["./hello-world"]
