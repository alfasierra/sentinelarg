# ️ SentinelArg - Advanced Offensive Security Platform

![SentinelArg Dashboard](screenshots/dashboard.png)

**SentinelArg** is an AI-powered offensive security automation platform designed for authorized penetration testing, red team operations, CTF competitions, and security research.

🌐 **Website**: [https://sentinelarg.com.ar/](https://sentinelarg.com.ar/)

---

## ⚖️ Legal Notice

**This tool is intended for AUTHORIZED security testing ONLY.**

- ✅ Authorized penetration testing
- ✅ Ethical security research
- ✅ CTF (Capture The Flag) competitions
- ✅ Security audits with explicit written authorization

**Unauthorized use is ILLEGAL and may result in civil and criminal prosecution.**

See [LICENSE](LICENSE) for complete terms.

---

## 🌟 Features

### 🌐 Web Application Scanning
- **Technology Detection**: WhatWeb, Wafw00f, ...
- **Content Discovery**: Katana, Gau, FFUF, Dirsearch, ...
- **Vulnerability Scanning**: Nuclei, Dalfox, Nikto, ...
- **SSL/TLS Analysis**: testssl.sh
- **Secret Detection**: Gitleaks

### 🪟 Windows & Active Directory
- **Network Enumeration**: Nmap, NetExec, Nbtscan, ...
- **AD Assessment**: BloodHound, Certipy, ...
- **Credential Harvesting**: Responder (LLMNR/NBT-NS)
- **Share Enumeration**: SMBMap, Enum4linux, ...

### 🐧 Linux Server Auditing
- **Service Detection**: Nmap, SSH-Audit
- **Vulnerability Assessment**: Nuclei
- **Configuration Analysis**: WhatWeb

### 🔌 Network Discovery
- **Port Scanning**: Nmap (comprehensive), Rustscan, Masscan, ...
- **OS Detection**: Advanced fingerprinting
- **Service Enumeration**: Nbtscan, ARP-Scan

###  AI-Powered Intelligence
- **Automatic Exploit Search**: Searchsploit, Exploit-DB API, Metasploit, ...
- **Smart Tool Selection**: Context-aware parameter optimization
- **Intelligent Error Recovery**: Automatic fallback strategies

### 📊 Professional Reporting
- **Executive PDF Reports**: Clean, professional format
- **Compliance Mapping**: OWASP Top 10, MITRE ATT&CK, CWE, PCI-DSS
- **Severity Classification**: Critical, High, Medium, Low, Info
- **Exploit Database**: Integrated vulnerability references
  
🚀 Quick Start
Access the web interface: http://localhost:8888
Enter your target: IP address, domain, or URL
Select scan type:
Quick: Fast reconnaissance (Nmap + basic scans)
Full: Comprehensive security assessment
Web: Web application focused scan
Windows: Windows/Active Directory scan
Linux: Linux server audit
Network: Network discovery
OSINT: Open-source intelligence gathering
Click "Start Scan" and monitor progress in real-time
Download PDF report when complete

📋 Requirements
System Requirements
RAM: 4GB minimum (8GB recommended)
Disk: 10GB free space
OS: Linux (Kali Linux recommended), macOS, Windows (WSL2)
Docker Requirements
Docker Engine 20.10+
Docker Compose 2.0+ (optional)

📚 Documentation
Full Documentation: Wiki
API Reference: API Docs
Troubleshooting: FAQ

🤝 Contributing
Contributions are welcome! Please read our Contributing Guidelines first.
Fork the repository
Create your feature branch (git checkout -b feature/AmazingFeature)
Commit your changes (git commit -m 'Add some AmazingFeature')
Push to the branch (git push origin feature/AmazingFeature)
Open a Pull Request
License
This project is licensed under the MIT License - see the LICENSE file for details.

🙏 Acknowledgments
All the amazing open-source security tools integrated in SentinelArg
The offensive security community
Bug bounty hunters and security researchers worldwide
📞 Support
Website: https://sentinelarg.com.ar/
GitHub Issues: Report a bug
Email: contacto@sentinelarg.com.ar


Made with ❤️ by SentinelArg Team
⭐ Star this repo if you find it useful!

---

## 📦 Installation

### Option 1: Docker (Recommended)

```bash
# Pull the latest image
docker pull alfasierra07/sentinelarg:latest

# Run the container
docker run -d \
  --name sentinelarg \
  -p 8888:8888 \
  --restart unless-stopped \
  alfasierra07/sentinelarg:latest

# Access the dashboard
open http://localhost:8888
# Or visit: http://127.0.0.1:8888

### Option 2 : Build from Source

# Clone the repository
git clone https://github.com/alfasierra/sentinelarg.git
cd sentinelarg

# Build the Docker image
docker build -t sentinelarg .

# Run the container
docker run -d -p 8888:8888 --name sentinelarg sentinelarg


