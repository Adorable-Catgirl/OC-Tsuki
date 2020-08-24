function struct(tbl)
	local pat = tbl.endian or "="
	local args = {}
	for i=1, do
		local a, b = pairs(tbl[i])
		local k, v = a(b)
		args[i] = k
		pat = pat .. v
	end
	return setmetatable({}, {__call=function(_, arg)
		checkArg(1, arg, "string", "table")
		if (type(arg) == "string") then
			local sval = {string.unpack(pat, arg)}
			local rtn = {}
			for i=1, #args do
				rtn[args[i]] = sval[i]
			end
			return rtn, sval[#sval]
		elseif (type(arg) == "table") then
			local sval = {}
			for i=1, #args do
				sval[i] = arg[args[i]]
			end
			return string.pack(pat, unpack(sval))
		end
	end, __len=function()
		return string.packsize(pat)
	end})
end