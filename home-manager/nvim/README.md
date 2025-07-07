# Neovim Setup

## Current Modules

### nvim-cmp

Keybindings for `nvim-cmp`:

- `<Tab>`: Used by Supermaven for completion and accepting the current LSP
  completion
- `<C-Tab>`: Used by Supermaven to hide the completion menu
- `<C-Space>`: Used by Supermaven to trigger next-word completion
- `<C-e>`: Used by LSP to hide the completion menu
- `<C-n>`: Used by LSP to go to the next item in the completion menu
- `<C-p>`: Used by LSP to go to the previous item in the completion menu
- `<C-j>`: Used by LSP to scroll down in the completion menu
- `<C-k>`: Used by LSP to scroll up in the completion menu
- `<CR>`: Used by LSP to select the current item in the completion menu

### telescope

Keybindings for `telescope`:

- `<leader>ff`: Find files
- `<leader>fg`: Find Git files
- `<leader>fs`: Find with live grep
- `<leader>fb`: Find buffers
- `<leader>fh`: Find Harpoon links

### harpoon

Keybindings for `harpoon`:

- `<leader>a`: Add Harpoon link
- `<C-e>`: Open quick menu
- `<leader>1` to `<leader>5`: Open Harpoon link by index
- `<leader>fh`: Find Harpoon links (also accessible via `telescope`)

### oil.nvim

Keybinding for `oil.nvim`:

- `-`: Open Oil menu

### LSP

Keybindings for LSP:

- `<leader>lgd`: Go to definition
- `<leader>lgD`: Go to declaration
- `<leader>lgt`: Go to type
- `<leader>lgi`: List implementations
- `<leader>lgr`: List references
- `<leader>lH`: Document highlight
- `<leader>lS`: List document symbols
- `<leader>lwa`: Add workspace folder
- `<leader>lwr`: Remove workspace folder
- `<leader>lwl`: List workspace folders
- `<leader>lws`: List workspace symbols
- `<leader>lh`: Trigger hover
- `<leader>ls`: Signature help
- `<leader>ln`: Rename symbol
- `<leader>la`: Code action
- `<leader>lf`: Format
- `<leader>ltf`: Toggle format on save

### LSP Diagnostics

Keybindings for LSP diagnostics:

- `<leader>le`: Open diagnostic float
- `<leader>lgn`: go to next diagnostic
- `<leader>lgp`: go to previous diagnostic
