local vim = vim
local api = vim.api

function try_catch(what)
	local status, result = pcall(what.try)
	if not status then
		what.catch(result)
	end
	return result
end

local M = {}
function M.replace_termcodes(str)
    return api.nvim_replace_termcodes(str, true, true, true)
end

return M
