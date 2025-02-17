--[[
	mutex class
]]
local mutex = {}

export type mutex = {
	locked: boolean,
	connect: BindableEvent,
	
	lock: (self: mutex)->nil,

	unlock: (self: mutex)->nil,

	wait: (self: mutex)->nil,
	
	Destroy: (self: mutex)->nil
}

--[[
	Lock mutex
]]
function mutex.lock(self: mutex)
	self.locked = true
end

--[[
	Unlock mutex
]]
function mutex.unlock(self: mutex)
	self.locked = false
	self.connect:Fire()
end

--[[
	Wait if locked
]]
function mutex.wait(self: mutex)
	if self.locked then
		self.connect.Event:Wait()
	end
end

--[[
	Destroy mutex
]]
function mutex.Destroy(self: mutex)
	self.connect:Destroy()
end

--[[
	mutex constructor
]]
function mutex.new(lock: boolean?): mutex
	return {
		locked = lock or false,
		connect = Instance.new("BindableEvent"),
		lock = mutex.lock,
		unlock = mutex.unlock,
		wait = mutex.wait,
		Destroy = mutex.Destroy
	}
end

return mutex
