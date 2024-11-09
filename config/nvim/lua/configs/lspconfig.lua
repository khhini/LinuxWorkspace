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
  "rust_analyzer",
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
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          loadOutDirsFromCheck = true,
          allFeatures = true,
        },
        procMacro = {
          enable = true,
        },
      },
    }
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
