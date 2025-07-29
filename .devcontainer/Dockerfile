# Use the official Ubuntu 22.04 LTS base image
FROM ubuntu:22.04

# Set a default locale to avoid locale-related issues
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Update and install essential dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    curl \
    gnupg \
    software-properties-common \
    wget \
    git \
    docker.io \
    unzip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && apt-get install -y --no-install-recommends terraform && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install OpenTofu
RUN curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o install-opentofu.sh && \
    chmod +x install-opentofu.sh && \
    ./install-opentofu.sh --install-method standalone || (cat install-opentofu.sh && exit 1) && \
    rm -f install-opentofu.sh

# Install Dagger CLI
RUN curl -L https://dl.dagger.io/dagger/install.sh | bash

# Install the Bicep CLI using the Azure CLI
RUN az bicep install

# Copy the code_to_cloud.txt file into the container
COPY motd/code_to_cloud.txt /etc/motd-code-to-cloud.txt

# Add the custom MOTD script
RUN echo '#!/bin/bash\n\
cat /etc/motd-code-to-cloud.txt' > /etc/update-motd.d/99-custom && \
    chmod +x /etc/update-motd.d/99-custom

# Create an entrypoint script to run the MOTD script on container start
RUN echo '#!/bin/bash\n\
/etc/update-motd.d/99-custom\n\
exec "$@"' > /usr/local/bin/entrypoint.sh && \
    chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint to the custom script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Ensure MOTD is dynamically generated
RUN ln -sf /run/motd.dynamic /etc/motd || touch /etc/motd

# Force the MOTD to display on login
RUN echo 'if [ -f /etc/motd ]; then cat /etc/motd; fi' >> /etc/bash.bashrc

# Verify Terraform installation
RUN terraform --version

# Verify OpenTofu installation
RUN tofu --version

# Verify Azure CLI installation
RUN az version

# Verify Bicep CLI installation
RUN az bicep version

# Verify Dagger CLI installation
RUN dagger version

# Verify the MOTD script exists and is executable
RUN ls -l /etc/update-motd.d/99-custom

# Verify the code_to_cloud.txt file exists
RUN ls -l /etc/motd-code-to-cloud.txt