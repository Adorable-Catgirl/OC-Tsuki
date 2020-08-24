local ifile, ofile = io.open(arg[1], "rb"), io.open(arg[2], "wb")

local data = ifile:read("*a")
ifile:close()