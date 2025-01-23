vim.g.mapleader = " "
vim.opt.number = true
vim.opt.wrap = false

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
