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

M.close_buffer_keep_window = function()
  local bufnr = vim.fn.bufnr()
  if vim.fn.winnr("$") > 1 then
    vim.cmd("enew")
    vim.cmd("bp")
    vim.cmd("bd" .. bufnr)
  else
    vim.cmd("bd")
  end
end

return M
