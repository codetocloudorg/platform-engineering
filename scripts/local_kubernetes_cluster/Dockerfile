# Use a base Ubuntu image
FROM ubuntu:22.04

# Install curl, xz-utils, bash, and any dependencies we might need
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    xz-utils \
    ca-certificates \
    gnupg \
    lsb-release && \
    # Add Docker's official GPG key and repository
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    # Install Docker CLI
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    # Clean up
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # Clean up any previous Nix installation artifacts
    rm -f /etc/bashrc.backup-before-nix \
          /etc/profile.d/nix.sh.backup-before-nix \
          /etc/zshrc.backup-before-nix \
          /etc/bash.bashrc.backup-before-nix || true

RUN ls /var/run

# Define the build argument for selecting which tool to install
ARG INSTALL

# Set the working directory in the container
WORKDIR /app

# Copy the run.sh script into the container
COPY ./run.sh /app/
COPY ./k3d_nix.sh /app/
COPY ./kind_nix.sh /app/
COPY ./resources/ /app/resources

# Make run.sh executable
RUN chmod +x /app/run.sh

# kind by default
ENTRYPOINT [ "/bin/bash", "./run.sh", "test", "kind"]
