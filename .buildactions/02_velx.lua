function make_velx(output, osid, code, data, signature, arcpath)
	local f = io.open(output, "w")
	f:write("\27VelX\1\1\x53"..string.char(osid))
	local zcode = lzss.compress(code)
	if (arcpath) then
		f:write("tsar")
	else
		f:write("\0\0\0\0")
	end
	f:write((string.pack("<I3", #zcode)))
	f:write((string.pack("<I3", #data)))
	f:write((string.pack("<I3", #signature)))
	local ah = io.popen("cd "..arcpath.."; find $(ls) -depth | tsar -o", "r")
	local arc = ah:read("*a")
	ah:close()
	f:write((string.pack("<I4", #arc)))
	f:write(zcode, data, signature, arc)
	f:close()
end
