# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set environment variables to prevent interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    unzip \
    openjdk-8-jdk \
    x11vnc \
    imagemagick \
    libgl1-mesa-glx \
    libpulse0 \
    libx11-6 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libasound2 \
    libpulse0 \
    python3 \
    python3-pip \
    python3-venv \
    fonts-liberation \
    libgbm1 \
    libgtk-3-0 \
    libxkbcommon0 \
    xdg-utils \
    snapd \
    && rm -rf /var/lib/apt/lists/*

# Enable the Snap package manager
RUN systemctl enable snapd

# Start Snapd daemon
RUN systemctl start snapd

# Install Anbox using snap
RUN snap install --classic anbox

# Expose necessary ports for Anbox
EXPOSE 5900 6080

# Start Anbox session manager
CMD ["anbox", "session-manager"]
