#!/bin/bash

# SentinelArg Installation Script
# For Linux systems (Kali/Ubuntu/Debian)

echo "️  SentinelArg Installation Script"
echo "====================================="

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "❌ Please run as root (sudo ./install.sh)"
    exit 1
fi

# Update system
echo " Updating system packages..."
apt-get update -y

# Install basic dependencies
echo " Installing dependencies..."
apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    nmap \
    nuclei \
    responder \
    netexec \
    enum4linux \
    smbmap \
    nbtscan \
    golang-go \
    curl \
    wget

# Install Python dependencies
echo "🐍 Installing Python dependencies..."
pip3 install flask reportlab requests psutil

# Install Go tools
echo "🔧 Installing Go tools..."
go install github.com/projectdiscovery/katana/cmd/katana@latest
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/hahwul/dalfox/v2@latest

# Add Go bin to PATH
echo 'export PATH=$PATH:/root/go/bin' >> ~/.bashrc

# Make binary executable
if [ -f "sentinelarg_server" ]; then
    chmod +x sentinelarg_server
    echo "✅ Binary made executable"
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "To start SentinelArg:"
echo "  ./sentinelarg_server"
echo ""
echo "Then open: http://localhost:8888"
echo ""
