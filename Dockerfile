# ==========================================
# Dockerfile para SentinelArg - Production Ready
# ==========================================
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

# ==========================================
# PASO 1: Herramientas base esenciales
# ==========================================
RUN apt-get update && apt-get install -y \
    curl wget git python3 python3-pip golang-go \
    nmap masscan rustscan \
    enum4linux smbmap nbtscan \
    dnsutils whois \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# ==========================================
# PASO 2: Herramientas web (separadas)
# ==========================================
RUN apt-get update && apt-get install -y \
    nuclei nikto whatweb wafw00f testssl.sh gitleaks \
    gobuster dirsearch feroxbuster \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# ==========================================
# PASO 3: Herramientas Go (vía go install)
# ==========================================
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

# ==========================================
# PASO 4: Explotación y passwords
# ==========================================
RUN apt-get update && apt-get install -y \
    metasploit-framework exploitdb sqlmap hydra medusa john hashcat \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# ==========================================
# PASO 5: Active Directory
# ==========================================
RUN apt-get update && apt-get install -y \
    bloodhound bloodhound-python certipy-ad responder impacket-scripts krbrelayx \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# ==========================================
# PASO 6: Binarios y forenses
# ==========================================
RUN apt-get update && apt-get install -y \
    gdb radare2 binwalk foremost volatility3 exiftool steghide zsteg outguess \
    checksec pwntools ropper ropgadget \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# ==========================================
# PASO 7: Cloud y contenedores
# ==========================================
RUN apt-get update && apt-get install -y \
    trivy docker.io kubectl \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# ==========================================
# PASO 8: Cloud Security (Python)
# ==========================================
RUN pip3 install --break-system-packages \
    prowler scout-suite checkov terrascan kube-hunter kube-bench \
    && rm -rf /root/.cache/pip

# ==========================================
# PASO 9: OSINT
# ==========================================
RUN apt-get update && apt-get install -y \
    theharvester maltego spiderfoot \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN pip3 install --break-system-packages \
    sherlock-project social-analyzer dnsrecon fierce \
    && rm -rf /root/.cache/pip

# ==========================================
# PASO 10: Wireless
# ==========================================
RUN apt-get update && apt-get install -y \
    aircrack-ng kismet wireshark tshark tcpdump \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# ==========================================
# PASO 11: CMS Security
# ==========================================
RUN apt-get update && apt-get install -y \
    wpscan joomscan droopescan cmsmap \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# ==========================================
# PASO 12: Python dependencies adicionales
# ==========================================
RUN pip3 install --break-system-packages \
    flask requests beautifulsoup4 selenium \
    mitmproxy psutil colorama \
    reportlab pillow \
    aiohttp urllib3 \
    netexec \
    && rm -rf /root/.cache/pip

# ==========================================
# PASO 13: Herramientas adicionales con fallback
# ==========================================
RUN apt-get update && apt-get install -y \
    arjun paramspider amass dnsenum \
    || echo "Algunas herramientas fallaron pero continuamos..."

RUN apt-get install -y \
    wfuzz autorecon arp-scan \
    || echo "wfuzz/autorecon/arp-scan fallaron pero continuamos..."

RUN apt-get install -y \
    xxd binutils \
    || echo "xxd/binutils fallaron pero continuamos..."

# ==========================================
# PASO 14: Herramientas especiales
# ==========================================
RUN git clone https://github.com/wireghoul/dotdotpwn.git /opt/dotdotpwn 2>/dev/null || true
RUN pip3 install --break-system-packages -r /opt/dotdotpwn/requirements.txt 2>/dev/null || true

RUN apt-get install -y xsser || pip3 install --break-system-packages xsser || true
RUN pip3 install --break-system-packages uro || true

# ==========================================
# PASO 15: Descargar binario pre-compilado
# ==========================================
WORKDIR /app


RUN wget -q --show-progress -O /app/sentinelarg_server.bin \
    "https://github.com/alfasierra/sentinelarg/releases/download/v1.0.0/sentinelarg_server.bin" && \
    chmod +x /app/sentinelarg_server.bin || \
    echo "⚠️ WARNING: Binary download failed. You must upload the binary to GitHub Releases."

COPY sentinelarg_config.json.example /app/sentinelarg_config.json

# Crear directorios necesarios
RUN mkdir -p /app/logs /app/reports /tmp/SentinelArg_files && \
    chmod 777 /app /app/logs /app/reports /tmp/SentinelArg_files

EXPOSE 8888

CMD ["/app/sentinelarg_server.bin"]