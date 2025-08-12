local mutex = require(script.Parent.mutex)

local threadSafeValue = {}

export type ThreadSafeValueStruct<T> = {
	Mutex: mutex.Mutex,
	Value: T,
}

export type ThreadSafeValue<T> = typeof(setmetatable(
	{} :: ThreadSafeValueStruct<T>,
	{ __index = threadSafeValue }
))

--[[

]]
function threadSafeValue.SetValue <T>(self: ThreadSafeValue<T>, NewValue)
	self.Mutex:wait()
	self.Mutex:lock()

	self.Value = NewValue

	self.Mutex:unlock()
end

--[[

]]
function threadSafeValue.GetValue <T>(self: ThreadSafeValue<T>): T
	return self.Value
end

--[[

]]
function threadSafeValue.GetValueSafe <T>(self: ThreadSafeValue<T>): T
	self.Mutex:wait()
	return self.Value
end

--[[
	constructor
]]
function threadSafeValue.new <T>(value: T): ThreadSafeValue<T>
	local self: ThreadSafeValueStruct<T> = {
		Mutex = mutex.new(false),
		Value = value,
	}

	setmetatable(self, { __index = threadSafeValue })

	return self
end

return threadSafeValue
