local options = {
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
}

return options
