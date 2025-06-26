#!/bin/bash

usage() {
    echo "Usage: $0 <service_name>"
    echo "Example: $0 myapp"
    exit 1
}

if [ $# -eq 0 ]; then
    echo "Error: Service name is required."
    usage
fi

SERVICE_NAME="$1"

if ! [[ "$SERVICE_NAME" =~ ^[a-zA-Z0-9_-]+$ ]]; then
    echo "Error: Service name can only contain letters, numbers, underscores, and hyphens."
    exit 1
fi

if [ -d "$SERVICE_NAME" ]; then
    echo "Error: Directory '$SERVICE_NAME' already exists."
    exit 1
fi

if grep -q "^  $SERVICE_NAME:" docker-compose.yml 2>/dev/null; then
    echo "Error: Service '$SERVICE_NAME' already exists in docker-compose.yml."
    exit 1
fi

echo "Creating new service: $SERVICE_NAME"

git clone https://github.com/damirtharaj0/docker-service-template.git "$SERVICE_NAME"

rm -rf "$SERVICE_NAME/.git"

cd "$SERVICE_NAME" || exit 1
git init
git add .
git commit -m "Initial commit for $SERVICE_NAME service"
cd .. || exit 1

echo "✓ Cloned service template for '$SERVICE_NAME'"
echo "✓ Removed git history from template"

cat >> docker-compose.yml << EOF
  $SERVICE_NAME:
    build: ./$SERVICE_NAME
    volumes:
      - ./$SERVICE_NAME/app:/app
    stdin_open: true
    tty: true
    command: ["tail", "-f", "/dev/null"]
EOF

echo "✓ Added '$SERVICE_NAME' service to docker-compose.yml"
echo "✓ Service '$SERVICE_NAME' has been successfully created!"
echo ""
echo "You can now:"
echo "1. Add your application code to ./$SERVICE_NAME/app/"
echo "2. Modify ./$SERVICE_NAME/Dockerfile if needed"
echo "3. Run 'docker-compose up $SERVICE_NAME' to start the service"