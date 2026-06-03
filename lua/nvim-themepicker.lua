local M = {};

M.themes = {}

M.load_themes = function ()
  local loaded_themes = vim.fn.getcompletion('','color')
  for _,v in ipairs(loaded_themes) do
    local display_str = string.gsub(v, "-", " ")
    print('[nvim-themepicker] display_str: ' .. display_str)
    local theme_type = "builtin"
    local item = { v = string.format("%s\t[%s]", display_str, theme_type)}
    table.insert(M.themes, item)
    print(M.themes.tostring())
  end
end

M.select_theme = function ()
 vim.ui.select(M.themes, {
   prompt = "Select theme",
   format_item = function(item, i)
     M.themes.tostring()
   end
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
