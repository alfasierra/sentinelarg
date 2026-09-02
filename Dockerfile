# ==========================================
# Dockerfile para GitHub Actions + Docker Hub
# ==========================================
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

# PASO 1: Herramientas base esenciales
RUN apt-get update && apt-get install -y \
    curl wget git python3 python3-pip golang-go \
    nmap masscan rustscan \
    enum4linux enum4linux-ng \
    smbmap nbtscan \
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
RUN go install github.com/projectdiscovery/katana/cmd/katana@latest && \
    go install github.com/lc/gau/v2/cmd/gau@latest && \
    go install github.com/hahwul/dalfox/v2@latest && \
    go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest && \
    go install github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install github.com/tomnomnom/waybackurls@latest && \
    go install github.com/ffuf/ffuf@latest && \
    go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    go install github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest && \
    mv /root/go/bin/* /usr/local/bin/ && \
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

# PASO 7: Binarios/Forensics (CORREGIDO)
RUN apt-get update && apt-get install -y \
    gdb radare2 binwalk foremost volatility \
    libimage-exiftool-perl steghide zsteg outguess \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# PASO 8: Cloud/Containers
RUN apt-get update && apt-get install -y \
    trivy docker.io kubectl \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# PASO 9: Cloud Security (Python)
RUN pip3 install --break-system-packages \
    prowler scout-suite checkov terrascan kube-hunter kube-bench \
    && rm -rf /root/.cache/pip

# PASO 10: OSINT
RUN apt-get update && apt-get install -y \
    theharvester maltego spiderfoot \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN pip3 install --break-system-packages \
    sherlock-project social-analyzer dnsrecon fierce \
    && rm -rf /root/.cache/pip

# PASO 11: Wireless
RUN apt-get update && apt-get install -y \
    aircrack-ng kismet wireshark tshark tcpdump \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# PASO 12: CMS Security
RUN apt-get update && apt-get install -y \
    wpscan joomscan droopescan cmsmap \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# PASO 13: Python dependencies adicionales
RUN pip3 install --break-system-packages \
    flask requests beautifulsoup4 selenium \
    mitmproxy psutil colorama \
    reportlab pillow \
    aiohttp urllib3 \
    netexec \
    pwntools ropper ropgadget \
    && rm -rf /root/.cache/pip

# PASO 14: Herramientas adicionales
RUN apt-get update && apt-get install -y \
    arjun paramspider amass dnsenum \
    wfuzz autorecon arp-scan \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean || echo "Some tools failed but continuing..."

# PASO 15: Descargar checksec.sh
RUN wget -q https://raw.githubusercontent.com/slimm609/checksec.sh/master/checksec -O /usr/local/bin/checksec && \
    chmod +x /usr/local/bin/checksec || echo "checksec download failed"

# PASO 16: Descargar herramientas especiales
RUN (git clone https://github.com/wireghoul/dotdotpwn.git /opt/dotdotpwn 2>/dev/null && \
     pip3 install --break-system-packages -r /opt/dotdotpwn/requirements.txt 2>/dev/null) || true

RUN apt-get install -y xsser || \
    pip3 install --break-system-packages xsser || true

RUN pip3 install --break-system-packages uro || true

# jaeles
RUN (curl -sL https://raw.githubusercontent.com/jaeles-project/jaeles/master/scripts/install.sh | bash 2>/dev/null) || true

# ==========================================
# DESCARGAR BINARIO PRE-COMPILADO
# ==========================================
WORKDIR /app

RUN wget -q --show-progress -O /app/sentinelarg_server.bin \
    "https://github.com/alfasierra/sentinelarg/releases/download/v1.0.0/sentinelarg_server.bin" && \
    chmod +x /app/sentinelarg_server.bin || \
    echo "️ Binary download failed"

COPY sentinelarg_config.json.example /app/sentinelarg_config.json

RUN mkdir -p /app/logs /app/reports /tmp/SentinelArg_files && \
    chmod 777 /app /app/logs /app/reports /tmp/SentinelArg_files

EXPOSE 8888

CMD ["/app/sentinelarg_server.bin"]