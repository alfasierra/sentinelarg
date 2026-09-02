# ==========================================
# SentinelArg - Dockerfile Realista
# Basado en Kali Linux oficial
# ==========================================
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

# ==========================================
# PASO 1: Actualizar sistema base
# ==========================================
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    curl wget git python3 python3-pip golang-go \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# ==========================================
# PASO 2: Instalar herramientas Go (las que NO vienen en Kali)
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
# PASO 3: Instalar herramientas Python adicionales
# ==========================================
RUN pip3 install --break-system-packages \
    flask requests beautifulsoup4 selenium \
    mitmproxy psutil colorama \
    reportlab pillow \
    aiohttp urllib3 \
    netexec \
    pwntools ropper ropgadget \
    || echo "Some Python packages failed but continuing..."

# ==========================================
# PASO 4: Instalar herramientas que faltan (con fallback)
# ==========================================
RUN apt-get update && apt-get install -y \
    gobuster dirsearch feroxbuster \
    arjun paramspider \
    amass dnsenum \
    wfuzz autorecon arp-scan \
    xxd binutils \
    || echo "Some tools failed but continuing..."

RUN apt-get install -y \
    libimage-exiftool-perl steghide zsteg outguess \
    || echo "Forensics tools failed but continuing..."

# ==========================================
# PASO 5: Configurar directorios y permisos
# ==========================================
WORKDIR /app

RUN mkdir -p /app/logs /app/reports /tmp/SentinelArg_files && \
    chmod 777 /app /app/logs /app/reports /tmp/SentinelArg_files

# ==========================================
# PASO 6: Descargar binario pre-compilado
# ==========================================
RUN wget -q --show-progress -O /app/sentinelarg_server.bin \
    "https://github.com/alfasierra/sentinelarg/releases/download/v1.0.0/sentinelarg_server.bin" && \
    chmod +x /app/sentinelarg_server.bin || \
    echo "⚠️ Binary download failed - check GitHub Release URL"

COPY sentinelarg_config.json.example /app/sentinelarg_config.json

EXPOSE 8888

CMD ["/app/sentinelarg_server.bin"]