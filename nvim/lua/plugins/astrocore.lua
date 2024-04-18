-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        copilot_no_tab_map = true,
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- navigate buffer tabs with `H` and `L`
        L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command

        -- toggle term on astrovim using Ctrl + \
        ["<C-\\>"] = { "<cmd>ToggleTerm direction=float<CR>i", desc = "Toggle Terminal" },

        -- Hop word when Leader + w
        ["<Leader>w"] = { "<cmd>HopWord<CR>", desc = "Hop Word" },
        ["<Leader>k"] = { "<cmd>HopWordBC<CR>", desc = "Hop Word Above" },
        ["<Leader>j"] = { "<cmd>HopWordAC<CR>", desc = "Hop Word Below" },
      },
      t = {
        -- setting a mapping to false will disable it
        ["<esc>"] = false,
        ["<C-\\>"] = { "<C-\\><C-n>:q<CR>", desc = "Hide Terminal" },
      },
      i = {
        -- toggle term on astrovim using Ctrl + \
        ["<C-\\>"] = { "<cmd>ToggleTerm direction=float<CR>", desc = "Toggle Terminal" },

        -- Accept copilot.vim using Ctrl + l
        ["<C-l>"] = {
          'copilot#Accept("\\<CR>")',
          silent = true,
          expr = true,
          script = true,
          replace_keycodes = false,
          desc = "Accept Copilot",
        },
      },
    },
  },
}