# ==========================================
# Dockerfile para SentinelArg - Versión Estable
# ==========================================
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

# PASO 1: Actualización base y herramientas esenciales
RUN apt-get update && apt-get install -y \
    curl wget git python3 python3-pip python3-venv golang-go \
    nmap masscan rustscan \
    enum4linux smbmap nbtscan \
    dnsutils whois \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# PASO 2: Herramientas web
RUN apt-get update && apt-get install -y \
    nuclei nikto whatweb wafw00f testssl.sh gitleaks \
    gobuster dirsearch feroxbuster \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# PASO 3: Herramientas Go
RUN mkdir -p /root/go/bin && \
    export GOPATH=/root/go && \
    export PATH=$PATH:/root/go/bin && \
    go install github.com/projectdiscovery/katana/cmd/katana@latest && \
    go install github.com/lc/gau/v2/cmd/gau@latest && \
    go install github.com/hahwul/dalfox/v2@latest && \
    go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest && \
    go install github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install github.com/tomnomnom/waybackurls@latest && \
    go install github.com/ffuf/ffuf@latest && \
    go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest && \
    cp /root/go/bin/* /usr/local/bin/ && \
    rm -rf /root/go/pkg

# PASO 4: Explotación
RUN apt-get update && apt-get install -y \
    metasploit-framework exploitdb sqlmap hydra medusa john hashcat \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# PASO 5: Active Directory
RUN apt-get update && apt-get install -y \
    bloodhound responder impacket-scripts \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# PASO 6: Linux/SSH
RUN apt-get update && apt-get install -y \
    ssh-audit sshpass \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# PASO 7: Binarios/Forensics
RUN apt-get update && apt-get install -y \
    gdb radare2 binwalk foremost volatility3 \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN apt-get update && apt-get install -y \
    libimage-exiftool-perl steghide zsteg outguess \
    || echo "Some forensics tools failed but continuing..."

# PASO 8: Cloud/Containers
RUN apt-get update && apt-get install -y \
    trivy docker.io kubectl \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# PASO 9: OSINT
RUN apt-get update && apt-get install -y \
    theharvester maltego spiderfoot \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# PASO 10: Wireless
RUN apt-get update && apt-get install -y \
    aircrack-ng kismet wireshark tshark tcpdump \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# PASO 11: CMS Security
RUN apt-get update && apt-get install -y \
    wpscan joomscan droopescan cmsmap \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# PASO 12: Crear entorno virtual para paquetes Python
RUN python3 -m venv /opt/sentinelarg-venv && \
    /opt/sentinelarg-venv/bin/pip install --upgrade pip

# Instalar paquetes Python en el entorno virtual (con fallback)
RUN /opt/sentinelarg-venv/bin/pip install \
    flask requests beautifulsoup4 selenium \
    mitmproxy psutil colorama \
    reportlab pillow \
    aiohttp urllib3 \
    netexec \
    pwntools ropper ropgadget \
    || echo "Some Python packages failed but continuing..."

# PASO 13: Herramientas adicionales con fallback
RUN apt-get update && apt-get install -y \
    arjun amass dnsenum \
    || echo "Some tools failed but continuing..."

RUN apt-get install -y \
    wfuzz autorecon arp-scan \
    || echo "wfuzz/autorecon/arp-scan failed but continuing..."

# PASO 14: Descargar checksec
RUN wget -q https://raw.githubusercontent.com/slimm609/checksec.sh/master/checksec -O /usr/local/bin/checksec && \
    chmod +x /usr/local/bin/checksec || echo "checksec download failed"

# PASO 15: Descargar binario pre-compilado
WORKDIR /app

RUN wget -q --show-progress -O /app/sentinelarg_server.bin \
    "https://github.com/alfasierra/sentinelarg/releases/download/v1.0.0/sentinelarg_server.bin" && \
    chmod +x /app/sentinelarg_server.bin || \
    echo "️ Binary download failed - will use local build"

COPY sentinelarg_config.json.example /app/sentinelarg_config.json

RUN mkdir -p /app/logs /app/reports /tmp/SentinelArg_files && \
    chmod 777 /app /app/logs /app/reports /tmp/SentinelArg_files

EXPOSE 8888

CMD ["/app/sentinelarg_server.bin"]