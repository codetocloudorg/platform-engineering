# =============================================================================
# Code to Cloud - Platform Engineering Dev Container
# Minimal Ubuntu 24.04 LTS (Noble Numbat) with IaC tooling
# =============================================================================

FROM ubuntu:24.04 AS base

# Prevent interactive prompts during package installation
ARG DEBIAN_FRONTEND=noninteractive

# Set locale and environment
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    TERM=xterm-256color

# -----------------------------------------------------------------------------
# Stage 1: Install base dependencies (single layer for efficiency)
# -----------------------------------------------------------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    wget \
    git \
    unzip \
    jq \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# -----------------------------------------------------------------------------
# Stage 2: Install Docker CLI (for DinD support)
# -----------------------------------------------------------------------------
RUN install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc \
    && chmod a+r /etc/apt/keyrings/docker.asc \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends docker-ce-cli \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------------------------
# Stage 3: Install Azure CLI
# -----------------------------------------------------------------------------
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------------------------
# Stage 4: Install Terraform
# -----------------------------------------------------------------------------
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends terraform \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------------------------
# Stage 5: Install OpenTofu
# -----------------------------------------------------------------------------
RUN curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh -o /tmp/install-opentofu.sh \
    && chmod +x /tmp/install-opentofu.sh \
    && /tmp/install-opentofu.sh --install-method standalone \
    && rm -f /tmp/install-opentofu.sh

# -----------------------------------------------------------------------------
# Stage 6: Install Dagger CLI
# -----------------------------------------------------------------------------
RUN curl -fsSL https://dl.dagger.io/dagger/install.sh | BIN_DIR=/usr/local/bin bash

# -----------------------------------------------------------------------------
# Stage 7: Install Bicep CLI via Azure CLI
# -----------------------------------------------------------------------------
RUN az bicep install

# -----------------------------------------------------------------------------
# MOTD Configuration
# -----------------------------------------------------------------------------
COPY motd/code_to_cloud.txt /etc/motd-code-to-cloud.txt

RUN printf '#!/bin/bash\ncat /etc/motd-code-to-cloud.txt\n' > /etc/update-motd.d/99-custom \
    && chmod +x /etc/update-motd.d/99-custom \
    && ln -sf /run/motd.dynamic /etc/motd 2>/dev/null || touch /etc/motd \
    && echo '[ -f /etc/motd-code-to-cloud.txt ] && cat /etc/motd-code-to-cloud.txt' >> /etc/bash.bashrc

# -----------------------------------------------------------------------------
# Entrypoint
# -----------------------------------------------------------------------------
RUN printf '#!/bin/bash\n/etc/update-motd.d/99-custom\nexec "$@"\n' > /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]

# -----------------------------------------------------------------------------
# Verification (build-time checks)
# -----------------------------------------------------------------------------
RUN echo "=== Tool Versions ===" \
    && terraform --version \
    && tofu --version \
    && az version -o table \
    && az bicep version \
    && dagger version \
    && docker --version