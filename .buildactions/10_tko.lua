do
	local actions = {}
	local h = io.popen("ls mods", "r")
	for l in h:lines() do
		local buildf = function()
			make_tko(l, "mods/"..l)
		end
		actions[l] = buildf
		build[l..".tko"] = buildf
	end

	function build.mods()
		for k, v in pairs(actions) do
			print("MOD", k)
			v()
		end
	end
	build[#build+1] = build.mods
end