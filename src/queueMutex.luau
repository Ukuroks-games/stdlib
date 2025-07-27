local queueMutex = {}

export type QueueMutex = typeof(setmetatable(
	{} :: { stack: number, connect: BindableEvent },
	{ __index = queueMutex }
))

function queueMutex.lock (self: QueueMutex)
	self.stack += 1
end

function queueMutex.unlock (self: QueueMutex)
	self.stack -= 1
	if self.stack < 0 then
		self.stack = 0
	end
	if self.stack == 0 then
		self.connect:Fire()
	end
end

function queueMutex.wait (self: QueueMutex)
	if self.stack > 0 then
		self.connect.Event:Wait()
	end
end

function queueMutex.new (init: number?): QueueMutex
	local self = {
		stack = init or 0,
		connect = Instance.new("BindableEvent"),
	}

	setmetatable(self, { __index = queueMutex })

	return self
end

return queueMutex
