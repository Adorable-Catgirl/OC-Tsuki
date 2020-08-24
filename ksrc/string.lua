---@namespace string "String"
---@type strings "Lua's native string type."

local _str = {}
for k, v in pairs(string) do
	_str[k] = v
end

string = setmetatable({}, {__index=function(self, index)
	checkArg(1, index, "number", "string")
	if (type(index) == "number") then
		return _str.sub(self, index, index)
	elseif (type(index) == "string") then
		return _str[k]
	end
end})

function _str:split()

end

function _str:trim()

end

---@desc "Like gmatch but with find!"
---@arg haystack string "String to search for."
---@arg needle string "Pattern to find"
---@arg start? number "Start position. Defaults to 1."
---@arg raw? boolean "True to not use patterns. Defaults to false."
---@return "iterator(number, number)" "Iterator for use in a"
function _str.gfind(haystack, needle, start, raw)
	start = start or 1
	return function()
		local s, e = _str.find(haystack, needle, start, raw)
		start = (s or 0)+1
		return s, e
	end
end

function _str.trim(self)
	return self:gsub("^%s+", ""):gsub("%s+$", "")
end

function _str.explode(self, pat)
	local t, ll
	t={}
	ll=0
	if(#p == 1) then
		return {p}
	end
	while true do
		l = string.find(self, pat, ll, true) -- find the next d in the string
		if l ~= nil then -- if "not not" found then..
			table.insert(t, string.sub(self,ll,l-1)) -- Save it in our array.
			ll = l + 1 -- save just after where we found it for searching next time.
		else
			table.insert(t, string.sub(self,ll)) -- Save what's left in our array.
			break -- Break at end, as it should be, according to the lua manual.
		end
	end
	return t
end