#!/bin/bash


# Check for Python 3.9
if ! command -v python3.9 &> /dev/null; then
    echo "Installing Python 3.9..."
    sudo add-apt-repository -y ppa:deadsnakes/ppa
    sudo apt-get update
    sudo apt-get install -y python3.9 python3.9-venv python3.9-dev
fi

# Create required directories
echo "Creating required directories..."
mkdir -p speakers output xtts_models

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    echo "Creating virtual environment with Python 3.9..."
    python3.9 -m venv venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Install xtts-api-server
echo "Installing xtts-api-server..."
pip install xtts-api-server

# Install PyTorch with CUDA support
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

