# base64.nvim

base64.nvim provides commands for encoding and decoding base64 string implemented in pure lua. There are no 3rd-party dependencies required.

## Requirements

Neovim 0.6+ (for lua support)

## Installation

With packer:

```lua
use 'moevis/base64.nvim'
```

## Usage

Using `:Base64Encode` and `:Base64Decode` to encode or decode texts selected or under the cursor. No default mappings are provided, you can bind these commands at your convinience, here is a example:

### Vim script

```vim
nmap <silent> <leader>d :Base64Decode<cr>
vmap <silent> <leader>d :Base64Decode<cr>

nmap <silent> <leader>e :Base64Encode<cr>
vmap <silent> <leader>e :Base64Encode<cr>
```

### Lua script

```lua
vim.api.nvim_set_keymap('n', '<leader>d', ':Base64Decode', {})
vim.api.nvim_set_keymap('v', '<leader>d', ':Base64Decode', {})

vim.api.nvim_set_keymap('n', '<leader>e', ':Base64Encode', {})
vim.api.nvim_set_keymap('v', '<leader>e', ':Base64Encode', {})
```
