local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

local lspconfig_status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not lspconfig_status_ok then
  return
end

local servers = {
  "sumneko_lua",
  "cssls",
  "html",
  "tsserver",
  "pylsp",
  "bashls",
  "jsonls",
  "yamlls",
  "clangd",
  "cmake",
  "dockerls",
  "esbonio",
  "golangci_lint_ls",
  "gopls",
  "jsonnet_ls",
  "rust_analyzer",
  "sqlls",
  "svelte",
}

mason_lsp.setup({
    ensure_installed = servers,
    automatic_installation = false,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  if server == "sumneko_lua" then
    local sumneko_opts = require "user.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
  end


  lspconfig[server].setup(opts)
end
