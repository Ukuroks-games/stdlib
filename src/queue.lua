--[[
	# Очередь


]]
local queue = {}
queue.__index = queue

export type queue = typeof(setmetatable(
	{} :: {
		_data: {
			[number]: any
		}
	}, 
	queue
))

--[[
	Конструктор
]]
function queue.new(initData: {[number]: any}?): queue
	local self = setmetatable(
		{
			_data = initData or {}
		}, queue
	)

	return self
end

--[[
	Получить размер очереди
]]
function queue.size(self: queue): number
	return #self._data
end

--[[
	Пустая ли очередь
]]
function queue.empty(self: queue): boolean
	return self:size() == 0
end

--[[
	Добавить значнение в очередь
]]
function queue.push(self: queue, value: any)
	table.insert(self._data, value)
end

--[[
	Получить первый элемент очереди
]]
function queue.front(self: queue): any
	return self._data[1]
end

--[[
	Поолучить последний элемент очереди
]]
function queue.back(self: queue): any
	return self._data[#self._data]
end

--[[
	Удалить первый элемент из очереди
]]
function queue.pop(self: queue)
	table.remove(self._data, 1)
	table.insert(self._data, self._data[2])

	for i = 2, #self._data-1 do
		self._data[i] = self._data[i-1]
	end

	table.remove(self._data, #self._data)
end

return queue