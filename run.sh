#!/bin/bash

# Activate the virtual environment
source venv/bin/activate || true

# Function to start the server
start_server() {
    echo "Starting XTTS API server..."
    python3 -m xtts_api_server --listen -p 8020 -t  'http://192.168.10.112:8020' -sf 'speakers' -o 'output' -mf 'xtts_models' --deepspeed
}

# Main loop
while true; do
    # Try to start the server
    start_server
    
    # If server crashes or exits
    echo "Server stopped or crashed. Waiting 10 seconds before restart..."
    sleep 10
    
    # Log the restart attempt
    echo "Attempting to restart server..."
done

# Deactivate the virtual environment
deactivate || true