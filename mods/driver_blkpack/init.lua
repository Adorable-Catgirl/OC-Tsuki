local function load_file(arcpath)
	local data = _ARCHIVE:fetch(arcpath)
	return load(data, "="..arcpath, "t", table.deepcopy(_G, {load_file = load_file}))
end

MOD.name = "block drivers"
MOD.authors = {"Sam"}
MOD.license = {"MIT"}

function MOD.prepare()
	return true
end

function MOD.load()
	k.addblkdev("fd", load_file("fd/init.lua")())
	k.addblkdev("hd", load_file("hd/init.lua")())
	k.addblkdev("sd", load_file("sd/init.lua")())
	k.addblkdev("rom", load_file("rom/init.lua")())
	k.addblkdev("tape", load_file("fd/init.lua")())
end

function MOD.unload()
	-- no
end