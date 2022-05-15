set shell=fish
set statusline+=%F

set number
set list
set shiftwidth=2
set autoindent
set smartindent
set expandtab
set encoding=utf-8
set fileencoding=utf-8
set cursorline
set showmode
set title
set laststatus=2
set ai
set si
set clipboard+=unnamed

syntax enable
filetype plugin indent on

if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
  set background=dark
 " Use NeoSolarized
  let g:neosolarized_termtrans=1
  runtime ./colors/NeoSolarized.vim
  colorscheme NeoSolarized
endif

"move buffers
map <C-h> :bprev<CR>
map <C-l> :bnext<CR>


call plug#begin('~/.local/share/nvim/plugged')

Plug 'overcache/NeoSolarized'
Plug 'cohama/lexima.vim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lualine/lualine.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'williamboman/nvim-lsp-installer'
Plug 'preservim/nerdtree'
Plug 'prettier/vim-prettier', {'do': 'yarn install'}
Plug 'windwp/nvim-ts-autotag'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


Plug 'prabirshrestha/vim-lsp'
"Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

Plug 'psf/black', { 'branch': 'stable' }

call plug#end()

set completeopt=menu,menuone,noselect

lua <<EOF
local nvim_lsp = require('lspconfig')
local protocol = require('vim.lsp.protocol')
EOF

au BufNewFile,BufRead *.fish set filetype=fish
let g:fern#default_hidden = 1

"Prettier
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat = 1


lua <<EOF
  require('nvim-lsp-installer').setup{}
EOF


"split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
nmap sc :close<Return><C-w>w


"Telescope shortcut
nnoremap <silent> ;f <Cmd>Telescope find_files<CR>
nnoremap <silent> ;r <Cmd>Telescope live_grep<CR>
nnoremap <silent> \\ <Cmd>Telescope buffers<CR>
nnoremap <silent> ;; <Cmd>Telescope help_tags<CR>  
"NERDTree shortcut
nnoremap <c-n> :NERDTree<CR>
nnoremap <c-t> :NERDTreeToggle<CR>
nnoremap <c-f> :NERDTreeFind<CR>
nnoremap <leader>n :NERDTreeFocus<CR>


lua <<EOF
local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    mappings = {
        n ={
           ["q"] = actions.close
        }, 
    },
  },
}
EOF



" vim airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='solarized_flood'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_section_c = '%F'





" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)



" Tab / indent
nnoremap <Tab> >>_
nnoremap <S-Tab> << 

" nvim-cmp
lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
       completion = cmp.config.window.bordered(),
       documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })


  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig').tsserver.setup {
    capabilities = capabilities
  }

  require('lspconfig').html.setup {
    capabilities = capabilities
  }

  require('lspconfig').pyright.setup {
    capabilities = capabilities
  }


--  require'lspconfig'.motoko.setup{
--    cmd = {"dfx", "_language-service"},
--    settings = {
--    },
--    capabilities = capabilities,
--  }



EOF


"lsp keymaps
lua <<EOF

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  

  local opts = { noremap=true, silent=true }
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format{async=true}()<CR>", opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'tsserver', 'html', 'cssls' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end


require'nvim-treesitter.configs'.setup {
  ensure_installed = {"vim", "lua", "javascript", "python", "html", "css", "typescript"},
  highlight = {
    enable = true,
    },
  autotag = {
    enable = true,
    },
}
EOF


