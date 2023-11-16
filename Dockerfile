# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Install git, GCC compiler, and Python development headers
RUN apt-get update && apt-get install -y git gcc python3-dev

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV FLASK_APP app.py

# Run app.py when the container launches
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:5000", "--worker-class", "gthread", "--threads", "100", "--timeout", "1000"]
