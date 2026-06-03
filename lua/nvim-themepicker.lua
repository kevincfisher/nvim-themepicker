local M = {};

M.themes = {}

M.load_themes = function ()
  local loaded_themes = vim.fn.getcompletion('','color')
  for _,v in ipairs(loaded_themes) do
    table.insert(M.themes, v)
  end
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

  local keymap = opts.keymap or '<leader>tp'

  vim.keymap.set("n", keymap, M.select_theme, {
    desc = "Select from installed themes",
    silent = true
  })
end

return M
