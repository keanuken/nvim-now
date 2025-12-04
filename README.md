# Neovim Configuration

This is my personal Neovim configuration, managed as a dotfiles repository.

## Structure

- `init.lua`: Main entry point for the configuration
- `lua/core/`: Core configuration files (options, keymaps, autocommands, etc.)
- `lua/plugins/`: Plugin configurations
- `lua/theme.lua`: Theme configuration

## CI/CD Setup

This repository has GitHub Actions workflows to ensure the configuration remains valid:

- **Test Workflow**: Validates the configuration against multiple Neovim versions
- **Lint Workflow**: Checks Lua syntax with luacheck
- **Plugin Update Check**: Periodically checks plugin status

## Installation

To use this configuration:

1. Backup your current Neovim config (if any):
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/your-neovim-config.git ~/.config/nvim
   ```

3. Start Neovim and plugins will be automatically installed:
   ```bash
   nvim
   ```

## Contributing

If you find issues or have improvements:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request