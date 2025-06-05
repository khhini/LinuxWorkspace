-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = {
  -- HTML & CSS
  "html", "cssls",
  -- HTMX
  "htmx",
  -- LUA
  "lua_ls",
  -- Golang
  "gopls",
  -- JavaScript & Typescript LSP
  "eslint", "ts_ls", "angularls",
  -- Terraform
  "terraformls", "tflint", --"tfsec",
  -- Rust
  -- "rust_analyzer",
  -- SQL
  "postgres_lsp", "sqlls",
  -- Pythom
  "pyright",
  -- Docker
  "dockerls", "docker_compose_language_service",
  -- Markdown
  "marksman",
  -- HELM
  "helm_ls",
  -- JSON
  "jsonls",
  -- NGINX
  "nginx_language_server",
  -- YAML
  "yamlls"
}

local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  local server_config = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  if lsp == "rust_analyzer" then
    -- ## Setup for rust-analyzer
    server_config.settings = {
      -- Note: The key is 'rust-analyzer' (with a hyphen)
      ['rust_analyzer'] = {
        imports = {
          prefix = "self"
        },
        cargo = {
          loadOutDirsFromCheck = true,
          allFeatures = true,
        },
        checkOnSave = {
          command = "clippy"
        },
        procMacro = {
          enable = true,
        },
      }
    }
  end

  lspconfig[lsp].setup(server_config)
end
