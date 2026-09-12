# 🛡️ SentinelArg - Advanced Offensive Security Platform

<div align="center">

[![GitHub Sponsors](https://img.shields.io/github/sponsors/alfasierra?label=Sponsors&logo=githubsponsors&style=for-the-badge)](https://github.com/sponsors/alfasierra)
[![Docker Pulls](https://img.shields.io/docker/pulls/alfasierra07/sentinelarg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/alfasierra07/sentinelarg)
[![GitHub Stars](https://img.shields.io/github/stars/alfasierra/sentinelarg?style=for-the-badge&logo=github)](https://github.com/alfasierra/sentinelarg)
[![License](https://img.shields.io/github/license/alfasierra/sentinelarg?style=for-the-badge)](LICENSE)

**¿Te gusta SentinelArg? [Apoya el proyecto](https://github.com/sponsors/alfasierra) ☕**

</div>

---

## 📋 Descripción

**SentinelArg** es una plataforma avanzada de seguridad ofensiva impulsada por IA, diseñada para pruebas de penetración autorizadas, operaciones de red team, competiciones CTF e investigación de seguridad.

Integra **150+ herramientas de seguridad** en una plataforma unificada con automatización inteligente, generación de reportes profesionales y capacidades de inteligencia de vulnerabilidades.

🌐 **Website**: [https://sentinelarg.com.ar/](https://sentinelarg.com.ar/)

---

## ⚖️ Aviso Legal

**Esta herramienta está destinada ÚNICAMENTE para pruebas de seguridad AUTORIZADAS.**

- ✅ Pruebas de penetración autorizadas
- ✅ Investigación de seguridad ética
- ✅ Competiciones CTF (Capture The Flag)
- ✅ Auditorías de seguridad con autorización explícita por escrito

**El uso no autorizado es ILEGAL y puede resultar en enjuiciamiento civil y penal.**

Ver [LICENSE](LICENSE) para términos completos.

---

## 🌟 Características Principales

### 🌐 Escaneo de Aplicaciones Web
- **Detección de Tecnologías**: WhatWeb, Wafw00f
- **Descubrimiento de Contenido**: Katana, Gau, FFUF, Dirsearch
- **Escaneo de Vulnerabilidades**: Nuclei, Dalfox, Nikto
- **Análisis SSL/TLS**: testssl.sh
- **Detección de Secretos**: Gitleaks

### 🪟 Windows & Active Directory
- **Enumeración de Red**: Nmap, NetExec, Nbtscan
- **Evaluación AD**: BloodHound, Certipy
- **Harvesting de Credenciales**: Responder (LLMNR/NBT-NS)
- **Enumeración de Shares**: SMBMap, Enum4linux

### 🐧 Auditoría de Servidores Linux
- **Detección de Servicios**: Nmap, SSH-Audit
- **Evaluación de Vulnerabilidades**: Nuclei
- **Análisis de Configuración**: WhatWeb

### 🔌 Descubrimiento de Red
- **Escaneo de Puertos**: Nmap, Rustscan, Masscan
- **Detección de SO**: Fingerprinting avanzado
- **Enumeración de Servicios**: Nbtscan, ARP-Scan

### 🧠 Inteligencia Impulsada por IA
- **Búsqueda Automática de Exploits**: Searchsploit, Exploit-DB API, Metasploit
- **Selección Inteligente de Herramientas**: Optimización contextual de parámetros
- **Recuperación Inteligente de Errores**: Estrategias automáticas de fallback

### 📊 Reportes Profesionales
- **Reportes PDF Ejecutivos**: Formato limpio y profesional
- **Mapeo de Compliance**: OWASP Top 10, MITRE ATT&CK, CWE, PCI-DSS
- **Clasificación de Severidad**: Crítico, Alto, Medio, Bajo, Info
- **Base de Datos de Exploits**: Referencias integradas de vulnerabilidades

---

##  Instalación

### Opción 1: Docker (Recomendado)

```bash
# Pull de la imagen desde Docker Hub
docker pull alfasierra07/sentinelarg:latest

# Ejecutar el contenedor
docker run -d \
  --name sentinelarg \
  -p 8888:8888 \
  --restart unless-stopped \
  alfasierra07/sentinelarg:latest

# Acceder al dashboard
# Abre tu navegador en: http://localhost:8888
```

### Opción 2: Build desde Source

```bash
# Clonar el repositorio
git clone https://github.com/alfasierra/sentinelarg.git
cd sentinelarg

# Build de la imagen Docker
docker build -t sentinelarg .

# Ejecutar el contenedor
docker run -d -p 8888:8888 --name sentinelarg sentinelarg
```

---

## 🚀 Quick Start

1. **Acceder a la interfaz web**: `http://localhost:8888`

2. **Ingresar tu target**: Dirección IP, dominio o URL

3. **Seleccionar tipo de escaneo**:
   - **Quick**: Reconocimiento rápido (Nmap + escaneos básicos)
   - **Full**: Evaluación de seguridad comprehensiva
   - **Web**: Escaneo enfocado en aplicaciones web
   - **Windows**: Escaneo Windows/Active Directory
   - **Linux**: Auditoría de servidor Linux
   - **Network**: Descubrimiento de red
   - **OSINT**: Recolección de inteligencia de fuentes abiertas

4. **Click en "Start Scan"** y monitorea el progreso en tiempo real

5. **Descargar reporte PDF** cuando complete

---

## 📋 Requisitos

### Requisitos del Sistema
- **RAM**: 4GB mínimo (8GB recomendado)
- **Disco**: 10GB espacio libre
- **OS**: Linux (Kali Linux recomendado), macOS, Windows (WSL2)

### Requisitos Docker
- Docker Engine 20.10+
- Docker Compose 2.0+ (opcional)

---

## 🔧 Configuración

Edita `sentinelarg_config.json` para personalizar:

```json
{
  "company_name": "Tu Empresa",
  "report_title": "Reporte de Evaluación de Seguridad",
  "primary_color": "#8B0000",
  "footer_text": "Confidencial - SentinelArg Red AI"
}
```

---

## 📚 Documentación

- **Documentación Completa**: [Wiki](https://github.com/alfasierra/sentinelarg/wiki)
- **Referencia de API**: [API Docs](https://github.com/alfasierra/sentinelarg/wiki/API)
- **Solución de Problemas**: [FAQ](https://github.com/alfasierra/sentinelarg/wiki/FAQ)

---

## 💖 Sponsors

SentinelArg es un proyecto de código abierto mantenido con ❤️. 
Si te resulta útil para tu trabajo de seguridad, considera apoyarlo:

[![Sponsor](https://img.shields.io/badge/Sponsor-SentinelArg-ea4aaa?style=for-the-badge&logo=githubsponsors)](https://github.com/sponsors/alfasierra)

### ¿Por qué sponsorizar?

- ✅ **100% del dinero** va directamente al desarrollo
- ✅ **Transparencia total**: reportes mensuales de uso de fondos
- ✅ **Comunidad activa**: acceso a Discord privado
- ✅ **Influencia real**: votas en el roadmap del proyecto

[Ver todos los tiers de sponsors →](https://github.com/sponsors/alfasierra)

---

## 🤝 Contribuyendo

¡Las contribuciones son bienvenidas! Por favor lee nuestras [Guías de Contribución](CONTRIBUTING.md) primero.

1. Haz fork del repositorio
2. Crea tu feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la branch (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 🔧 Herramientas Integradas

SentinelArg integra más de **150 herramientas de seguridad**:

### Reconocimiento
- Nmap, Masscan, Rustscan, Autorecon
- Amass, Subfinder, theHarvester
- DNSrecon, Fierce, DNSenum

### Escaneo Web
- Nikto, Nuclei, Dalfox, Wpscan
- Gobuster, Dirsearch, Feroxbuster, FFUF
- WhatWeb, Wafw00f, testssl.sh

### Explotación
- Metasploit, SQLMap, Hydra
- John, Hashcat, Medusa
- Searchsploit, Exploit-DB

### Active Directory
- BloodHound, Certipy, Impacket
- Enum4linux, SMBMap, NetExec
- Responder, Nbtscan

### Forensics
- Binwalk, Foremost, Volatility
- Exiftool, Steghide, Zsteg
- Strings, XXD, File

### Cloud Security
- Prowler, Scout-Suite, Trivy
- Kube-hunter, Kube-bench
- Checkov, Terrascan

... y muchas más.

---

## 📞 Soporte

- **Website**: [https://sentinelarg.com.ar/](https://sentinelarg.com.ar/)
- **GitHub Issues**: [Reportar un bug](https://github.com/alfasierra/sentinelarg/issues)
- **Email**: support@sentinelarg.com.ar

---

##  Licencia

Este proyecto está licenciado bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

---

##  Agradecimientos

- Todas las increíbles herramientas de seguridad open-source integradas en SentinelArg
- La comunidad de seguridad ofensiva
- Bug bounty hunters e investigadores de seguridad de todo el mundo

---

<div align="center">

**Hecho con ❤️ por el Equipo SentinelArg**

⭐ ¡Dale estrella a este repo si lo encuentras útil!

</div>
```




