return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require 'nvim-tree'.setup {
        view = {
          side = 'right', -- Set to open on the right side
        },
      }
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "terraform",
        "markdown", "markdown_inline",
        "rust", "javascript", "typescript",
        "json", "yaml", "python",
        "sql", "promql", "dockerfile",
        "go", "graphql", "helm", "hcl",
        "angular", "todotxt", "toml", "bash",
        "prisma"
      },

      auto_install = true,

      highlight = {
        enable = true
      }
    },
  },

  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    "mikavilpas/yazi.nvim",
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
    }
  }
}
