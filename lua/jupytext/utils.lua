local M = {}

local language_extensions = {
  python = "py",
  julia = "jl",
  r = "r",
  R = "r",
  bash = "sh",
}

local language_names = {
  python3 = "python",
}

M.get_ipynb_metadata = function(filename)
  local metadata = vim.json.decode(io.open(filename, "r"):read "a")["metadata"]
  local language = metadata.kernelspec.language
  if language == nil then
    language = language_names[metadata.kernelspec.name]
  end
  local extension = language_extensions[language]

  return { language = language, extension = extension }
end

M.get_jupytext_file = function(filename, extension)
  local fn = vim.fn.fnamemodify(filename, ":t")
  local path = vim.fn.fnamemodify(filename, ":h")
  local fileroot = vim.fn.fnamemodify(path .. "/." .. fn, ":r")
  return fileroot .. "." .. extension
end

M.check_key = function(tbl, key)
  for tbl_key, _ in pairs(tbl) do
    if tbl_key == key then
      return true
    end
  end

  return false
end

return M
