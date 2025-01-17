#!/bin/bash

# Logging function
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

# Retry function
retry() {
    local n=1
    local max=6
    local delay=12
    while true; do
        "$@" && break || {
            if [[ $n -lt $max ]]; then
                ((n++))
                log "Command failed. Attempt $n/$max:"
                sleep $delay;
            else
                log "The command has failed after $n attempts."
                return 1
            fi
        }
    done
}

# Update package list
log "Updating package list"
retry apt update -y
log "Package list updated"

# Install nginx
log "Installing nginx"
retry apt install -y nginx
log "Nginx installed"

# Create a sample index.html file
log "Creating a sample index.html file"
echo "Hello from $(hostname -f)" > /var/www/html/index.html
log "Sample index.html file created"

# Start nginx service
log "Starting nginx service"
retry systemctl restart nginx
log "Nginx service started"