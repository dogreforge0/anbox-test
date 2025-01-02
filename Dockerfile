# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set environment variables to prevent interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    lxc \
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
    && rm -rf /var/lib/apt/lists/*

# Install Anbox dependencies
RUN curl -sSL https://github.com/anbox/anbox/releases/download/v0.1/anbox-ubuntu-20.04-2021-09-22.tar.xz | tar -xJ -C / && \
    apt-get update && apt-get install -y \
    anbox-modules-dkms \
    libglu1-mesa \
    libegl1-mesa \
    libwayland-client0 \
    libwayland-egl1 \
    libvulkan1 \
    && rm -rf /var/lib/apt/lists/*

# Enable Anbox modules
RUN modprobe ashmem_linux && modprobe binder_linux

# Add Anbox to start at boot
RUN echo "anbox session-manager" > /etc/rc.local && chmod +x /etc/rc.local

# Expose necessary ports for Anbox
EXPOSE 5900 6080

# Start the Anbox session manager (This is important to launch Anbox when the container starts)
CMD ["anbox", "session-manager"]
