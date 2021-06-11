local scandir = require('plenary.scandir')

local NOTES_DIR = os.getenv("HOME") .. '/notes'

local M = {}

function M.openAll()
  local all_notes = scandir.scan_dir(NOTES_DIR)
  local todo_files = {}
  for key, value in pairs(all_notes) do
    if (value:find(NOTES_DIR .. "/todo.*%.txt")) then
      vim.api.nvim_command("edit " .. value)
    end
  end
end

return M
