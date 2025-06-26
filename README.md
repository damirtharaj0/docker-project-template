# Docker Project Template

A flexible Docker-based project template that allows you to quickly create and manage multiple microservices using Docker Compose.

## Overview

This template provides a foundation for building multi-service applications with Docker. It includes an automated script to generate new services from a template repository, making it easy to maintain consistent service structure across your project.

## Features

- 🚀 **Quick Service Creation**: Generate new services with a single command
- 🐳 **Docker Compose Integration**: Services are automatically added to `docker-compose.yml`
- 📁 **Consistent Structure**: All services follow the same template structure
- 🔧 **Development Ready**: Services are configured with volume mounting for live development
- 🎯 **Service Isolation**: Each service runs in its own container

## Getting Started

### Prerequisites

- Docker and Docker Compose installed
- Git installed
- Bash shell (macOS/Linux)

### Quick Start

1. **Clone this template**:
   ```bash
   git clone https://github.com/damirtharaj0/docker-project-template my-project
   cd my-project
   ```

2. **Create your first service**:
   ```bash
   ./add_service.sh myapp
   ```

3. **Start the service**:
   ```bash
   docker compose up myapp
   # or 
   docker compose up # to start all services
   ```

## Usage

### Adding a New Service

Use the `add_service.sh` script to create new services:

```bash
./add_service.sh <service_name>
```

**Example**:
```bash
./add_service.sh api
./add_service.sh frontend
./add_service.sh database
```

### Service Naming Rules

- Service names can only contain letters, numbers, underscores, and hyphens
- Service names must be unique within the project
- Directory names will match the service names

### What the Script Does

1. **Clones the service template** from `https://github.com/damirtharaj0/docker-service-template.git`
2. **Removes git history** from the cloned template
3. **Initializes a new git repository** for the service
4. **Updates docker-compose.yml** with the new service configuration
5. **Provides next steps** for development

### Working with Services

After creating a service, you can:

1. **Add your application code** to `./<service_name>/app/`
2. **Modify the Dockerfile** in `./<service_name>/` if needed
3. **Start the service** with `docker compose up <service_name>`
4. **View logs** with `docker compose logs <service_name>`

## Project Structure

```
.
├── README.md
├── docker-compose.yml          # Main Docker Compose configuration
├── add_service.sh             # Service creation script
└── <service_name>/            # Generated service directories
    ├── Dockerfile
    ├── app/                   # Your application code goes here
    └── ...                    # Other service-specific files
```

## Docker Compose Commands

```bash
# Start all services
docker compose up

# Start specific service
docker compose up <service_name>

# Start services in background
docker compose up -d

# Stop all services
docker compose down

# View logs
docker compose logs <service_name>

# Rebuild a service
docker compose build <service_name>

# Execute commands in a running container
docker compose exec <service_name> <command>
```

## Development Workflow

1. **Create a new service** using the add_service script
2. **Develop your application** in the `<service_name>/app/` directory
3. **Test locally** using `docker compose up <service_name>`
4. **Scale horizontally** by adding more services as needed

## Service Template

Services are created from the template at: https://github.com/damirtharaj0/docker-service-template.git

The template includes:
- Basic Dockerfile configuration
- Development-friendly setup with volume mounting
- Interactive terminal support (`stdin_open: true`, `tty: true`)
- Keep-alive command for development containers

## Troubleshooting

### Common Issues

1. **Service already exists**: The script checks for existing services and directories
2. **Invalid service name**: Only alphanumeric characters, underscores, and hyphens are allowed
3. **Git not initialized**: Make sure git is installed and available in your PATH

### Cleaning Up

To remove a service:

1. Stop the service: `docker compose stop <service_name>`
2. Remove from docker-compose.yml manually
3. Delete the service directory: `rm -rf <service_name>`
