local M = {}

function M.list_concat(arys)
	local tbl = {}
	for _, ary in ipairs(arys) do
		vim.list_extend(tbl, ary)
	end
	return tbl
end

-- Usage:
--   local variable = 'var'
--   let('g:foo.bar', variable)
function M.let(path, obj)
	vim.g["LuaTemp"] = obj
	vim.cmd(([[
    if exists('g:LuaTemp')
      let %s = g:LuaTemp
      unlet g:LuaTemp
    else
      silent! unlet %s
    endif
  ]]):format(path, path))
end

local api = vim.api

function M.try_catch(what)
	local status, result = pcall(what.try)
	if not status then
		what.catch(result)
	end
	return result
end

function M.replace_termcodes(str)
	return api.nvim_replace_termcodes(str, true, true, true)
end

return M
