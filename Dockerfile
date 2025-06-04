# Base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy the application files
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir langchain flask mysql-connector-python matplotlib pandas

# Expose Flask default port
EXPOSE 5000

# Run the app
CMD ["python", "your_script_name.py"]