--!nocheck

--[[
	mutex class
]]
local mutex = {}
mutex.__index = mutex

--[[
	mutex struct
]]
export type Mutex = {
	--[[
		Now is locked
	]]
	locked: boolean,

	connect: BindableEvent,
} & typeof(mutex)

--[[
	Lock mutex
]]
function mutex.lock (self: Mutex)
	self.locked = true
end

--[[
	Unlock mutex
]]
function mutex.unlock (self: Mutex)
	self.locked = false
	self.connect:Fire()
end

--[[
	Wait if locked
]]
function mutex.wait (self: Mutex)
	if self.locked then
		self.connect.Event:Wait()
	end
end

--[[
	Destroy mutex
]]
function mutex.Destroy (self: Mutex)
	self.connect:Destroy()
end

--[[
	mutex constructor

	by default is unlocked
]]
function mutex.new (lock: boolean?): Mutex
	return setmetatable({
		locked = lock or false,
		connect = Instance.new("BindableEvent"),
	}, { __index = mutex })
end

return mutex
