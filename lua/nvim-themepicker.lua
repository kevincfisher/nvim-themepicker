local M = {};

M.say_hello = function ()
 vim.ui.select({}, {
   prompt = "Select theme"
  },
  function(choice)
    vim.cmd("colorscheme"..choice)
  end)
end

M.setup = function(opts)
  opts = opts or {}

  vim.api.nvim_create_user_command("ThemePicker", M.say_hello, {})

  local keymap = opts.keymap or '<leader>ct'

  vim.keymap.set("n", keymap, M.say_hello, {
    desc = "Select from installed themes",
    silent = true
  })
end

return M
