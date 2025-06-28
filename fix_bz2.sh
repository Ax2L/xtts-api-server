#!/bin/bash

echo "=== Fixing missing bz2 module issue ==="

# Install missing system dependencies
echo "Installing system dependencies..."
sudo apt-get update
sudo apt-get install -y libbz2-dev libreadline-dev libsqlite3-dev libssl-dev libffi-dev

# Remove and recreate virtual environment
echo "Recreating virtual environment..."
rm -rf venv
python3.10 -m venv venv

# Activate environment
source venv/bin/activate

# Upgrade pip
pip install --upgrade pip

# Install core packages first
echo "Installing core packages..."
pip install wheel setuptools

# Install XTTS server and dependencies
echo "Installing XTTS server..."
pip install xtts-api-server

# Install PyTorch
echo "Installing PyTorch..."
pip install torch==2.1.1+cu118 torchaudio==2.1.1+cu118 --index-url https://download.pytorch.org/whl/cu118

# Install requirements
echo "Installing requirements..."
pip install -r requirements.txt

# Install TTS (using pip instead of git to avoid conflicts)
echo "Installing TTS..."
pip install TTS

# Install DeepSpeed
echo "Installing DeepSpeed..."
pip install deepspeed

echo ""
echo "=== Fix complete! ==="
echo "Try running: ./run.sh" 