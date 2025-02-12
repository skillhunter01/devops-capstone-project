# Use the official Python 3.9 slim image as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application contents
COPY service/ ./service/

# Create a non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# Run gunicorn
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
