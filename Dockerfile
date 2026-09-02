# ==========================================
# Dockerfile para GitHub Actions + Docker Hub
# ==========================================
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl wget git python3 python3-pip golang-go \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    nmap masscan rustscan netexec enum4linux enum4linux-ng \
    smbmap nbtscan rpcclient snmp dnsutils whois \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    nuclei nikto whatweb wafw00f testssl.sh gitleaks \
    && rm -rf /var/lib/apt/lists/*

RUN go install github.com/projectdiscovery/katana/cmd/katana@latest && \
    go install github.com/lc/gau/v2/cmd/gau@latest && \
    go install github.com/hahwul/dalfox/v2@latest && \
    go install github.com/projectdiscovery/naabu/v2/cmd/naabu@latest && \
    go install github.com/projectdiscovery/httpx/cmd/httpx@latest && \
    go install github.com/tomnomnom/waybackurls@latest && \
    go install github.com/ffuf/ffuf@latest && \
    go install github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest && \
    mv /root/go/bin/* /usr/local/bin/

RUN apt-get update && apt-get install -y \
    metasploit-framework exploitdb sqlmap hydra medusa john hashcat \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    bloodhound bloodhound-python certipy-ad responder impacket-scripts krbrelayx \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    ssh-audit sshpass \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    gdb radare2 binwalk foremost volatility3 exiftool steghide zsteg outguess \
    checksec pwntools ropper ropgadget one-gadget \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    trivy docker.io kubectl \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --break-system-packages \
    prowler scout-suite checkov terrascan kube-hunter kube-bench \
    && rm -rf /root/.cache/pip

RUN apt-get update && apt-get install -y \
    theharvester maltego spiderfoot \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --break-system-packages \
    sherlock-project social-analyzer dnsrecon fierce \
    && rm -rf /root/.cache/pip

RUN apt-get update && apt-get install -y \
    aircrack-ng kismet wireshark tshark tcpdump \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y \
    burpsuite owasp-zap wpscan joomscan droopescan cmsmap \
    && rm -rf /var/lib/apt/lists/*

# ==========================================
# DESCARGAR BINARIO PRE-COMPILADO
# ==========================================
WORKDIR /app


RUN wget -O /app/sentinelarg_server.bin "https://github.com/alfasierra/sentinelarg/releases/download/v1.0.0/sentinelarg_server.bin" && \
    chmod +x /app/sentinelarg_server.bin

COPY sentinelarg_config.json.example /app/sentinelarg_config.json

EXPOSE 8888

CMD ["/app/sentinelarg_server.bin"]