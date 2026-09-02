# ==========================================
# Dockerfile para GitHub Actions + Docker Hub
# ==========================================
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

# 1. Base y herramientas esenciales de Kali
RUN apt-get update && apt-get install -y \
    curl wget git python3 python3-pip golang-go \
    nmap masscan rustscan \
    enum4linux enum4linux-ng \
    smbmap nbtscan rpcclient snmp dnsutils whois \
    nuclei nikto whatweb wafw00f testssl.sh gitleaks \
    gobuster dirsearch feroxbuster \
    arjun paramspider \
    amass dnsenum \
    wfuzz autorecon arp-scan \
    xxd binutils \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# 2. Herramientas Go
RUN go install github.com/projectdiscovery/katana/cmd/katana@latest && \
    go install github.com/lc/gau/v2/cmd/gau@latest && \
    go install github.com/hahwul/dalfox/v2@latest && \
    go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest && \
    go install github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install github.com/tomnomnom/waybackurls@latest && \
    go install github.com/ffuf/ffuf@latest && \
    go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest && \
    go install github.com/tomnomnom/anew@latest && \
    go install github.com/tomnomnom/qsreplace@latest && \
    go install github.com/r00t-3xp10it/hakrawler@latest && \
    go install github.com/lc/x8@latest && \
    mv /root/go/bin/* /usr/local/bin/ && \
    rm -rf /root/go/pkg

# 3. Herramientas de explotación
RUN apt-get update && apt-get install -y \
    metasploit-framework exploitdb sqlmap hydra medusa john hashcat \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# 4. Active Directory
RUN apt-get update && apt-get install -y \
    bloodhound bloodhound-python certipy-ad responder impacket-scripts krbrelayx \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# 5. Linux/SSH
RUN apt-get update && apt-get install -y \
    ssh-audit sshpass \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# 6. Binarios/Forensics
RUN apt-get update && apt-get install -y \
    gdb radare2 binwalk foremost volatility3 exiftool steghide zsteg outguess \
    checksec pwntools ropper ropgadget \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# 7. Cloud/Containers
RUN apt-get update && apt-get install -y \
    trivy docker.io kubectl \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# 8. Cloud Security (Python)
RUN pip3 install --break-system-packages \
    prowler scout-suite checkov terrascan kube-hunter kube-bench \
    && rm -rf /root/.cache/pip

# 9. OSINT
RUN apt-get update && apt-get install -y \
    theharvester maltego spiderfoot \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN pip3 install --break-system-packages \
    sherlock-project social-analyzer dnsrecon fierce \
    && rm -rf /root/.cache/pip

# 10. Wireless
RUN apt-get update && apt-get install -y \
    aircrack-ng kismet wireshark tshark tcpdump \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# 11. CMS Security
RUN apt-get update && apt-get install -y \
    wpscan joomscan droopescan cmsmap \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# 12. Python dependencies adicionales
RUN pip3 install --break-system-packages \
    flask requests beautifulsoup4 selenium \
    mitmproxy psutil colorama \
    reportlab pillow \
    aiohttp urllib3 \
    netexec \
    && rm -rf /root/.cache/pip

# Herramientas que requieren instalación especial
RUN git clone https://github.com/wireghoul/dotdotpwn.git /opt/dotdotpwn && \
    cd /opt/dotdotpwn && \
    pip3 install --break-system-packages -r requirements.txt || true

RUN apt-get update && apt-get install -y xsser || \
    pip3 install --break-system-packages xsser || true

RUN pip3 install --break-system-packages uro || true

RUN curl -sL https://raw.githubusercontent.com/jaeles-project/jaeles/master/scripts/install.sh | bash || true

# ==========================================
# DESCARGAR BINARIO PRE-COMPILADO
# ==========================================
WORKDIR /app

RUN wget -q --show-progress -O /app/sentinelarg_server.bin "https://github.com/alfasierra/sentinelarg/releases/download/v1.0.0/sentinelarg_server.bin" && \
    chmod +x /app/sentinelarg_server.bin

COPY sentinelarg_config.json.example /app/sentinelarg_config.json

RUN mkdir -p /app/logs /app/reports /tmp/SentinelArg_files && \
    chmod 777 /app /app/logs /app/reports /tmp/SentinelArg_files

EXPOSE 8888

CMD ["/app/sentinelarg_server.bin"]