# 🐧 Linux Based Dev Environment

A powerful, efficient development environment designed for Linux users who want to maximize productivity through keyboard-driven workflows and terminal-based tools.

## 🚀 Quick Start Options

| Method                   | 💾 Persistence | 📋 Requirements                                                                                         |
| ------------------------ | -------------- | ------------------------------------------------------------------------------------------------------- |
| **🔥 Nix (Recommended)** | Temporary      | [Nix](https://nixos.org/) + [Flakes](https://nixos.wiki/wiki/flakes)                                    |
| **🐳 Docker**            | Temporary      | [Docker](https://docs.docker.com/engine/install/) + [Compose](https://docs.docker.com/compose/install/) |
| **💻 Full Installation** | Permanent      | Debian 12 or Arch Linux                                                                                 |

---

## 🎯 What You'll Get

This environment provides a complete, keyboard-driven development setup with:

- **🪟 Hyprland** - Modern tiling window manager
- **⚡ Alacritty** - GPU-accelerated terminal
- **🐟 Fish Shell** - User-friendly shell with great defaults
- **🔀 Tmux** - Terminal multiplexer for session management
- **✨ Neovim** - Highly customizable text editor with LSP support
- **🌟 Starship** - Beautiful, informative prompt

---

## 🛠️ Installation Methods

### 🔥 Option 1: Nix (Recommended for trying out)

> **✨ Best for:** Testing the environment without system changes
>
> **⚠️ Note:** This creates a temporary environment - changes won't persist after exit

```bash
# Navigate to the project directory
cd linux_env

# Enter the development environment
# First run will take some time to download and build
nix develop

# 🎉 You're now in the environment! Try running:
tmux    # Start terminal multiplexer
nvim    # Open Neovim editor
```

### 🐳 Option 2: Docker

> **✨ Best for:** Isolated testing on any system with Docker

```bash
# Navigate to the project directory
cd linux_env

# Start the containerized environment
docker compose run dev && docker compose down
```

### 💻 Option 3: Full Installation

> **✨ Best for:** Making this your daily development environment
>
> **⚠️ Note:** Only supports Debian 12 & Arch Linux

```bash
# Navigate to the project directory
cd linux_env

# Install everything to your system
./scripts/linux_env.sh
```

---

## 🏗️ Architecture Overview

### 🪟 Window Manager - Your Desktop Foundation

Think of this as the "desktop" that organizes all your application windows. Unlike Windows or macOS which come with a fixed window manager, Linux lets you choose:

- **🎯 [Hyprland](https://wiki.archlinux.org/title/Hyprland)** - Modern, smooth animations, easy configuration
- **⚡ Benefits:** Lightning-fast window switching, keyboard-driven workflow, multiple workspaces

### 🖥️ Terminal - Your Command Center

The terminal is where you'll spend most of your time. It's the gateway to your shell and all command-line tools:

- **🚀 [Alacritty](https://alacritty.org/)** - GPU-accelerated for speed, simple TOML configuration
- **🔄 Alternatives:** [Wezterm](https://wezterm.org/), [Ghostty](https://ghostty.org/)

### 🐚 Shell - Your Command Interpreter

The shell interprets and executes your commands. It's like the "brain" of your terminal:

- **🐟 [Fish](https://fishshell.com/)** - Beginner-friendly with smart autocompletion
- **✨ [Starship](https://starship.rs/)** - Beautiful prompt showing git status, language versions, etc.
- **🔄 Alternative:** Zsh (if you need POSIX compliance for scripting)

### 🔀 Terminal Multiplexer - Multiple Sessions, One Terminal

Think of this as "tabs" for your terminal, but much more powerful:

- **🔀 [Tmux](https://github.com/tmux/tmux)** - Split panes, multiple windows, session persistence
- **💡 Why useful:** Run multiple commands simultaneously, keep sessions alive when disconnected

### ✏️ Editor - Where the Magic Happens

Your text editor is your most personal tool. This setup provides a powerful, customizable foundation:

- **✨ [Neovim](https://neovim.io/)** - Modern Vim with Lua configuration
- **🔌 Features included:** LSP support, auto-completion, file explorer, fuzzy finding
- **🎓 Learning curve:** Steep but rewarding - includes vim motions for efficient editing

---

## ⌨️ Essential Keybinds

### 🔀 Tmux - Terminal Multiplexer

> **🔑 Prefix Key:** `Ctrl-a` (press this before other tmux commands)

#### 📱 Window & Pane Management

| Combo          | Action                                   |
| -------------- | ---------------------------------------- |
| `Prefix + \|`  | 📊 Split vertically (side-by-side panes) |
| `Prefix + -`   | ➖ Split horizontally (top-bottom panes) |
| `Prefix + c`   | ➕ Create new window                     |
| `Prefix + ,`   | ✏️ Rename current window                 |
| `Prefix + n/p` | ⏭️⏮️ Next/Previous window                |

#### 🔧 Pane Control

| Combo              | Action                              |
| ------------------ | ----------------------------------- |
| `Prefix + H/J/K/L` | 📏 Resize pane (left/down/up/right) |
| `Prefix + z`       | 🔍 Toggle pane zoom (fullscreen)    |
| `Prefix + o`       | 🔄 Switch to next pane              |
| `Prefix + x`       | ❌ Kill current pane                |

#### 📋 Copy Mode

| Combo              | Action               |
| ------------------ | -------------------- |
| `Prefix + [`       | 📝 Enter copy mode   |
| `v` (in copy mode) | ✅ Start selection   |
| `y` (in copy mode) | 📋 Copy to clipboard |
| `Prefix + ]`       | 📌 Paste             |

### ✨ Neovim - Text Editor

See [here](https://www.lazyvim.org/keymaps)

---

## 🎓 Learning Resources

### 📚 Getting Started

- **Vim Movements:** Use `vimtutor` command for interactive tutorial
- **Cheatsheet:** [Vim Quick Reference](https://vim.rtorr.com/)
- **Tmux Guide:** [Tmux Cheat Sheet](https://tmuxcheatsheet.com/)

### 🔌 Extending Your Setup

- **Neovim Plugins:** [neovimcraft.com](https://neovimcraft.com/)
- **Plugin Discovery:** [dotfyle.com](https://dotfyle.com/neovim/plugins/trending)
- **Awesome List:** [awesome-neovim](https://github.com/rockerBOO/awesome-neovim)

### 💡 Pro Tips

1. **Start Simple:** Use the basic keybinds first, add complexity gradually
2. **Muscle Memory:** Practice the essential movements until they're automatic
3. **Customize Gradually:** Add one plugin/setting at a time to avoid overwhelm
4. **Use Help:** `:help` in Neovim is incredibly comprehensive

---

## 🤝 Getting Help

- **Neovim Help:** Type `:help <topic>` in Neovim
- **Tmux Manual:** `man tmux` or [online docs](https://github.com/tmux/tmux/wiki)
- **Fish Documentation:** [fishshell.com/docs](https://fishshell.com/docs/current/)
- **Key Bindings:** Press `<leader>?` in Neovim to see all available shortcuts

Happy coding! 🚀
