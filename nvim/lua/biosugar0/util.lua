function try_catch(what)
	local status, result = pcall(what.try)
	if not status then
		what.catch(result)
	end
	return result
end
