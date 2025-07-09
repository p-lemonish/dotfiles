return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "j-hui/fidget.nvim",
    {
      "hrsh7th/nvim-cmp",
      config = function()
        require 'cmp'.setup {
          snippet = {
            expand = function(args)
              require 'luasnip'.lsp_expand(args.body)
            end
          },
          sources = {
            { name = 'luasnip' },
          },
        }
      end
    },
  },

  config = function()
    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")
    local luasnip = require("luasnip")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    require("fidget").setup({})

    -- Auto format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm({
                select = true,
              })
            end
          else
            fallback()
          end
        end),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
      })
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        --"ruby_lsp", -- must do apt install gem and apt install ruby-dev, then do gem install ruby-lsp.
        "lua_ls",
        "pyright",
        "clangd",
        "rust_analyzer",
        "terraformls",
        "ts_ls",
        "gopls",
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities
          }
        end,
      },

      require("conform").setup({
        formatters_by_ft = {
          lua             = { "stylua" },
          python          = { "black" },
          markdown        = { "trim_whitespace" },
          javascript      = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          typescript      = { "prettier" },
          html            = { "prettier" },
          terraform       = { "terraform_fmt" },
          ruby            = { "rubocop" },
          go              = { "gofmt" },
        },
      })
    })
  end
}
