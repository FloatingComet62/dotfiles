vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.number = true
vim.opt.wrap = false
vim.opt.signcolumn = 'yes'

vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 0

-- Use spaces instead of tabs
vim.opt.expandtab = true

-- Split open explorer
vim.keymap.set('n', '<leader><A-e>', ':Ex<CR>', { noremap = true, silent = true }) -- Replace Current
vim.keymap.set('n', '<leader><S-e>', ':Sex<CR>', { noremap = true, silent = true }) -- Horizontal
vim.keymap.set('n', '<leader>e', ':Vex<CR>', { noremap = true, silent = true })     -- Vertical

-- Vertical resize
vim.keymap.set('n', '<A-Left>', ':vertical resize -1<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Right>', ':vertical resize +1<CR>', { noremap = true, silent = true })

-- Horizontal resize
vim.keymap.set('n', '<A-Up>', ':resize +1<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Down>', ':resize -1<CR>', { noremap = true, silent = true })

-- Buffer
vim.keymap.set('n', '<leader>c', ':bd<CR>', { noremap = true, silent = true })   -- Close Buffer
vim.keymap.set('n', '<leader>C', ':bd!<CR>', { noremap = true, silent = true })  -- Force Close Buffer
vim.keymap.set('n', '<leader>h', ':hide<CR>', { noremap = true, silent = true }) -- Hide Buffer

-- Switch buffer
vim.keymap.set('n', '<leader>n', ':bnext<CR>', { noremap = true, silent = true })     -- Next Buffer
vim.keymap.set('n', '<leader>p', ':bprevious<CR>', { noremap = true, silent = true }) -- Previous Buffer

-- Navigate between buffers
vim.keymap.set('n', '<A-k>', ':wincmd k<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-j>', ':wincmd j<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-h>', ':wincmd h<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-l>', ':wincmd l<CR>', { noremap = true, silent = true })


require("config.lazy")

-- this line will not work if lazy.nvim hasn't got around installing nightfox, so comment this out, run nvim, then uncomment it, then restart
-- until i come up with a better solution
vim.cmd("colorscheme carbonfox")

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = {'lua_ls', 'rust_analyzer', 'ts_ls'},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  }
})
