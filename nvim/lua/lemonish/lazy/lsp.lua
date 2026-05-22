return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",

    "L3MON4D3/LuaSnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local luasnip = require("luasnip")

    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    require("fidget").setup({})

    -- Completion
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            if luasnip.expandable() then
              luasnip.expand()
            else
              cmp.confirm({ select = true })
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
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
    })

    -- Diagnostics UI
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Formatting
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "ruff_format" },
        markdown = { "trim_whitespace" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        terraform = { "terraform_fmt" },
        ruby = { "rubocop" },
        go = { "gofmt" },
      },
    })

    -- Auto format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        if vim.bo[args.buf].filetype == "python" then
          local lines = table.concat(vim.api.nvim_buf_get_lines(args.buf, 0, 50, false), "\n")
          if lines:match("from%s+pwn%s+import%s+%*") or lines:match("import%s+pwn") then
            return
          end
        end
        require("conform").format({
          bufnr = args.buf,
          lsp_fallback = true,
        })
      end,
    })

    local servers = {
      "lua_ls",
      "basedpyright",
      "ruff",
      "clangd",
      "rust_analyzer",
      "terraformls",
      "ts_ls",
      "gopls",
    }

    for _, server in ipairs(servers) do
      vim.lsp.config(server, {
        capabilities = capabilities,
      })
    end

    -- Lua / Neovim config
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    vim.lsp.config("basedpyright", {
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = "basic",
            diagnosticMode = "openFilesOnly",
            diagnosticSeverityOverrides = {
              reportWildcardImportFromLibrary = "none",
              reportUnusedImport = "none",
              reportUnusedVariable = "none",
              reportUnusedFunction = "warning",
            },
          },
        },
      },
    })

    -- Add more ignores here if needed
    vim.lsp.config("ruff", {
      init_options = {
        settings = {
          lint = {
            select = { "E", "F", "I", "UP", "B" },
            ignore = {
              "F403",
              "E501",
              "F405",
              "I001",
            },
          },
        },
      },
    })

    require("mason").setup()

    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_enable = {
        exclude = { "pyright" },
      },
    })
  end,
}
