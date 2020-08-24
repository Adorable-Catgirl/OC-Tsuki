build = {}
function build.all()
	for i=1, #build do
		build[i]()
	end
end
local h = io.popen("ls .buildactions", "r")
for l in h:lines() do
	dofile(".buildactions/"..l)
end
if not arg[1] then
	build.all()
elseif build[arg[1]] then
	build[arg[1]]()
else
	io.stderr:write("no target "..arg[1]..".\n")
end