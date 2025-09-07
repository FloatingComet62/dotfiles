require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "rust_analyzer", "zls" }
vim.lsp.enable(servers)

local lspconfig = require("lspconfig")

-- Rust
lspconfig.rust_analyzer.setup{}

-- Zig
lspconfig.zls.setup{
  cmd = { "zls" },
  filetypes = { "zig", "zir" },
  root_dir = lspconfig.util.root_pattern("build.zig", "zls.json", ".git")
}

-- TS/JS
lspconfig.ts_ls.setup {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = {
    "javascript", "javascriptreact",
    "typescript", "typescriptreact",
    "javascript.jsx", "typescript.tsx"
  },
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git")
}

-- Python
lspconfig.pylsp.setup {
  cmd = { "pylsp" },
  filetypes = { "python" },
  settings = {
    pylsp = {
      plugins = {
        black = { enabled = true },
        ruff = { enabled = true },
        flake8 = { enabled = true },
        isort = { enabled = true }
      }
    }
  }
}

-- Elixir
lspconfig.elixirls.setup {
  cmd = { "elixir-ls" },
  filetypes = { "elixir" },
}

-- Erlang
lspconfig.erlangls.setup {
  cmd = { "erlang-ls" },
  filetypes = { "erlang" },
}

-- C/C++
lspconfig.clangd.setup {
  cmd = { "clangd" },
  filetypes = { "c", "cpp" }
}

-- Gopls
lspconfig.gopls.setup {
  cmd = { "gopls" },
  filetype = { "go" }
}
