local mutex = require("./mutex")

local threadSaveValue = {}

export type ThreadSaveValueStruct<T> = {
	Mutex: mutex.Mutex,
	Value: T,
}

export type ThreadSaveValue<T> = typeof(setmetatable(
	{} :: ThreadSaveValueStruct<T>,
	{ __index = threadSaveValue }
))

--[[

]]
function threadSaveValue.SetValue<T>(self: ThreadSaveValue<T>, NewValue)
	self.Mutex:wait()
	self.Mutex:lock()

	self.Value = NewValue

	self.Mutex:unlock()
end

--[[

]]
function threadSaveValue.GetValue<T>(self: ThreadSaveValue<T>): T
	return self.Value
end

--[[

]]
function threadSaveValue.GetValueSafe <T>(self: ThreadSaveValue<T>): T
	self.Mutex:wait()
	return self.Value
end

--[[
	constructor
]]
function threadSaveValue.new <T>(value: T): ThreadSaveValue<T>
	local self: ThreadSaveValueStruct<T> = {
		Mutex = mutex.new(false),
		Value = value,
	}

	setmetatable(self, { __index = threadSaveValue })

	return self
end

return threadSaveValue
