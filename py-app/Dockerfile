# Use the official Python image as the parent image
FROM python:latest

# Set the working directory to /app
WORKDIR /app

# Copy the application content into the container at /app
COPY py-app/* .

# Install the required packages
RUN pip install --no-cache-dir -r requirements.txt

# Start the Flask app when the container starts
CMD ["python", "main.py"]