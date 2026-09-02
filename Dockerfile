# ==========================================
# Dockerfile para GitHub Actions + Docker Hub
# ==========================================
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

# 1. Base y herramientas de reconocimiento/red (Agregadas: gobuster, dirsearch, feroxbuster, arjun, paramspider, x8, jaeles, hakrawler, anew, qsreplace, uro, amass, dnsenum, dotdotpwn, xsser, wfuzz, autorecon, arp-scan, xxd, binutils)
RUN apt-get update && apt-get install -y \
    curl wget git python3 python3-pip golang-go \
    nmap masscan rustscan netexec enum4linux enum4linux-ng \
    smbmap nbtscan rpcclient snmp dnsutils whois \
    nuclei nikto whatweb wafw00f testssl.sh gitleaks \
    gobuster dirsearch feroxbuster arjun paramspider x8 \
    jaeles hakrawler anew qsreplace uro amass dnsenum \
    dotdotpwn xsser wfuzz autorecon arp-scan \
    xxd binutils \
    && rm -rf /var/lib/apt/lists/*

# 2. Herramientas Go (ProjectDiscovery y otras)
RUN go install github.com/projectdiscovery/katana/cmd/katana@latest && \
    go install github.com/lc/gau/v2/cmd/gau@latest && \
    go install github.com/hahwul/dalfox/v2@latest && \
    go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest && \
    go install github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install github.com/tomnomnom/waybackurls@latest && \
    go install github.com/ffuf/ffuf@latest && \
    go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    mv /root/go/bin/* /usr/local/bin/

# 3. Explotación y contraseñas (Agregado: hashpump)
RUN apt-get update && apt-get install -y \
    metasploit-framework exploitdb sqlmap hydra medusa john hashcat \
    hashpump \
    && rm -rf /var/lib/apt/lists/*

# 4. Active Directory y Windows
RUN apt-get update && apt-get install -y \
    bloodhound bloodhound-python certipy-ad responder impacket-scripts krbrelayx \
    && rm -rf /var/lib/apt/lists/*

# 5. Análisis Binario y Forense (Agregados: pwninit, ghidra, volatility v2)
RUN apt-get update && apt-get install -y \
    gdb radare2 binwalk foremost volatility volatility3 exiftool steghide zsteg outguess \
    checksec pwntools ropper ropgadget one-gadget pwninit ghidra \
    && rm -rf /var/lib/apt/lists/*

# 6. Cloud y Contenedores
RUN apt-get update && apt-get install -y \
    trivy docker.io kubectl \
    && rm -rf /var/lib/apt/lists/*

# 7. OSINT y Wireless
RUN apt-get update && apt-get install -y \
    theharvester maltego spiderfoot \
    aircrack-ng kismet wireshark tshark tcpdump \
    && rm -rf /var/lib/apt/lists/*

# 8. Proxies Web y CMS
RUN apt-get update && apt-get install -y \
    burpsuite owasp-zap wpscan joomscan droopescan cmsmap \
    && rm -rf /var/lib/apt/lists/*

# 9. Dependencias de Python (Agregado: angr)
RUN pip3 install --break-system-packages \
    prowler scout-suite checkov terrascan kube-hunter kube-bench \
    sherlock-project social-analyzer dnsrecon fierce \
    angr \
    && rm -rf /root/.cache/pip

# 10. Dependencias para Selenium (CRÍTICO: tu código usa Chrome)
RUN apt-get update && apt-get install -y \
    chromium chromium-driver \
    && rm -rf /var/lib/apt/lists/*

# 11. Herramientas adicionales de Git (libc-database y gdb-peda)
RUN git clone https://github.com/niklasb/libc-database.git /opt/libc-database && \
    git clone https://github.com/longld/peda.git /root/peda

# ==========================================
# CONFIGURACIÓN FINAL Y BINARIO
# ==========================================
WORKDIR /app


RUN wget -q --show-progress -O /app/sentinelarg_server.bin "https://github.com/alfasierra/sentinelarg/releases/download/v1.0.0/sentinelarg_server.bin" && \
    chmod +x /app/sentinelarg_server.bin

# Copiar archivo de configuración de ejemplo
COPY sentinelarg_config.json.example /app/sentinelarg_config.json

# Crear directorios necesarios para que el binario pueda escribir (evita errores de permisos)
RUN mkdir -p /app/logs /app/reports /tmp/SentinelArg_files && \
    chmod 777 /app /app/logs /app/reports /tmp/SentinelArg_files

EXPOSE 8888

# Ejecutar el binario compilado
CMD ["/app/sentinelarg_server.bin"]