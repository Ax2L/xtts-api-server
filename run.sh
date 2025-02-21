#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Activate the virtual environment
source venv/bin/activate

# Install the required packages
/usr/bin/python -m pip install -r requirements.txt

# Start the server
/usr/bin/python -m xtts_api_server --listen