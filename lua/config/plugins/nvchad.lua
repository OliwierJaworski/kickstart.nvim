return {
  "NvChad/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup({
      user_default_options = {
        names = false,          -- no named colors like 'red'
        css = true,
        css_fn = true,
        mode = "background",    -- shows color as background
      }
    })
  end
}
