local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
                "git",
                "clone",
                "--filter=blob:none",
                "https://github.com/folke/lazy.nvim.git",
                "--branch=stable",
                lazypath,
        })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
        {
                "nvim-neo-tree/neo-tree.nvim",
                branch = "v3.x",
                dependencies = {
                        "nvim-lua/plenary.nvim",
                        "nvim-tree/nvim-web-devicons",
                        "MunifTanjim/nui.nvim"
                }
        },
        {
                "folke/tokyonight.nvim"
        },
	{
		"boredcoder411/make.nvim"
	},
	{
		"neovim/nvim-lspconfig"
	},
	{
		"hrsh7th/nvim-cmp"
	},
	{
		"hrsh7th/cmp-nvim-lsp"
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true
	}
})

require("neo-tree").setup {
        filesystem = {
                filtered_items = {
                        visible = true
                }
        }
}

require("make").setup({})

local lspconfig = require("lspconfig")

local on_attach = function(client)
    require'completion'.on_attach(client)
end

lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			assist = {
				importGranularity = 'module',
				importPrefix = 'self'
			},
			diagnostics = {
				enable = true
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
				loadOutDirsFromCheck = true
			},
			procMacro = {
				enable = true
			},
			inlayHints = {
				chainingHints = true,
				parameterHints = true,
				typeHints = true,
				bindingModeHints = {
					enable = true
				}
			}
		}
	}
})

local cmp = require("cmp")
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

--cmp.setup({
--    snippet = {
--        expand = function(args)
--            vim.fn['vsnip#anonymous'](args.body)
--        end,
--    },
--    mapping = {
--        ['<C-Space>'] = cmp.mapping.complete(),
--        ['<CR>'] = cmp.mapping.confirm({ select = true }),
--    },
--    sources = {
--        { name = 'nvim_lsp' },
--        { name = 'buffer' },
--        { name = 'vsnip' },
--    },
--})

cmp.setup({
  preselect = cmp.PreselectMode.None,
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },

  -- Installed sources
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
    { name = "path" },
    { name = "buffer" },
  },
})

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

vim.cmd[[ set number ]]
vim.cmd[[ set background=dark ]]
vim.cmd[[ colorscheme tokyonight-moon ]]
vim.cmd[[ Neotree ]]
vim.api.nvim_set_keymap('n', '<F8>', ':Neotree toggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'mk', ':MakePanel<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'cb', ':!cargo build<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'cr', ':!cargo run<CR>', { noremap = true, silent = true })
