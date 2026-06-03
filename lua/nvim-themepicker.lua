local M = {};

M.themes = {}

M.load_themes = function ()
  local loaded_themes = vim.fn.getcompletion('','color')
  themes.tbl_extend(loaded_themes)
end

M.select_theme = function ()
 vim.ui.select(M.themes, {
   prompt = "Select theme"
  },
  function(choice)
    vim.cmd("colorscheme "..choice)
  end)
end

M.setup = function(opts)
  opts = opts or {}
  M.load_themes()
  vim.api.nvim_create_user_command("ThemePicker", M.select_theme, {})

  local keymap = opts.keymap or '<leader>ct'

  vim.keymap.set("n", keymap, M.select_theme, {
    desc = "Select from installed themes",
    silent = true
  })
end

return M
