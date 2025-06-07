# Dotfiles Management Using GNU Stow

This guide explains how to manage your dotfiles effectively using GNU Stow. GNU Stow helps you organize your configuration files by creating symlinks from a central repository to their respective locations, simplifying version control and synchronization.

## Installation

GNU Stow is generally available in the package repositories of most Linux distributions.

```bash
# On Arch Linux:
sudo pacman -S stow
```

## Usage

To use GNU Stow, organize your dotfiles into separate directories for each application within your main dotfiles repository (e.g., `~/dotfiles/nvim` for Neovim configurations).

**1. Create Symlinks:**

Navigate into the specific application's directory within your dotfiles repository, then run the `stow` command.

```bash
# Example: Sync nvim dotfiles from ~/dotfiles/nvim to ~/.config/nvim
cd ~/dotfiles/nvim
stow . -t ~/.config/nvim
```

*   `.`: Refers to the current directory (`~/dotfiles/nvim`), indicating that its contents should be linked.
*   `-t ~/.config/nvim`: Specifies the *target* directory where the symlinks will be created.

**2. Remove Symlinks (Unstow):**

To remove the symlinks created by Stow, use the `-D` (delete) flag from the same location.

```bash
# Example: Unstow nvim dotfiles
cd ~/dotfiles/nvim
stow -D . -t ~/.config/nvim
```

**Important Notes:**
*   **Conflicts:** If files or directories already exist in the target location that would conflict with Stow's symlinks, Stow will not proceed. You may need to move or remove existing conflicting files before running `stow`.
*   **Location:** Always run the `stow` command from *within* the specific dotfile subdirectory (e.g., `~/dotfiles/nvim`) and not from the root of your dotfiles repository.
