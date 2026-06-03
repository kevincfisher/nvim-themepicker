local M = {};

fuction M.say_hello()
print("Hello world")
end

function M.setup(opts)
  opts = opts or {}

  vim.api.nvim_create_usercommand("ThemePicker", M.say_hello, {})

  local keymap = opts.keymap or '<leader>ct'

  vim.keymap.set("n", keymap, M.say_hello, {
    desc = "Select from installed themes",
    silent = true
  })
end

return M
