local M = {};

M.themes = {}
M.to_display = function(name)
  return (name:gsub('-', ' '):gsub('%f[%a]%a+', function(w)
    return w:sub(1,1):upper() .. w:sub(2)
  end))
end

M.build_theme_map = function()
  local map = {}
  for _, name in ipairs(vim.fn.getcompletion('', 'color')) do
    map[M.to_display(name)] = name
  end
  return map
end

M.select_theme = function ()
  local map = M.build_theme_map()
  local keys = vim.tbl_keys(map)
  table.sort(keys)

 vim.ui.select(keys, {
   prompt = "Select theme",
   format_item = function(item) return item end,
  },
  function(choice)
    if not choice then return end
    vim.cmd.colorscheme(map[choice])
  end)
end

M.setup = function(opts)
  opts = opts or {}
  vim.api.nvim_create_user_command("ThemePicker", M.select_theme, {})

  local keymap = opts.keymap or '<leader>tp'

  vim.keymap.set("n", keymap, M.select_theme, {
    desc = "Select from installed themes",
    silent = true
  })
end

return M
