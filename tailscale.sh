#!/bin/bash

# Start the Tailscale daemon and log output
tailscaled > /var/log/tailscaled.log 2>&1 &

# Wait for the daemon to initialize
sleep 2

# Check the Tailscale status
status=$(tailscale status 2>&1)

if [[ $status == *"Logged out"* ]]; then
    echo "Tailscale is running. Please log in."
else
    echo "Tailscale status:"
    echo "$status"
fi

pip install google-auth google-api-python-client --break-system-packages

# Keep the container running
exec sleep infinity