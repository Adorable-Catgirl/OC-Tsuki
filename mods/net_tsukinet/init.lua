--#include "tn.lua"
--#include "dg.lua"
--#include "sk.lua"
--#include "tun.lua"

function MOD.prepare()
	return #nwu.list() > 0
end

function MOD.load()
	nwu.addstack("tsukinet", stack)
	nwu.adddatagram("tsukinet", dg)
	nwu.addsocket("tsukinet", sk)
	nwu.addtunnel("tsukinet", tun)