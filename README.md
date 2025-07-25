# 🏠 Dotfiles Configuration

Personal dotfiles configuration for Ubuntu/Linux systems with a modern development environment setup.

## 📦 What's Included

### Core Applications
- **Neovim** - Modern text editor with extensive plugin configuration
  - NeoTree file explorer
  - Lualine status line
  - GitHub Copilot integration
  - LSP (Language Server Protocol) support
  - Tree-sitter syntax highlighting
  - Telescope fuzzy finder
  - FZF integration
- **Yazi** - Terminal file manager
- **Kitty** - GPU-accelerated terminal emulator
- **Zsh** - Enhanced shell with custom configuration
- **Starship** - Cross-shell prompt
- **Neofetch** - System information display
- **Btop** - Resource monitor
- **Conky** - System monitor
- **Lazygit** - Terminal UI for git
- **Windsurf** - Code editor configuration

### Themes & Customization
- **GNOME Themes** - Custom desktop themes
- **Terminal Themes** - Coordinated color schemes

## 🚀 Quick Installation

1. **Clone the repository** to your home directory:
   ```bash
   git clone <repository-url> ~/.dotfiles
   cd ~/.dotfiles
   ```

2. **Run the installation script**:
   ```bash
   ./script/installation/install.sh
   ```

3. **Setup GitHub Copilot** (optional):
   - Open Neovim and run `:Copilot setup`
   - If browser doesn't open automatically, run `:Copilot browser`
   - Or visit: https://github.com/login/device

## 📁 Directory Structure

```
.dotfiles/
├── .themes/          # GNOME desktop themes
├── .zshrc           # Zsh shell configuration
├── btop/            # Btop resource monitor config
├── conky/           # Conky system monitor config
├── kitty/           # Kitty terminal emulator config
├── lazygit/         # Lazygit configuration
├── neofetch/        # Neofetch system info config
├── nvim/            # Neovim configuration
├── script/          # Installation and utility scripts
├── starship.toml    # Starship prompt configuration
├── windsurf/        # Windsurf editor settings
├── yazi/            # Yazi file manager config
└── yazi_2/          # Additional Yazi configuration
```

## 🛠️ Available Scripts

The `script/` directory contains various utility scripts:

- `installation/install.sh` - Main installation script
- `update.sh` - Update dotfiles configuration
- `exportDotfiles.sh` - Export current configurations
- `chooseTheme.sh` - Theme selection utility
- `gocrypt.sh` - Encryption utilities
- `mountDrive.sh` / `unmountDrive.sh` - Drive management
- And more utility scripts for system management

## ⚙️ Manual Configuration

After installation, you may want to:

1. **Restart your terminal** or run `source ~/.zshrc`
2. **Configure Git** with your credentials
3. **Install additional fonts** if needed for proper icon display
4. **Customize themes** using the theme selection script

## 🔧 Customization

All configurations are modular and can be customized:

- Edit individual config files in their respective directories
- Modify `starship.toml` for prompt customization
- Update Neovim plugins in the `nvim/` directory
- Adjust terminal colors and fonts in `kitty/` config

## 📝 Notes

- Configurations are symlinked to maintain easy updates
- Backup of existing configs is handled automatically
- Compatible with Ubuntu and most Linux distributions
- Some features may require additional package installation



