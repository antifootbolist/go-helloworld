# Use the official Python image as the parent image
FROM python:3.9-slim-buster

# Set the working directory to /app
WORKDIR /app

# Copy the application content into the container at /app
COPY ./* .

# Install the required packages
RUN pip install --no-cache-dir -r requirements.txt

# Expose port 5000 for the Flask app to listen on
EXPOSE 8080

# Start the Flask app when the container starts
CMD ["python", "main.py"]