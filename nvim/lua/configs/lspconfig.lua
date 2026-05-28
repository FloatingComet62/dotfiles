require("nvchad.configs.lspconfig").defaults()

-- NOTE: DO NOT USE MASON TO INSTALL LSPs, THEY CONFLICT WITH THESE, IF YOU
-- HAVE ANY INSTALLED, REMOVE THEM
local servers = { "html", "cssls", "rust_analyzer", "zls", "ts_ls", "pylsp" }
vim.lsp.enable(servers)

vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--query-driver=/run/current-system/sw/bin/arm-none-eabi-gcc",
  },
})

vim.lsp.enable("clangd")
