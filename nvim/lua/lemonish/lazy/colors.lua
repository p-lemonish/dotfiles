return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      local current_mode = "dark"

      local function apply_catppuccin(mode)
        local flavor = mode == "light" and "latte" or "mocha"

        require("catppuccin").setup({
          flavor = flavor,
          color_overrides = {
            mocha = {
              rosewater = "#ea6962",
              flamingo = "#ea6962",
              red = "#ea6962",
              maroon = "#ea6962",
              pink = "#d3869b",
              mauve = "#d3869b",
              peach = "#e78a4e",
              yellow = "#d8a657",
              green = "#a9b665",
              teal = "#89b482",
              sky = "#89b482",
              sapphire = "#89b482",
              blue = "#7daea3",
              lavender = "#7daea3",
              text = "#ebdbb2",
              subtext1 = "#d5c4a1",
              subtext0 = "#bdae93",
              overlay2 = "#a89984",
              overlay1 = "#928374",
              overlay0 = "#595959",
              surface2 = "#4d4d4d",
              surface1 = "#404040",
              surface0 = "#292929",
              base = "#000000",
              mantle = "#000000",
              crust = "#000000",
            },
          },
        })

        vim.o.background = mode == "light" and "light" or "dark"
        vim.cmd.colorscheme("catppuccin")
        current_mode = mode
      end

      apply_catppuccin("dark")

      vim.api.nvim_create_user_command("ToggleTheme", function()
        apply_catppuccin(current_mode == "dark" and "light" or "dark")
      end, {})
    end,
  },
}
