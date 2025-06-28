#!/bin/bash

echo "=== XTTS API Server Service Setup ==="

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root (use sudo)"
    exit 1
fi

# Copy service file to systemd directory
echo "Installing systemd service..."
cp xtts-api.service /etc/systemd/system/

# Reload systemd daemon
echo "Reloading systemd daemon..."
systemctl daemon-reload

# Enable the service to start on boot
echo "Enabling XTTS API service..."
systemctl enable xtts-api

# Start the service
echo "Starting XTTS API service..."
systemctl start xtts-api

# Wait a moment for service to start
sleep 3

# Check service status
echo ""
echo "=== Service Status ==="
systemctl status xtts-api --no-pager

echo ""
echo "=== Useful Commands ==="
echo "Check status:    sudo systemctl status xtts-api"
echo "Stop service:    sudo systemctl stop xtts-api"
echo "Start service:   sudo systemctl start xtts-api"
echo "Restart service: sudo systemctl restart xtts-api"
echo "View logs:       sudo journalctl -u xtts-api -f"
echo "Disable service: sudo systemctl disable xtts-api"
echo ""
echo "Server will be available at: http://localhost:8020" 