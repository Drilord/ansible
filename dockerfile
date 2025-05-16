# Use the latest Ubuntu image
FROM ubuntu:latest

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update the package list and install required dependencies
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt-get install -y ansible && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add Docker connection tools
RUN apt-get update && \
    apt-get install -y python3-pip python3-docker docker.io && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install curl and Tailscale
RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://tailscale.com/install.sh | sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the default command to keep the container running
CMD ["sleep", "infinity"]