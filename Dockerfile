# Use official Python base image
FROM python:3.8-slim

# Set working directory
WORKDIR /app

# Install system dependencies and specific Chrome + ChromeDriver versions
RUN apt update && apt install -y \
    wget \
    unzip \
    && wget https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_147.0.7727.137-1_amd64.deb \
    && apt install ./google-chrome-stable_147.0.7727.137-1_amd64.deb -y \
    && wget https://storage.googleapis.com/chrome-for-testing-public/147.0.7727.137/linux64/chromedriver-linux64.zip \
    && unzip chromedriver-linux64.zip \
    && mv chromedriver-linux64/chromedriver /usr/bin/chromedriver \
    && chmod +x /usr/bin/chromedriver \
    && apt install python3-pip -y \
    && pip install --upgrade pip \
    && pip install selenium webdriver-manager \
    && rm -rf chromedriver-linux64.zip google-chrome-stable_147.0.7727.137-1_amd64.deb \
    && apt clean

# Create a non-root user (avoids pip root warning)
RUN useradd -m -s /bin/bash appuser && chown -R appuser:appuser /app
USER appuser

# Copy application code
COPY firsttest.py .

# Run the application
CMD ["python", "firsttest.py"]
