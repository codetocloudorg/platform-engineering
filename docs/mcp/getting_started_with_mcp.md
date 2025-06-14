# 🧠 Top Model Context Protocol (MCP) Servers

Welcome to the **Code to Cloud Platform Engineering** knowledge hub. This document highlights the most relevant and impactful **Model Context Protocol (MCP)** servers available today. MCP servers bridge AI agents, developer tools, and cloud-native infrastructure via a standardized JSON-RPC interface.

MCP servers enable advanced automation, reasoning, and orchestration by exposing authoritative APIs to AI copilots, developer environments, and multi-agent systems.

---

## 🔝 Top MCP Servers

| Rank | MCP Server | Description | Maintainer | Link |
|------|------------|-------------|------------|------|
| 1 | **Microsoft Docs MCP Server** | Provides trusted, up-to-date results from Microsoft Docs, allowing LLMs to ground responses in official Azure and Microsoft documentation. Ideal for copilots and agents that need authoritative technical answers, code samples, and best practices directly from Microsoft’s knowledge base. | Microsoft | [Microsoft Docs MCP Server on GitHub](https://github.com/MicrosoftDocs/mcp) |
| 2 | **GitHub MCP Server** | Connects to GitHub’s API for real-time access to pull requests, issues, repositories, and workflows. Enables developer automation, code review, and repository insights through natural language prompts. Useful for copilots that assist with code management, CI/CD, and project tracking. | GitHub | [GitHub MCP Server on GitHub](https://github.com/github/github-mcp-server) |
| 3 | **Terraform MCP Server** | Bridges the Terraform Registry with AI tooling, enabling LLMs to search, recommend, and validate infrastructure-as-code modules and policies. Supports DevOps workflows by providing context-aware IaC guidance, compliance checks, and resource documentation. | HashiCorp | [Terraform MCP Server on GitHub](https://github.com/hashicorp/terraform-mcp-server) |
| 4 | **Azure DevOps MCP Server** | Exposes Azure DevOps resources such as pipelines, repositories, and boards. Allows copilots and agents to interact with CI/CD systems, automate deployments, monitor build status, and manage work items using conversational commands. | Microsoft | [Azure DevOps MCP Server on GitHub](https://github.com/microsoft/azure-devops-mcp) |
| 5 | **Azure MCP Server** | Exposes a wide range of Azure tools and services for natural language interaction. Use it to manage and query Azure resources conversationally from clients like GitHub Copilot agent mode in VS Code or other AI agents.<br/>Example prompts:<br/>• "Show me all my resource groups"<br/>• "List blobs in my storage container named 'documents'"<br/>• "What's the value of the 'ConnectionString' key in my app configuration?"<br/>• "Query my log analytics workspace for errors in the last hour"<br/>• "Show me all my Cosmos DB databases" | Microsoft | [Azure MCP Server on GitHub](https://github.com/Azure/azure-mcp) |
| 6 | **Dagger Container Use MCP Server** | Lets each coding agent have its own containerized environment. Enables multiple agents to work safely and independently with your preferred stack.<br/>Features:<br/>• 📦 Isolated Environments<br/>• 👀 Real-time Visibility<br/>• 🚁 Direct Intervention<br/>• 🎮 Environment Control<br/>• 🌎 Universal Compatibility<br/>Works as a CLI tool with Claude Code, VS Code, Cursor, and other MCP-compatible agents. | Dagger | [Dagger Container Use MCP Server on GitHub](https://github.com/dagger/container-use) |
| 7 | **npm MCP Server** | Interfaces with the npm registry, allowing copilots to suggest, search, and retrieve metadata for JavaScript/TypeScript packages. Supports package discovery, dependency management, and vulnerability checks directly from development environments. | Community | [npm MCP Server on GitHub](https://www.npmjs.com/package/mcp-server) |
| 8 | **Figma Context MCP Server** | Integrates Figma design data with LLMs and agents, enabling natural language access to design files, components, and project assets. Useful for design copilots, automated documentation, and design-to-code workflows. | Community | [Figma Context MCP Server on GitHub](https://github.com/GLips/Figma-Context-MCP) |
| 9 | **OpenAPI MCP Server Scaffold** | A boilerplate for wrapping any OpenAPI-compliant service into an MCP server. Ideal for quickly exposing internal APIs or SaaS products to LLMs and agents, enabling natural language access to custom business logic and data. | Community | [OpenAPI MCP Docs Scaffold](https://platform.openai.com/docs/mcp) |
| 10 | **Notion MCP Server** | Connects LLMs and agents to Notion workspaces, enabling natural language access to notes, documents, databases, and project management resources. Useful for productivity copilots, knowledge management, and workflow automation within Notion. | Notion | [Notion MCP Server on GitHub](https://github.com/makenotion/notion-mcp-server) |

---

## ⚙️ Why MCP Matters for Platform Engineering

Model Context Protocol enables:

- ✨ **Grounded AI assistants:** Context-aware and source-authoritative copilots.
- ⚙️ **Automated CI/CD and IaC workflows:** Natural language interfaces for DevOps.
- 📊 **Insights and analytics:** From source control or artifact registries.
- 🧠 **Multi-agent cooperation:** In cloud-native developer environments.

---

## 🧪 **Contributing**

**Have you built or deployed your own MCP server for internal APIs, cloud systems, or SaaS products?**  
We’d love to feature community-contributed MCP endpoints here. Open a PR or reach out via our [contributing page](../../CONTRIBUTING.md).

---

🏔️ [codetocloud.io](https://codetocloud.io)