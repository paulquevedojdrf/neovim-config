local M = {}
local DEBUG = false

local function debug_print(msg)
  if DEBUG then
    print(msg)
  end
end

-- Function to find all compile_commands.json files under build directory
local function find_all_compile_commands(build_dir)
  local files = {}
  local handle = io.popen("find " .. build_dir .. " -name 'compile_commands.json' 2>/dev/null")
  if handle then
    for line in handle:lines() do
      table.insert(files, line)
    end
    handle:close()
  end
  return files
end

-- Function to select best compile_commands.json based on current file and priority
local function select_compile_commands(build_dir)
  local current_file = vim.api.nvim_buf_get_name(0)
  local all_files = find_all_compile_commands(build_dir)

  debug_print("Found compile_commands.json files:")
  for _, file in ipairs(all_files) do
    debug_print("  " .. file)
  end

  -- If only one file, use it
  if #all_files == 1 then
    debug_print("Only one compile_commands.json found, using: " .. all_files[1])
    return vim.fn.fnamemodify(all_files[1], ":h")
  end

  if #all_files == 0 then
    debug_print("No compile_commands.json files found in " .. build_dir)
    return build_dir
  end

  -- Priority 1a: test/tests files prefer 'ut'
  debug_print("current_file: " .. current_file)
  if current_file:match("/test/") or current_file:match("/tests/") then
    debug_print("matched test")
    for _, file in ipairs(all_files) do
      if file:match("/ut/") then
        debug_print("Test file detected, using ut variant: " .. file)
        return vim.fn.fnamemodify(file, ":h")
      end
    end
  end

  -- Priority 1b: sim/simulation files prefer 'simulation'
  if current_file:match("/sim/") or current_file:match("/simulation/") then
    for _, file in ipairs(all_files) do
      if file:match("/simulation/") then
        debug_print("Simulation file detected, using simulation variant: " .. file)
        return vim.fn.fnamemodify(file, ":h")
      end
    end
  end

  -- Priority 2: prefer 'cppcheck'
  for _, file in ipairs(all_files) do
    if file:match("/cppcheck/") then
      debug_print("Using cppcheck variant: " .. file)
      return vim.fn.fnamemodify(file, ":h")
    end
  end

  -- Priority 3: prefer 'DEBUG'
  for _, file in ipairs(all_files) do
    if file:match("/DEBUG/") then
      debug_print("Using DEBUG variant: " .. file)
      return vim.fn.fnamemodify(file, ":h")
    end
  end

  -- Fallback: use first available
  debug_print("Using fallback (first available): " .. all_files[1])
  return vim.fn.fnamemodify(all_files[1], ":h")
end

-- function to get compile commands directory
local function _get_compile_commands_dir()
  debug_print("Current file: " .. vim.api.nvim_buf_get_name(0))

  -- Try west topdir first
  local west_handle = io.popen("west topdir 2>/dev/null")
  if west_handle then
    local west_topdir = west_handle:read("*a"):gsub("\n", "")
    west_handle:close()

    if west_topdir and west_topdir ~= "" then
      local west_build_dir = west_topdir .. "/build"
      debug_print("West topdir found: " .. west_topdir)
      if vim.fn.isdirectory(west_build_dir) == 1 then
        return select_compile_commands(west_build_dir)
      end
    end
  end

  -- Fallback to git root
  local git_handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
  if git_handle then
    local git_root = git_handle:read("*a"):gsub("\n", "")
    git_handle:close()

    if git_root and git_root ~= "" then
      local git_build_dir = git_root .. "/build"
      debug_print("Git root found: " .. git_root)
      if vim.fn.isdirectory(git_build_dir) == 1 then
        return select_compile_commands(git_build_dir)
      end
    end
  end

  -- Final fallback to current directory
  local cwd_build_dir = vim.fn.getcwd() .. "/build"
  debug_print("Using current working directory build: " .. cwd_build_dir)
  if vim.fn.isdirectory(cwd_build_dir) == 1 then
    return select_compile_commands(cwd_build_dir)
  else
    return cwd_build_dir
  end
end

-- Main entrypoint
function M.get_compile_commands_dir()
  local compile_commands_dir = _get_compile_commands_dir()
  local compile_commands_file = compile_commands_dir .. "/compile_commands.json"

  if vim.fn.filereadable(compile_commands_file) == 1 then
    debug_print("✓ Found compile_commands.json at: " .. compile_commands_file)
  else
    debug_print("✗ compile_commands.json NOT found at: " .. compile_commands_file)
  end

  return compile_commands_dir
end


return M
