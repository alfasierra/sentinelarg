# ==========================================
# Dockerfile para GitHub Actions + Docker Hub
# ==========================================
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

# PASO 1: Herramientas base esenciales (SIEMPRE existen)
RUN apt-get update && apt-get install -y \
    curl wget git python3 python3-pip golang-go \
    nmap masscan rustscan \
    enum4linux smbmap nbtscan \
    dnsutils whois \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

# PASO 2: Herramientas web (verificadas)
RUN apt-get update && apt-get install -y \
    nuclei nikto whatweb wafw00f testssl.sh gitleaks \
    gobuster dirsearch feroxbuster \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

# PASO 3: Herramientas Go (instalación manual)
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

# PASO 4: Explotación y passwords
RUN apt-get update && apt-get install -y \
    metasploit-framework exploitdb sqlmap hydra medusa john hashcat \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

# PASO 5: Active Directory (CORREGIDO)
RUN apt-get update && apt-get install -y \
    bloodhound responder impacket-scripts \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

# Instalar bloodhound-python y certipy via pip
RUN pip3 install --break-system-packages \
    bloodhound-python certipy krbrelayx \
    || echo "Some AD tools installation failed but continuing..."

# PASO 6: Linux/SSH
RUN apt-get update && apt-get install -y \
    ssh-audit sshpass \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

# PASO 7: Binarios/Forensics
RUN apt-get update && apt-get install -y \
    gdb radare2 binwalk foremost volatility3 exiftool steghide zsteg outguess \
    checksec pwntools ropper ropgadget \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

# PASO 8: Cloud/Containers
RUN apt-get update && apt-get install -y \
    trivy docker.io kubectl \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

# PASO 9: Cloud Security (Python)
RUN pip3 install --break-system-packages \
    prowler scout-suite checkov terrascan kube-hunter kube-bench \
    && rm -rf /root/.cache/pip

# PASO 10: OSINT
RUN apt-get update && apt-get install -y \
    theharvester maltego spiderfoot \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

RUN pip3 install --break-system-packages \
    sherlock-project social-analyzer dnsrecon fierce \
    && rm -rf /root/.cache/pip

# PASO 11: Wireless
RUN apt-get update && apt-get install -y \
    aircrack-ng kismet wireshark tshark tcpdump \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

# PASO 12: CMS Security
RUN apt-get update && apt-get install -y \
    wpscan joomscan droopescan cmsmap \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

# PASO 13: Python dependencies adicionales
RUN pip3 install --break-system-packages \
    flask requests beautifulsoup4 selenium \
    mitmproxy psutil colorama \
    reportlab pillow \
    aiohttp urllib3 \
    netexec \
    && rm -rf /root/.cache/pip

# PASO 14: Herramientas adicionales CON FALLBACK
# Arjun, ParamSpider, Amass, DNSenum (pueden fallar pero continuamos)
RUN apt-get update && \
    (apt-get install -y arjun amass dnsenum || echo "Some tools failed but continuing...") && \
    rm -rf /var/lib/apt/lists/* && apt-get clean

# ParamSpider via pip
RUN pip3 install --break-system-packages paramspider || echo "paramspider failed"

# PASO 15: SNMP y herramientas de red (CORREGIDO)
RUN apt-get update && apt-get install -y \
    snmp snmpd libsnmp-dev \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

# PASO 16: RPC client (parte de samba)
RUN apt-get update && apt-get install -y \
    samba smbclient \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

# PASO 17: WFUZZ (python3-wfuzz)
RUN apt-get update && apt-get install -y \
    python3-wfuzz \
    || pip3 install --break-system-packages wfuzz || echo "wfuzz failed"

# PASO 18: AutoRecon (instalación manual si no está en repos)
RUN apt-get update && apt-get install -y \
    autorecon || \
    (pip3 install --break-system-packages autorecon || echo "autorecon not available")

# PASO 19: Otras herramientas útiles
RUN apt-get update && apt-get install -y \
    xxd binutils \
    && rm -rf /var/lib/apt/lists/* && apt-get clean

# Herramientas especiales con fallback
RUN (git clone https://github.com/wireghoul/dotdotpwn.git /opt/dotdotpwn 2>/dev/null && \
     pip3 install --break-system-packages -r /opt/dotdotpwn/requirements.txt 2>/dev/null) || \
    echo "dotdotpwn installation failed"

RUN apt-get install -y xsser || \
    pip3 install --break-system-packages xsser || \
    echo "xsser installation failed"

RUN pip3 install --break-system-packages uro || echo "uro installation failed"

# jaeles
RUN (curl -sL https://raw.githubusercontent.com/jaeles-project/jaeles/master/scripts/install.sh | bash 2>/dev/null) || \
    (wget -qO- https://raw.githubusercontent.com/jaeles-project/jaeles/master/scripts/install.sh | bash 2>/dev/null) || \
    echo "jaeles installation failed"

# ==========================================
# DESCARGAR BINARIO PRE-COMPILADO
# ==========================================
WORKDIR /app

RUN wget -q --show-progress -O /app/sentinelarg_server.bin \
    "https://github.com/alfasierra/sentinelarg/releases/download/v1.0.0/sentinelarg_server.bin" && \
    chmod +x /app/sentinelarg_server.bin || \
    echo "⚠️ Binary download failed - will use local build"

COPY sentinelarg_config.json.example /app/sentinelarg_config.json

RUN mkdir -p /app/logs /app/reports /tmp/SentinelArg_files && \
    chmod 777 /app /app/logs /app/reports /tmp/SentinelArg_files

EXPOSE 8888

CMD ["/app/sentinelarg_server.bin"]