# ==========================================
# ETAPA 1: COMPILACIÓN 
# ==========================================
FROM python:3.11-slim AS builder

# Instalamos dependencias de compilación de C
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    patchelf \
    upx-ucl \
    && rm -rf /var/lib/apt/lists/*

# Instalamos Nuitka y dependencias Python del servidor
RUN pip install --no-cache-dir \
    nuitka \
    flask \
    reportlab \
    requests \
    psutil


WORKDIR /build
COPY sentinelarg_server.py .
COPY dashboard.html .
COPY sentinelarg_config.json .

# COMPILAMOS con Nuitka a un binario standalone de un solo archivo
RUN python -m nuitka \
    --standalone \
    --onefile \
    --remove-output \
    --include-data-file=dashboard.html=dashboard.html \
    --include-data-file=sentinelarg_config.json=sentinelarg_config.json \
    sentinelarg_server.py

# ==========================================
# ETAPA 2: DISTRIBUCIÓN (Producto Final con Kali)
# ==========================================
FROM kalilinux/kali-rolling

# Evitar prompts interactivos durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Actualizamos sistema e instalamos dependencias base
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    python3 \
    python3-pip \
    golang-go \
    && rm -rf /var/lib/apt/lists/*

# ==========================================
# 1. HERRAMIENTAS DE RECONOCIMIENTO Y RED
# ==========================================
RUN apt-get update && apt-get install -y \
    nmap \
    masscan \
    rustscan \
    netexec \
    enum4linux \
    enum4linux-ng \
    smbmap \
    nbtscan \
    rpcclient \
    snmp \
    dnsutils \
    whois \
    && rm -rf /var/lib/apt/lists/*

# ==========================================
# 2. HERRAMIENTAS WEB
# ==========================================
RUN apt-get update && apt-get install -y \
    nuclei \
    nikto \
    whatweb \
    wafw00f \
    testssl.sh \
    gitleaks \
    && rm -rf /var/lib/apt/lists/*

# Instalamos herramientas de Go (ProjectDiscovery y otras)
RUN go install github.com/projectdiscovery/katana/cmd/katana@latest && \
    go install github.com/lc/gau/v2/cmd/gau@latest && \
    go install github.com/hahwul/dalfox/v2@latest && \
    go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest && \
    go install github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install github.com/tomnomnom/waybackurls@latest && \
    go install github.com/ffuf/ffuf@latest && \
    go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    mv /root/go/bin/* /usr/local/bin/

# ==========================================
# 3. HERRAMIENTAS DE EXPLOTACIÓN
# ==========================================
RUN apt-get update && apt-get install -y \
    metasploit-framework \
    exploitdb \
    sqlmap \
    hydra \
    medusa \
    john \
    hashcat \
    && rm -rf /var/lib/apt/lists/*

# ==========================================
# 4. HERRAMIENTAS ACTIVE DIRECTORY
# ==========================================
RUN apt-get update && apt-get install -y \
    bloodhound \
    bloodhound-python \
    certipy-ad \
    responder \
    impacket-scripts \
    krbrelayx \
    && rm -rf /var/lib/apt/lists/*

# ==========================================
# 5. HERRAMIENTAS LINUX / SSH
# ==========================================
RUN apt-get update && apt-get install -y \
    ssh-audit \
    sshpass \
    && rm -rf /var/lib/apt/lists/*

# ==========================================
# 6. HERRAMIENTAS FORENSES Y BINARIAS
# ==========================================
RUN apt-get update && apt-get install -y \
    gdb \
    radare2 \
    binwalk \
    foremost \
    volatility3 \
    exiftool \
    steghide \
    zsteg \
    outguess \
    checksec \
    pwntools \
    ropper \
    ropgadget \
    one-gadget \
    && rm -rf /var/lib/apt/lists/*

# ==========================================
# 7. HERRAMIENTAS CLOUD Y CONTAINERS
# ==========================================
RUN apt-get update && apt-get install -y \
    trivy \
    docker.io \
    kubectl \
    && rm -rf /var/lib/apt/lists/*

# Instalamos herramientas cloud con pip
RUN pip3 install --break-system-packages \
    prowler \
    scout-suite \
    checkov \
    terrascan \
    kube-hunter \
    kube-bench \
    && rm -rf /root/.cache/pip

# ==========================================
# 8. HERRAMIENTAS OSINT
# ==========================================
RUN apt-get update && apt-get install -y \
    theharvester \
    maltego \
    spiderfoot \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --break-system-packages \
    sherlock-project \
    social-analyzer \
    dnsrecon \
    fierce \
    && rm -rf /root/.cache/pip

# ==========================================
# 9. HERRAMIENTAS WIRELESS Y RED
# ==========================================
RUN apt-get update && apt-get install -y \
    aircrack-ng \
    kismet \
    wireshark \
    tshark \
    tcpdump \
    && rm -rf /var/lib/apt/lists/*

# ==========================================
# 10. HERRAMIENTAS ADICIONALES WEB/CMS
# ==========================================
RUN apt-get update && apt-get install -y \
    burpsuite \
    owasp-zap \
    wpscan \
    joomscan \
    droopescan \
    cmsmap \
    && rm -rf /var/lib/apt/lists/*

# ==========================================
# DESCARGAR BINARIO PRE-COMPILADO
# ==========================================

WORKDIR /app
RUN wget -O /app/sentinelarg_server.bin "https://github.com/alfasierra/sentinelarg/releases/download/v1.0.0/sentinelarg_server.bin" && \
    chmod +x /app/sentinelarg_server.bin

# Copiar archivos de configuración
COPY dashboard.html /app/dashboard.html
COPY sentinelarg_config.json.example /app/sentinelarg_config.json

EXPOSE 8888

CMD ["/app/sentinelarg_server.bin"]
