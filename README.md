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
