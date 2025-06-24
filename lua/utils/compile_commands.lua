local M = {}

local uv = vim.loop
local json = vim.fn.json_decode
local json_encode = vim.fn.json_encode

function M.find_all_compile_commands(root)
  local results = {}
  local function scan_dir(dir)
    local handle = uv.fs_scandir(dir)
    if not handle then return end
    while true do
      local name, type = uv.fs_scandir_next(handle)
      if not name then break end
      local fullpath = dir .. "/" .. name
      if type == "directory" then
        scan_dir(fullpath)
      elseif type == "file" and name == "compile_commands.json" then
        table.insert(results, fullpath)
      end
    end
  end
  scan_dir(root)
  return results
end

function M.merge_compile_commands(files)
  local merged = {}
  for _, file in ipairs(files) do
    local fd = io.open(file, "r")
    if fd then
      local content = fd:read("*a")
      fd:close()
      local data = json(content)
      if data then
        for _, entry in ipairs(data) do
          table.insert(merged, entry)
        end
      end
    end
  end
  return merged
end

function M.write_merged_compile_commands(merged, tmpfile)
  local fd = io.open(tmpfile, "w")
  if not fd then
    vim.notify("Failed to open temp file for merged compile_commands", vim.log.levels.ERROR)
    return
  end
  fd:write(json_encode(merged))
  fd:close()
end

function M.get_merged_compile_commands_file(root)
  local tmpfile = root .. "/compile_commands_merged.json"
  local files = M.find_all_compile_commands(root .. "/build")
  if #files == 0 then
    return nil
  end
  local merged = M.merge_compile_commands(files)
  M.write_merged_compile_commands(merged, tmpfile)
  return tmpfile
end

return M
