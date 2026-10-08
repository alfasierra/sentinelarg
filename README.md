# 🛡️ SentinelArg - Advanced Offensive Security Platform

<div align="center">

[![GitHub Sponsors](https://img.shields.io/github/sponsors/alfasierra?label=Sponsors&logo=githubsponsors&style=for-the-badge)](https://github.com/sponsors/alfasierra)
[![Docker Pulls](https://img.shields.io/docker/pulls/alfasierra07/sentinelarg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/alfasierra07/sentinelarg)
[![GitHub Stars](https://img.shields.io/github/stars/alfasierra/sentinelarg?style=for-the-badge&logo=github)](https://github.com/alfasierra/sentinelarg)
[![License](https://img.shields.io/github/license/alfasierra/sentinelarg?style=for-the-badge)](LICENSE)

**¿Te gusta SentinelArg? [Apoya el proyecto](https://github.com/sponsors/alfasierra) ☕**

</div>

<div align="center">

[![Version](https://img.shields.io/badge/version-1.0.0-blue?style=for-the-badge)](https://sentinelarg.com.ar)
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?style=for-the-badge&logo=docker)](https://www.docker.com/)
[![License](https://img.shields.io/badge/License-Proprietary_EULA-red?style=for-the-badge)](EULA.md)

**Plataforma profesional de seguridad ofensiva impulsada por Inteligencia Artificial.**

🌐 **Website**: [https://sentinelarg.com.ar/](https://sentinelarg.com.ar/)  
📧 **Soporte**: soporte@sentinelarg.com.ar

</div>

---

## ⚠️ Aviso Legal y Uso Responsable

**SentinelArg es una herramienta de evaluación de seguridad ofensiva destinada ÚNICAMENTE para uso autorizado.**

- ✅ Pruebas de penetración con autorización explícita y por escrito.
- ✅ Auditorías de seguridad y Red Team operations.
- ✅ Competiciones CTF (Capture The Flag) y entornos de laboratorio controlados.
- ✅ Investigación de seguridad ética.

**El uso no autorizado de esta herramienta es ILEGAL y puede resultar en acciones civiles y penales.**  
Al instalar y utilizar SentinelArg, usted acepta los términos establecidos en el [Acuerdo de Licencia de Usuario Final (EULA.md)](EULA.md).

---

## 🌟 Características Principales

### 🧠 Inteligencia Artificial Integrada
- **Orquestador IA**: Correlación automática de hallazgos y eliminación de falsos positivos.
- **Selección Inteligente de Herramientas**: Adapta el escaneo según los puertos y servicios detectados.
- **Asistente de Seguridad**: Chat interactivo con LLM local (Ollama) para explicar vulnerabilidades y recomendar remediación.

### 🌐 Escaneo de Aplicaciones Web
- **Detección de Tecnologías**: WhatWeb, Wafw00f.
- **Descubrimiento de Contenido**: Katana, Gau, FFUF, Gobuster.
- **Escaneo de Vulnerabilidades**: Nuclei, Dalfox, Nikto.
- **Análisis SSL/TLS**: testssl.sh, Nmap NSE scripts.

### 🪟 Windows & Active Directory
- **Enumeración de Red**: Nmap, NetExec (CrackMapExec), Nbtscan.
- **Evaluación AD**: Enumeración de usuarios, shares y políticas (SMBMap, Enum4linux).
- **Harvesting de Credenciales**: Detección de protocolos vulnerables (LLMNR/NBT-NS).

### 🐧 Auditoría de Servidores Linux
- **Detección de Servicios**: Nmap, SSH-Audit.
- **Análisis de Configuración**: Detección de cifrados débiles, protocolos obsoletos y misconfiguraciones.

### 📊 Reportes Profesionales
- **Reportes PDF Ejecutivos**: Formato limpio, profesional y listo para entregar al cliente.
- **Mapeo de Compliance**: OWASP Top 10, MITRE ATT&CK, CWE, PCI-DSS.
- **Clasificación de Severidad**: Crítico, Alto, Medio, Bajo, Informativo.

---

## 🚀 Instalación Rápida (Recomendada)

SentinelArg está diseñado para ser desplegado en segundos utilizando Docker. No es necesario instalar dependencias manualmente en su sistema operativo.

### Requisitos Previos
- Sistema operativo: Linux (Kali Linux, Ubuntu, Debian recomendados), macOS o Windows (WSL2).
- **Docker** y **Docker Compose** instalados.
- Mínimo 8GB de RAM (16GB o más, recomendados para el motor de IA local).
- GPU NVIDIA (Opcional, pero recomendada para aceleración de IA).

### Pasos de Instalación

1. **Descargue el paquete de SentinelArg** (ZIP o clonación del repositorio privado) y navegue a la carpeta:
   ```bash
   cd sentinelarg-client-release
   ```

2. **Ejecute el script de instalación automatizado** como root:
   ```bash
   sudo ./install.sh
   ```
   *Este script verificará Docker, creará los directorios necesarios, descargará la imagen pre-compilada más reciente y levantará los contenedores.*

3. **Acceda al Panel de Control**:
   Abra su navegador web y diríjase a:  
   🔗 **[http://localhost:8888](http://localhost:8888)**

---

## 🔑 Activación de Licencia

SentinelArg requiere una licencia válida para operar en modo producción. 

1. Adquiera su licencia en: [https://sentinelarg.com.ar/licencias](https://sentinelarg.com.ar/licencias)
2. Coloque el archivo de licencia recibido en la carpeta de instalación con el nombre `sentinelarg.license` (o siga las instrucciones de activación proporcionadas en su correo de compra).
3. Reinicie el servicio para aplicar la licencia:
   ```bash
   docker-compose restart sentinelarg-core
   ```

---

## 🔄 Actualización del Sistema

Mantener SentinelArg actualizado es crucial para contar con las últimas plantillas de vulnerabilidades y correcciones de seguridad. El proceso es seguro y preserva su base de datos y configuraciones.

Simplemente ejecute:
```bash
sudo ./update.sh
```
*El script realizará automáticamente una copia de seguridad de la base de datos, descargará la nueva imagen, reiniciará los servicios y limpiará las versiones antiguas.*

---

## 🔧 Configuración Avanzada

Puede personalizar los reportes PDF y el comportamiento de la plataforma editando el archivo `sentinelarg_config.json`:

```json
{
  "company_name": "Su Empresa de Ciberseguridad",
  "report_title": "Informe de Evaluación de Seguridad",
  "primary_color": "#8B0000",
  "footer_text": "Documento Confidencial - Generado por SentinelArg Red AI"
}
```

---

## 📚 Documentación y Soporte

- **Guía de Usuario Completa**: [Wiki de SentinelArg](https://github.com/alfasierra/sentinelarg/wiki)
- **Referencia de API**: [API Docs](https://github.com/alfasierra/sentinelarg/wiki/API)
- **Preguntas Frecuentes (FAQ)**: [FAQ](https://github.com/alfasierra/sentinelarg/wiki/FAQ)

Si necesita asistencia técnica, no dude en contactarnos a **soporte@sentinelarg.com.ar**.

---

## 🛡️ Herramientas Integradas

SentinelArg orquesta de forma transparente más de **150 herramientas de seguridad** de la industria, incluyendo:
- **Reconocimiento**: Nmap, Masscan, Rustscan, Amass, Subfinder.
- **Web**: Nuclei, Nikto, Dalfox, Gobuster, FFUF, WhatWeb.
- **Explotación**: Metasploit Framework, SQLMap, Hydra, Hashcat.
- **Red & AD**: NetExec, SMBMap, Enum4linux, Responder.

*(Nota: Todas las herramientas se ejecutan dentro de contenedores Docker aislados para garantizar la estabilidad y seguridad de su sistema anfitrión).*

---

<div align="center">

**Desarrollado con ❤️ por el Equipo de SentinelArg**  
*Protegiendo el mundo digital, una vulnerabilidad a la vez.*

</div>
```






