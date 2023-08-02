require("toggleterm").setup()

local TigTerm  = require('toggleterm.terminal').Terminal
local tig = TigTerm:new {
  cmd = "source ~/.ssh/agent-environment; tig", -- command to execute when creating the terminal e.g. 'top'
  direction = "tab", -- the layout for the terminal, same as the main config options
  hidden = true,
  -- dir = string, -- the directory for the terminal
  close_on_exit = true, -- close the terminal window when the process exits
  -- highlights = table, -- a table with highlights
  -- env = table, -- key:value table with environmental variables passed to jobstart()
  -- clear_env = bool, -- use only environmental variables from `env`, passed to jobstart()
  auto_scroll = false, -- automatically scroll to the bottom on terminal output
}

function tig_toggle()
  tig:toggle()
end

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*", -- disable spellchecking in the embeded terminal
  command = "setlocal nospell",
})
