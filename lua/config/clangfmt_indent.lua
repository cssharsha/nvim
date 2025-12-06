-- ~/.config/nvim/lua/config/clangfmt_indent.lua
-- Sync Vim indent options with nearest .clang-format for C/C++ buffers

local M = {}

local function parse_yaml_value(line, key)
  -- Extract simple scalar values like: key: value
  local pattern = "^%s*" .. key .. "%s*:%s*(.-)%s*$"
  local val = line:match(pattern)
  if not val then
    return nil
  end
  -- strip quotes
  val = val:gsub('^"(.*)"$', '%1')
  val = val:gsub("^'(.*)'$", '%1')
  return val
end

local function parse_dump_config(text)
  local out = {}
  for line in text:gmatch("[^\n]+") do
    local iw = parse_yaml_value(line, "IndentWidth")
    if iw and tonumber(iw) then
      out.indent_width = tonumber(iw)
    end
    local tw = parse_yaml_value(line, "TabWidth")
    if tw and tonumber(tw) then
      out.tab_width = tonumber(tw)
    end
    local ut = parse_yaml_value(line, "UseTab")
    if ut then
      out.use_tab = ut
    end
  end
  return out
end

local function read_file(path)
  local ok, data = pcall(vim.fn.readfile, path)
  if not ok or not data then
    return nil
  end
  return table.concat(data, "\n")
end

local function find_clang_format(startpath)
  local dir = startpath
  local found = vim.fs.find({ ".clang-format", "_clang-format" }, {
    upward = true,
    path = dir,
  })
  if found and #found > 0 then
    return found[1]
  end
  return nil
end

local function get_opts_from_clang_format(cfg_path)
  local cfg_dir = vim.fs.dirname(cfg_path)
  local have_cf = vim.fn.executable("clang-format") == 1

  if have_cf and vim.system then
    local res = vim.system({ "clang-format", "-style=file", "-dump-config" }, { text = true, cwd = cfg_dir }):wait()
    if res and res.code == 0 and res.stdout then
      return parse_dump_config(res.stdout)
    end
  end

  -- Fallback to systemlist if vim.system is unavailable
  if have_cf and vim.fn.has("nvim-0.11") == 0 then
    local cmd = string.format("cd %s && clang-format -style=file -dump-config", vim.fn.shellescape(cfg_dir))
    local lines = vim.fn.systemlist(cmd)
    if vim.v.shell_error == 0 and type(lines) == "table" then
      return parse_dump_config(table.concat(lines, "\n"))
    end
  end

  -- Final fallback: parse the file directly (best-effort)
  local text = read_file(cfg_path)
  if text then
    return parse_dump_config(text)
  end
  return {}
end

local function apply_opts(bufnr, opts)
  local sw = tonumber(opts.indent_width) or 4
  local ts = tonumber(opts.tab_width) or sw
  local ut = tostring(opts.use_tab or "Never")

  -- Map UseTab to expandtab boolean
  -- Never / AlignWithSpaces -> expandtab=true
  -- Always / ForIndentation -> expandtab=false
  local expand
  if ut == "Always" or ut == "ForIndentation" then
    expand = false
  else
    expand = true
  end

  vim.bo[bufnr].shiftwidth = sw
  vim.bo[bufnr].tabstop = ts
  vim.bo[bufnr].softtabstop = sw
  vim.bo[bufnr].expandtab = expand

  vim.b[bufnr].clangfmt_indent_applied = true
end

local function sync_indent(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == "" then
    return
  end
  local startpath = vim.fs.dirname(name)
  local cfg = find_clang_format(startpath)
  if not cfg then
    return
  end
  local opts = get_opts_from_clang_format(cfg)
  apply_opts(bufnr, opts)
end

function M.setup()
  local group = vim.api.nvim_create_augroup("clangfmt-indent-sync", { clear = true })
  vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
    group = group,
    pattern = {
      "*.c", "*.h", "*.cpp", "*.hpp", "*.cc", "*.hh", "*.cxx", "*.ixx",
      "*.m", "*.mm",
    },
    callback = function(args)
      pcall(sync_indent, args.buf)
    end,
  })
  -- Also handle filetype event when pattern misses extension
  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = group,
    pattern = { "c", "cpp", "objc", "objcpp" },
    callback = function(args)
      pcall(sync_indent, args.buf)
    end,
  })
end

return M

