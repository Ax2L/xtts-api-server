#!/bin/bash

echo "=== XTTS API Server Installation Script ==="
echo "Note: Make sure to run connect_nas.sh with sudo BEFORE running this script"
echo "to mount the speaker voices from your NAS."
echo ""

# Check for Python 3.10
if ! command -v python3.10 &> /dev/null; then
    echo "Installing Python 3.10..."
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt-get update
    sudo apt-get install -y python3.10 python3.10-venv python3.10-dev
fi

# Create required directories (speakers will be mounted from NAS)
echo "Creating required directories..."
mkdir -p output xtts_models

# Remove old venv if it exists with Python 3.9
if [ -d "venv" ]; then
    echo "Removing old Python 3.9 virtual environment..."
    rm -rf venv
fi

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment with Python 3.10..."
    python3.10 -m venv venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Upgrade pip first
echo "Upgrading pip..."
pip install --upgrade pip

# Install xtts-api-server
echo "Installing xtts-api-server..."
pip install xtts-api-server

# Install PyTorch with CUDA support (updated for Python 3.10)
echo "Installing PyTorch..."
pip install torch==2.1.1+cu118 torchaudio==2.1.1+cu118 --index-url https://download.pytorch.org/whl/cu118

# Install remaining requirements
echo "Installing remaining requirements..."
pip install -r requirements.txt

# Install TTS
pip install git+https://github.com/coqui-ai/TTS  # from Github

# Install DeepSpeed
echo "Installing DeepSpeed..."
pip install deepspeed

# Make run.sh executable
chmod +x run.sh

echo ""
echo "=== Installation Complete ==="
echo "Next steps:"
echo "1. Run 'sudo ./connect_nas.sh' to mount speaker voices from NAS"
echo "2. Install and enable the systemd service:"
echo "   sudo cp xtts-api.service /etc/systemd/system/"
echo "   sudo systemctl daemon-reload"
echo "   sudo systemctl enable xtts-api"
echo "   sudo systemctl start xtts-api"
echo "3. Check service status: sudo systemctl status xtts-api"
echo "4. Server will be available at http://localhost:8020"

