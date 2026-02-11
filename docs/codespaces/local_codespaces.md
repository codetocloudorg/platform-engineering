# 🖥️ Local Codespaces: Offline and High-Performance Development

## 🚀 Quick Option: Kodra

For a fully automated local development setup with 30+ cloud-native tools:

| Platform | Link |
|----------|------|
| 🐧 **Ubuntu Desktop** | [kodra.codetocloud.io](https://kodra.codetocloud.io) |
| 🪟 **Windows + WSL** | [kodra.wsl.codetocloud.io](https://kodra.wsl.codetocloud.io) |

---

## 🌟 What Are Local Codespaces?

Local Codespaces bring the power of pre-configured development environments to your own machine. They allow developers to work offline and leverage local hardware for better performance, making them ideal for resource-intensive tasks or environments with limited internet access.

---

## 🔑 Key Benefits of Local Codespaces

- **🖥️ Offline Development**: Work without relying on an internet connection.
- **⚡ Faster Performance**: Leverage local hardware for builds, tests, and debugging.
- **🔧 Full Control**: Customize your local environment to suit your specific needs.
- **🔄 Consistency**: Use the same tools and configurations as your team.

---

## 🎯 When to Use Local Codespaces?

| **Scenario**                     | **Best Option**       |
|-----------------------------------|-----------------------|
| 🛠️ Offline development            | 🖥️ Local Codespaces   |
| ⚡ Low-latency performance required | 🖥️ Local Codespaces   |
| 🏗️ Resource-intensive tasks        | 🖥️ Local Codespaces   |

---

## 🛠️ How to Set Up Local Codespaces

1. **🔧 Install Prerequisites**:  
   - Install **Visual Studio Code** and the **Remote - Containers** extension:  
     - 🖥️ [Download VS Code](https://code.visualstudio.com/).  
     - 🛠️ Install the **Remote - Containers** extension from the VS Code marketplace.  
   - Install **Docker Desktop (Community Edition)**:  
     - 🐳 [Download Docker Desktop](https://www.docker.com/products/docker-desktop).  
     - Verify Docker is running by executing:  
       ```bash
       docker --version
       ```

2. **📂 Clone Your Repository**:  
   - Clone the repository containing your platform engineering project:
     ```bash
     git clone <repository-url>
     cd <repository-folder>
     ```

3. **⚙️ Configure the `.devcontainer` Files**:  
   - The repository includes a pre-configured `.devcontainer` folder located at `./local_example/.devcontainer`.  
   - This folder contains:  
     - **`Dockerfile`**: Defines the container environment and installs required tools:
       - Azure CLI (with Bicep CLI)
       - Terraform
       - OpenTofu
       - Dagger CLI
     - **`devcontainer.json`**: Configures VS Code extensions, settings, and container-specific configurations.  
     - **`settings.json`**: Ensures required extensions (e.g., Docker, Terraform, Bicep, Go, Python) are installed automatically and customizes VS Code behavior.  
   - **What `settings.json` Does**:  
     - Installs specific extensions automatically.  
     - Customizes VS Code behavior, such as disabling extension recommendations to streamline the development experience.  
   - Ensure these files are correctly configured for your development needs.

4. **🚀 Start Your Local Codespace**:  
   - Open the project in **Visual Studio Code**.  
   - When prompted, select **"Reopen in Container"** to start the Local Codespace.  
   - VS Code will:  
     - Build the container using the `./local_example/.devcontainer/Dockerfile`.  
     - Apply the settings from `./local_example/.devcontainer/devcontainer.json` and `settings.json`.

---

## 🌟 Conclusion

Local Codespaces are perfect for developers who need offline access, low-latency performance, or full control over their environment. By leveraging the pre-configured `.devcontainer` folder, including the `Dockerfile`, `devcontainer.json`, and `settings.json`, you can ensure consistency and efficiency in platform engineering development and deployment workflows.  

Start using Local Codespaces today to supercharge your development workflow! 🚀