local M = {}

M.expand_symlink = function(path)
  local handle, err = io.popen("readlink -f '" .. path .. "'")
  if not handle then
    return nil, "Failed to open pipe command: " .. (err or "Unknown error")
  end

  local result, read_err = handle:read("*a")
  if not result then
    return nil, "Failed to read from pipe: " .. (read_err or "Unknown error")
  end

  local success, close_err = handle:close()
  if not success then
    return nil, "Failed to close handle: " .. (close_err or "Unknown error")
  end

  return string.gsub(result, "\n$", "")
end

-- Useful for setting bazel-<dir> directory in gopls config
M.get_current_dir_name = function()
  local fullPath = vim.fn.getcwd()
  local match = fullPath:match("^.+/(.+)$")
  return match
end

-- this is broken
M.close_buffer_keep_window = function()
  local bufnr = vim.fn.bufnr()
  if vim.fn.winnr("$") > 1 then
    local prev_bufnr = vim.fn.bufnr("#-1")
    print(prev_bufnr)
    vim.cmd("w")
    vim.cmd("bp")
    vim.cmd("bd" .. bufnr)
  else
    vim.cmd("w")
    vim.cmd("bd")
  end
end -- utils.lua

M.switch_to_buffer = function()
  local bufnr = vim.fn.input("Buffer number: ")
  if bufnr ~= "" then
    vim.cmd("buffer " .. bufnr)
  end
end

M.open_diagnostics_in_qf = function()
  local diagnostics = vim.diagnostic.get()
  local qflist = {}
  for _, diagnostic in ipairs(diagnostics) do
    local item = {
      bufnr = diagnostic.bufnr,
      lnum = diagnostic.lnum + 1,
      col = diagnostic.col + 1,
      text = diagnostic.message,
      type = diagnostic.severity == vim.diagnostic.severity.ERROR and 'E' or 'W',
    }
    table.insert(qflist, item)
  end
  vim.fn.setqflist(qflist, 'r')
  vim.cmd('copen')
end

return M

-- M.close_buffer_keep_window = function()
--   local bufnr = vim.fn.bufnr()
--
--   local fallback_buf_id = function(current_bufnr)
--     local current = nil
--
--     for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
--       if vim.api.nvim_buf_is_loaded(buf_id) and buf_id ~= current_bufnr then
--         current = buf_id
--       end
--     end
--
--     return current
--   end
--
--   if vim.fn.winnr("$") > 1 then
--     print("b" .. fallback_buf_id(bufnr))
--     vim.cmd("b" .. fallback_buf_id(bufnr))
--     vim.cmd("bd" .. bufnr)
--   else
--     vim.cmd("bd")
--   end
-- end
