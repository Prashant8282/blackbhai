# Use an official Python 3.10 slim image as the base
FROM python:3.10-slim

# Update apt and install ffmpeg and git, then clean up cache
RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg git && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory in the container to /app
WORKDIR /app

# Copy only the requirements file first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project into the container
COPY . .

# (Optional) Expose the port your API listens on
EXPOSE 8080

# Run both bot.py and bot2.py
CMD ["bash", "-c", "python bot.py & python bot2.py & wait"]

