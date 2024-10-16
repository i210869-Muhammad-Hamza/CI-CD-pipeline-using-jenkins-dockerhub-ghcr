# Use an official Python base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents to the container
COPY . /app

# Install any dependencies specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Set environment variables (optional)
ENV PYTHONUNBUFFERED=1

# Run the Python test
CMD ["python", "-m", "unittest", "test.py"]
