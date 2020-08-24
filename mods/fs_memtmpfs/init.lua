local fs = {}

MOD.name = "memtmpfs"
MOD.authors = {"Sam"}
MOD.license = {"MIT"}

function fs_create()
	return setmetatable({root={
		mode=0,
		inode=0,
		major=0,
		minor=0,
		mod=k.rtc(),
		create=k.rtc(),
		access=k.rtc(),
		meta=k.rtc(),
		children={},
		acl={},
	}}, {__index=fs})
end

function MOD.prepare()
	return true
end

function MOD.load()
	k.addfs("memtmpfs", fs_create)
	return true
end

function MOD.unload()
	k.unaddfs("memtmpfs")
end

local function fs_resolve(self, path)
	if (path == "") then
		return self.root
	end
	local parts = path:split("/")
	local node = self.root
	for i=1, #parts do
		if not is_dir(node.children[parts[i]].mode) and not i==#parts then
			return nil, "not found"
		end
		node = node.children[parts[i]]
	end
	return node
end

function fs:list(path)
	local node, e = fs_resolve(self, path)
	if not node then return nil, e end
	local paths = {}
	node.access = k.rtc()
	node.meta = k.rtc()
	for k, v in pairs(node.children) do
		paths[#paths+1] = k
	end
	return paths
end

function fs:open(file, mode)
	local node = fs_resolve(self, path)
	if node and not is_file(node.mode) then return nil, "not a file" end
	node.access = k.rtc()
	node.meta = k.rtc()
	local stream, e = k.strstream(node.data, mode)
	if not stream then return nil, e end
	stream.update = function(str)
		node.data = str
	end
	return stream
end

function fs:getacl(path)
	local node, e = fs_resolve(self, path)
	if not node then return nil, e end
	node.access = k.rtc()
	node.meta = k.rtc()
	return node.acl
end

function fs:stat(path)
	local node, e = fs_resolve(self, path)
	if not node then return nil, e end
	return {
		access = node.access,
		modify = node.mod,
		meta = node.meta,
		create = node.create,
	}
end

function fs:exists(path)
	local node, e = fs_resolve(self, path)
	return not not node
end

function fs:mkdir(path)
	local parts = path:split("/")
	local last = parts[#parts]
	local rpath = path:sub(1, #path-(#last+1))
	local node, e = fs_resolve(self, rpath)
	if not node then return nil, e end
	rpath.children[last] = {
		mode=0,
		inode=0,
		major=0,
		minor=0,
		mod=k.rtc(),
		create=k.rtc(),
		access=k.rtc(),
		meta=k.rtc(),
		children={},
		acl={},
	}
end

function fs:remove(path)
	local node, e = fs_resolve(self, path)
	if not node then return nil, e end
	if is_dir(node.mode) then
		if (pairs(node.mode)()) then
			return nil, "directory not empty"
		end
	end
	local parts = path:split("/")
	local last = parts[#parts]
	local rpath = path:sub(1, #path-(#last+1))
	local node, e = fs_resolve(self, rpath)
	node.children[last] = nil
end

function fs:getattr(path)
	local node, e = fs_resolve(self, path)
	if not node then return nil, e end
	return node.attr
end

function fs:setattr(path, attr)
	local node, e = fs_resolve(self, path)
	if not node then return nil, e end
	node.attr = attr
end

function fs:getxattr(path, xattr)
	local node, e = fs_resolve(self, path)
	if not node then return nil, e end
	return node.xattr[xattr]
end

function fs:setxattr(path, xattr, val)
	local node, e = fs_resolve(self, path)
	if not node then return nil, e end
	node.xattr[xattr] = val
end