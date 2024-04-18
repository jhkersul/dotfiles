return {
  {
    "nvim-neotest/neotest",
    dependencies = { "weilbith/neotest-gradle" },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-gradle",
        },
      }
    end,
  },
}
