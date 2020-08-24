function make_tko(name, path)
	local ch = io.popen("cd "..path.."; luacomp init.lua", "r")
	local code = ch:read("*a")
	ch:close()
	if (os.execute("[[ -d "..path.."/arc ]]")) then
		make_velx("ktmp/"..name..".tko", 0xFF, code, "", "", path.."/arc")
	else
		make_velx("ktmp/"..name..".tko", 0xFF, code, "", "")
	end
end

function make_kernel()
	local ch = io.popen("cd ksrc; luacomp init.lua", "r")
	local code = ch:read("*a")
	ch:close()
	make_velx("ktzuki-"..KCONFIG.version, 0x7F, code, "", "", "ktmp")
end