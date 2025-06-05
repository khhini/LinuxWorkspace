return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    init_options = {
      userLanguages = {
        eelixir = "html-eex",
        eruby = "erb",
        rust = "html",
      },
    },
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
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
        "prisma", "http"
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
  },

  {
    "rest-nvim/rest.nvim",
    cmd = { "Rest" },
    init = function ()
      vim.g.rest_nvim  = {}
      require("telescope").load_extension("rest")
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function (_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "http")
      end,
      "nvim-lua/plenary.nvim"
    }
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
  },

  {
    "olimorris/codecompanion.nvim",
    opts = {},
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionCmd", "CodeCompanionActions" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "ravitemer/mcphub.nvim",
        build = "npm install -g mcp-hub@latest",
        config = function()
          require("mcphub").setup()
        end
      }
    },
    config = function()
        require("codecompanion").setup({
          strategies = {
            chat = {
              adapter = "gemini",
            },
            inline = {
              adapter = "gemini",
            },
          },

          adapters = {
            gemini = function()
              return require("codecompanion.adapters").extend("gemini", {
                env = {
                  api_key = os.getenv("GEMINI_API_KEY")
                },
              })
            end,
          },

          extensions = {
            mcphub = {
              callback = "mcphub.extensions.codecompanion",
              opts = {
                show_result_in_chat = true,  -- Show mcp tool results in chat
                make_vars = true,            -- Convert resources to #variables
                make_slash_commands = true,  -- Add prompts as /slash commands
              }
            }
          }
        })

    end
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "markdown", "codecompanion" },
        ignore_buftypes = {},
      },
    },
  },

  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },

  {
    "HakonHarnes/img-clip.nvim",
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },
}
