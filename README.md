# Docker-Container-Hardening
# 🐳 Secure Docker Container Deployment (Hardening)

## 📋 Project Overview
This project demonstrates a secure implementation of a microservices architecture (WordPress + MySQL) using Docker and Docker Compose. Unlike standard deployments, this configuration applies **Container Hardening** techniques to mitigate common vulnerabilities such as privilege escalation and unauthorized network access.

## 🎯 Key Security Features Implemented

### 🛡️ 1. Principle of Least Privilege (Non-Root Execution)
By default, Docker containers run as `root`, representing a significant security risk if the container is compromised.
* **Hardening Action:** Modified the `Dockerfile` to create a dedicated system user (`appuser`) and switch context before executing the application.
* **Benefit:** Prevents attackers from gaining superuser privileges on the host system via container breakout.

### 🛡️ 2. Network Isolation (Segmentation)
Instead of using the default bridge network, custom networks were defined to isolate critical services.
* **Hardening Action:** The Database container is placed on a `backend` network, making it inaccessible directly from the outside world. Only the WordPress container can communicate with it via an internal `frontend` network.

### 🛡️ 3. Persistence & Data Integrity
* **Hardening Action:** Implementation of named Docker Volumes.
* **Benefit:** Decouples data from the container lifecycle, ensuring data persists even if containers are destroyed or updated.

## 📂 Repository Structure
* **`Dockerfile`**: Custom build instructions including user creation and permission handling.
* **`docker-compose.yml`**: Orchestration file with network segmentation and volume mapping.
* **`.env.example`**: Template for environment variables to avoid hardcoding secrets.

## 🚀 Deployment Instructions

### Prerequisites
* Docker Engine
* Docker Compose

### Installation Steps

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/your-username/Docker-Container-Hardening.git](https://github.com/your-username/Docker-Container-Hardening.git)
   cd Docker-Container-Hardening
   ```

2. **Configure Environment Variables:**
   Rename `.env.example` to `.env` and set strong passwords.
   ```bash
   mv .env.example .env
   ```

3. **Build and Run:**
   ```bash
   docker-compose up -d --build
   ```

4. **Verify Running Containers:**
   ```bash
   docker ps
   ```

## ⚙️ Configuration Snippets

### Secure Dockerfile Example
```dockerfile
FROM wordpress:latest

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Change ownership of working directory
RUN chown -R appuser:appgroup /var/www/html

# Switch to non-root user
USER appuser
```

### Network Segregation (docker-compose)
```yaml
networks:
  frontend:
  backend:
    internal: true # No external access
```

## 🛠️ Tech Stack
* **Containerization:** Docker Engine
* **Orchestration:** Docker Compose
* **Database:** MySQL 8.0
* **CMS:** WordPress
* **OS:** Linux (Debian based images)

## 📄 License
Project created for the Master's Degree in Cybersecurity - Advanced Competencies Module.
